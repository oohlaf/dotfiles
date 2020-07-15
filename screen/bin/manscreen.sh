#!/bin/sh
#
# Show a manual page in split window on the current screen.
# Optionally closes the window on exit.
#
# Use with the following option inside screenrc:
# bind y eval split 'focus down' "screen -t man $HOME/bin/manscreen -c -p"
# or use bindkey.
#
# TODO
# * Option -t to set window title to page name of query
# * Add always and never arguments to -p
#
# Author: Olaf Conradi
# Version: 0.1
# Last changed: 11 mar 2006

VERSION="0.1"
PROGNAME=${0##*/}

OPT_CLOSE="no"
OPT_EXIT_PROMPT="no"
DO_EXIT_PROMPT="no"

version()
{
	echo "$PROGNAME version $VERSION"
}

usage()
{
	echo "Usage: $PROGNAME [options]"
	echo
	echo "Asks for a manual page query and shows the result."
	echo "Sets the window title for screen and optionally closes the"
	echo "window on exit."
	echo
	echo "Available options:"
	echo "    -c    Close screen window on exit"
	echo "    -p    Prompt on exit on manual search and lookup queries"
	echo "    -h    Show this usage information"
	echo "    -V    Show the version information"
}

invalid_option()
{
	echo "$PROGNAME: invalid option \`$1\`" >&2
}

# Set title of current window to the first word of argument.
window_title()
{
	# Removes everything after a space.
	screen -X eval "title '${1%% *}'"
}

# Closes current window. The focus will be re-set to the calling window.
# This only works correctly if the caller moved the focus down.
window_close()
{
	# To work around a window drawing bug, kill it before closing.
	screen -X eval kill remove 'focus up'
}

# Parse command line options.
while getopts :hVcp var
do
	case "$var" in
		h)
			usage
			exit
			;;
		V)
			version
			exit
			;;
		c)
			OPT_CLOSE="yes"
			;;
		p)
			OPT_EXIT_PROMPT="yes"
			;;
		*)
			invalid_option "-$var"
			exit 1
			;;
	esac
done

window_title "man"

echo "Manual page viewer"
echo "    Enter the name(s) of the manual page(s) to view; or"
echo "    -k keyword    Search for keyword in manuals descriptions (apropos)"
echo "    -f keyword    Lookup keyword in manual descriptions (whatis)"
echo
read -p "What manual page do you want? " query

if [ "$OPT_EXIT_PROMPT" = "yes" ]; then
	# If option -k or -f is passed to man,
	# don't immediately close the window on exit.
	for var in $query; do
		case "$var" in
			-[kf])
				DO_EXIT_PROMPT="yes"
				;;
		esac
	done
fi

clear
# Only show manual on query input.
if [ "${#query}" -gt 0 ]; then
	man $query
	# Prompt on error.
	if [ "$?" -gt 0 ]; then
		DO_EXIT_PROMPT="yes"
	fi
fi

if [ "$DO_EXIT_PROMPT" = "yes" ]; then
	read -p "Press 'enter' key to exit..." var
fi

if [ "$OPT_CLOSE" = "yes" ]; then
	window_close
fi
