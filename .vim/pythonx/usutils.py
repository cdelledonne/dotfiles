import os
import re


# Constant strings
PLACEHOLDER_STRING = "[description]"
PARAMETER_TAG      = "@param"
RETURN_TAG         = "@return"
VOID_TYPES         = ['void', 'VOID']


def IsFunctionSignature(line):
    """Check if next line matches function signature."""

    regex = "^\s*(\w+\s)*\w+\([^)]*\)"
    return re.match(regex, line)


def GetParamComment(function, placeholder_count):
    """Build comment string for function parameters."""

    comment_string = ''

    # Find arguments
    arg_start = function.find('(') + 1
    arg_end = function.find(')')
    args = function[arg_start:arg_end].split(',')

    # Check if there's at least one argument and parameter names are present
    if len(args) > 0 and len(args[0].split()) == 2:

        # Insert blank line
        comment_string += os.linesep + " *"

        # Extract parameter names
        params = []
        for arg in args:
            params.append(arg.split()[1])

        # Compute length of longest parameter
        l_max = len(max(params, key=len))

        # Build param lines
        for param in params:
            spaces = (l_max - len(param) + 1) * ' '
            comment_string += os.linesep
            placeholder_count += 1
            comment_string += " * " + PARAMETER_TAG + " " + param + spaces + \
                              "${" + str(placeholder_count) + \
                              ":" + PLACEHOLDER_STRING + "}"

    return comment_string, placeholder_count


def GetReturnComment(function, placeholder_count):
    """Build comment string for function return value."""

    comment_string = ''

    # Find attributes
    attr_end = function.find('(')
    attributes = function[0:attr_end].split()[0:-1]

    # Check if function is void
    if len([a for a in attributes if a in VOID_TYPES]) == 0:

        # Insert blank line
        comment_string += os.linesep
        comment_string += " *"

        # Insert return line
        comment_string += os.linesep
        placeholder_count += 1
        comment_string += " * " + RETURN_TAG + " " \
                          "${" + str(placeholder_count) + \
                          ":" + PLACEHOLDER_STRING + "}"

    return comment_string


def CommentFunction(function):
    """Build complete comment string."""

    placeholder_count = 1

    # Description field, with placeholder
    description_str = " * " + "${" + str(placeholder_count) + \
                      ":" + PLACEHOLDER_STRING + "}"

    # Parameters, with placeholder(s)
    parameters_str, placeholder_count = GetParamComment(function, placeholder_count)

    # Return value, with placeholder
    return_str = GetReturnComment(function, placeholder_count)

    # Comment delimiters
    comment_start = "/**" + os.linesep
    comment_end = os.linesep + " */"

    return comment_start + description_str + parameters_str + return_str + comment_end
