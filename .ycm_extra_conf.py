# YCM extra configuration file
# based on https://github.com/JDevlieghere/dotfiles/blob/master/.vim/.ycm_extra_conf.py
# and https://raw.githubusercontent.com/Valloric/ycmd/66030cd94299114ae316796f3cad181cac8a007c/.ycm_extra_conf.py

import os
import logging
import ycm_core


SOURCE_EXTENSIONS  = ['.c', '.cpp', '.cxx', '.cc', '.m', '.mm']
HEADER_EXTENSIONS  = ['.h', '.hpp', '.hxx', '.hh']

SOURCE_DIRECTORIES = ['source', 'src']
HEADER_DIRECTORIES = ['include', 'inc']

INCLUDE_FLAGS = ['-I', '--include=', '-isystem', '-iquote', '--sysroot=']

BASE_FLAGS = ['-Wall']


def IsHeaderFile(filename):
    """Check is given file is a header."""

    extension = os.path.splitext(filename)[1]
    return extension in HEADER_EXTENSIONS


def GetCompilationInfoForFile(database, filename):
    """Get compilation info."""

    if IsHeaderFile(filename):
        basename = os.path.splitext(filename)[0]
        for extension in SOURCE_EXTENSIONS:

            # Translate header files into their respective source files
            replacement = basename + extension
            if os.path.exists(replacement):
                info = database.GetCompilationInfoForFile(replacement)
                if info.compiler_flags_:
                    return info, replacement

            # Try in other directories
            for header_dir in HEADER_DIRECTORIES:
                for source_dir in SOURCE_DIRECTORIES:
                    src_file = replacement.replace(header_dir, source_dir)
                    if os.path.exists(src_file):
                        info = database.GetCompilationInfoForFile(src_file)
                        if info.compiler_flags_:
                            return info, src_file

        # Unsuccessful return
        return None

    # For non-header files
    return database.GetCompilationInfoForFile(filename), filename


def FindNearest(path, target):
    """Find nearest compilation database."""

    # Search for database in current directory
    candidate = os.path.join(path, target)
    if os.path.isfile(candidate):
        return candidate

    # Go up one directory
    parent = os.path.dirname(os.path.abspath(path))
    if parent == path:
        return None

    # Recursive call
    return FindNearest(parent, target)


def MakeRelativePathsInFlagsAbsolute(flags, working_directory):
    """Make relative paths in include directives absolute."""

    # Unsuccessful return
    if not working_directory:
        return list(flags)

    new_flags = []
    make_next_absolute = False

    # Loop through flags
    for flag in flags:
        new_flag = flag

        # Make relative path absolute
        if make_next_absolute:
            make_next_absolute = False
            if not flag.startswith('/'):
                new_flag = os.path.join(working_directory, flag)

        # Search for include directives
        for path_flag in INCLUDE_FLAGS:

            # Mark flags with whitespace between directive and path
            # (like -I path/to/headers)
            if flag == path_flag:
                make_next_absolute = True
                break

            # Make relative paths absolute for flags without whitespace
            # (like -Ipath/to/headers)
            if flag.startswith(path_flag):
                path = flag[ len(path_flag): ]
                new_flag = path_flag + os.path.join(working_directory, path)
                break

        # Populate list
        if new_flag:
            new_flags.append(new_flag)

    return new_flags


def FlagsForCompilationDatabase(root, filename):
    """Search for compilation flags."""

    try:
        # Find nearest compilation database
        db_path = FindNearest(root, 'compile_commands.json')
        if not db_path:
            return None, None

        # Get database from YCM
        db_dir = os.path.dirname(db_path)
        db = ycm_core.CompilationDatabase(db_dir)
        if not db:
            return None, None

        # Get compilation info
        info, translation_unit = GetCompilationInfoForFile(db, filename)
        if not info:
            return None, None

        # For include paths:
        # look at the path of the file currently opened in the editor
        # rather than the one from the configuration file
        flags = MakeRelativePathsInFlagsAbsolute(
                info.compiler_flags_,
                info.compiler_working_dir_
                )

        return flags, translation_unit

    except:
        return None, None


def FlagsForFile(filename):
    """Entry point for YCM."""

    # Search for flags
    root = os.path.realpath(filename)
    flags, translation_unit = FlagsForCompilationDatabase(root, filename)

    # Return flags, if found
    if flags:
        return {
                'flags': flags,
                'override_filename': translation_unit,
                'do_cache': True
                }
    # Otherwise, return fallback flags
    else:
        return {
                'flags': BASE_FLAGS
                }
