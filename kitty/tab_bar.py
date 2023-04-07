import getpass
import math
import socket
from pathlib import Path
from typing import Any, Dict, Optional

from paramiko import SSHConfig

from kittens.ssh.main import get_connection_data
from kitty.fast_data_types import Color, Screen, get_boss
from kitty.tab_bar import Dict, DrawData, ExtraData, TabBarData, as_rgb, draw_title
from kitty.utils import color_as_int

# Path to SSH config file (should be standard), needed to lookup host names and retrieve
# corresponding user names
SSH_CONFIG_FILE = "~/.ssh/config"

# Whether to add padding to title of tabs
PADDED_TABS = False

# Whether to draw a separator between tabs
DRAW_SOFT_SEP = True

# Whether to draw right-hand side status information inside of filled shapes
RHS_STATUS_FILLED = True

# Separators and status icons
LEFT_SEP = ""
RIGHT_SEP = ""
SOFT_SEP = "│"
PADDING = " "
BRANCH_ICON = "󰘬"
USER_ICON = ""
HOST_ICON = "󱡶"

# Colors
SOFT_SEP_COLOR = Color(89, 89, 89)
FILLED_ICON_BG_COLOR = Color(89, 89, 89)
ACCENTED_BG_COLOR = Color(30, 104, 199)
ACCENTED_ICON_BG_COLOR = Color(53, 132, 228)

MIN_TAB_LEN = (
    len(LEFT_SEP) + len(RIGHT_SEP) +  # separators
    len(PADDING) * 2 * PADDED_TABS +  # padding
    1 + 1 + 1 + 1 +                   # tab symbol, space, index number, space
    1                                 # one title character
)


def _draw_element(
    element: DrawData | str,
    screen: Screen,
    tab: TabBarData,
    before: int,
    max_tab_length: int,
    index: int,
    colors: Dict[str, int],
    filled: bool = False,
    padded: bool = False,
    accented: bool = False,
    icon: Optional[str] = None,
    soft_sep: Optional[str] = None,
) -> None:
    # When max_tab_length < MIN_TAB_LEN, we just draw an ellipsis, without separators or
    # anything else, so that it's clear that one either needs a larger max_tab_length,
    # or another tab bar design
    if max_tab_length < MIN_TAB_LEN:
        screen.draw("…".center(max_tab_length))
        return

    if accented:
        text_fg = colors["accented_fg"]
        text_bg = colors["accented_bg"]
        icon_bg = colors["accented_icon_bg"]
    elif filled:
        text_fg = colors["filled_fg"]
        text_bg = colors["filled_bg"]
        icon_bg = colors["filled_icon_bg"] if icon else colors["filled_bg"]
    else:
        text_fg = colors["fg"]
        text_bg = colors["bg"]
        icon_bg = colors["bg"]

    # Left separator, left padding, icon
    left_components = list()
    left_components.append((LEFT_SEP, icon_bg, colors["bg"]))
    if padded:
        left_components.append((PADDING, text_fg, text_bg))
    if icon:
        left_components.append((f"{icon}{PADDING}", text_fg, icon_bg))
        if filled:
            left_components.append((PADDING, text_fg, text_bg))
    for c in left_components:
        screen.cursor.fg = c[1]
        screen.cursor.bg = c[2]
        screen.draw(c[0])

    # Title
    screen.cursor.fg = text_fg
    screen.cursor.bg = text_bg
    if isinstance(element, DrawData):
        draw_title(element, screen, tab, index)
        max_cursor_x = before + max_tab_length - len(LEFT_SEP) - len(PADDING)
        if screen.cursor.x > max_cursor_x:
            screen.cursor.x = max_cursor_x - 1
            screen.draw("…")
    else:
        screen.draw(element)

    # Right padding, right separator, inter-tab soft separator
    right_components = list()
    if padded:
        right_components.append((PADDING, text_fg, text_bg))
    right_components.append((RIGHT_SEP, text_bg, colors["bg"]))
    if soft_sep:
        right_components.append((soft_sep, colors["soft_sep_fg"], colors["bg"]))
    for c in right_components:
        screen.cursor.fg = c[1]
        screen.cursor.bg = c[2]
        screen.draw(c[0])


def _get_system_info() -> Dict[str, Any]:
    window = get_boss().active_window

    # Local info (and fallback for errors on remote info)
    user = getpass.getuser()
    host = socket.gethostname()
    is_ssh = False

    # The following variable is not an empty list in case we're running the ssh kitten
    ssh_cmdline = window.ssh_kitten_cmdline()

    if ssh_cmdline != []:
        is_ssh = True
        conn_data = get_connection_data(ssh_cmdline)
        if conn_data:
            conn_data_hostname = conn_data.hostname
            user_and_host = conn_data_hostname.split("@")
            # When only a host is specified on the command line, we try to lookup the
            # corresponding user in the SSH config file
            if len(user_and_host) == 1:
                host = user_and_host[0]
                config_fpath = str(Path(SSH_CONFIG_FILE).expanduser())
                host_config = SSHConfig.from_path(config_fpath).lookup(host)
                if "user" in host_config:
                    user = host_config["user"]
            # When the command line specifies both host and user, we just use these
            elif len(user_and_host) == 2:
                user, host = user_and_host
            else:
                print("Could not parse user and host name")
        else:
            print("Could not retrieve SSH connection data")

    return {"user": user, "host": host, "is_ssh": is_ssh}


def _get_git_info() -> Dict[str, Any]:
    return {"branch": "main"}


def draw_tab(
    draw_data: DrawData,
    screen: Screen,
    tab: TabBarData,
    before: int,
    max_tab_length: int,
    index: int,
    is_last: bool,
    extra_data: ExtraData,
) -> int:
    """Draw tab.

    Args:
        draw_data (DrawData): Tab context.
        screen (Screen): Screen objects.
        tab (TabBarData): Tab bar context.
        before (int): Current cursor position, before drawing tab.
        max_tab_length (int): User-specified maximum length of tab.
        index (int): Tab index.
        is_last (bool): Whether this is the last tab to draw.
        extra_data (ExtraData): Additional context.

    Returns:
        int: Cursor positions after drawing current tab.
    """

    colors = {}

    # Base foreground and background colors
    colors["fg"] = as_rgb(color_as_int(draw_data.inactive_fg))
    colors["bg"] = as_rgb(color_as_int(draw_data.default_bg))

    # Foreground, background and icon background colors for filled tabs
    colors["filled_fg"] = as_rgb(color_as_int(draw_data.active_fg))
    colors["filled_bg"] = as_rgb(color_as_int(draw_data.active_bg))
    colors["filled_icon_bg"] = as_rgb(color_as_int(FILLED_ICON_BG_COLOR))

    # Foreground, background and icon background colors for accented tabs
    colors["accented_fg"] = as_rgb(color_as_int(draw_data.active_fg))
    colors["accented_bg"] = as_rgb(color_as_int(ACCENTED_BG_COLOR))
    colors["accented_icon_bg"] = as_rgb(color_as_int(ACCENTED_ICON_BG_COLOR))

    # Inter-tab separator color
    colors["soft_sep_fg"] = as_rgb(color_as_int(SOFT_SEP_COLOR))

    soft_sep = None
    if DRAW_SOFT_SEP:
        if extra_data.next_tab:
            both_inactive = not tab.is_active and not extra_data.next_tab.is_active
            soft_sep = SOFT_SEP if both_inactive else PADDING

    # Draw main tabs
    _draw_element(
        draw_data,
        screen,
        tab,
        before,
        max_tab_length,
        index,
        colors,
        filled=tab.is_active,
        padded=PADDED_TABS,
        soft_sep=soft_sep,
    )

    end = screen.cursor.x

    # Draw right-hand side status
    if is_last:
        system_info = _get_system_info()
        git_info = _get_git_info()
        elements = [
            # (git_info["branch"], BRANCH_ICON, False),
            (system_info["user"], USER_ICON, system_info["is_ssh"]),
            (system_info["host"], HOST_ICON, system_info["is_ssh"]),
        ]
        # Move cursor horizontally so that right-hand side status is right-aligned
        rhs_status_len = 0
        for element in elements:
            rhs_status_len += len(element[1])  # icon
            rhs_status_len += len(PADDING)  # icon padding
            rhs_status_len += len(element[0])  # text
            rhs_status_len += 2  # separators
            if RHS_STATUS_FILLED:
                rhs_status_len += len(PADDING)  # text padding
        rhs_status_len += len(elements) - 1  # soft separators
        screen.cursor.x = math.ceil(screen.columns / 2 + end / 2) - rhs_status_len
        for element in elements:
            _draw_element(
                element[0],
                screen,
                tab,
                before,
                100,
                index,
                colors,
                filled=RHS_STATUS_FILLED,
                padded=False,
                accented=element[2],
                icon=element[1],
                soft_sep=PADDING,
            )

    return end
