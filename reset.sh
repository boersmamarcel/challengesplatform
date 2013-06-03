#!/bin/bash

s=false
b=false
h=false

while getopts ":sbh" opt; do
	case $opt in
		s)
			s=true >&2
		;;
		b)
			b=true >&2
		;;
		h)
			h=true >&2
		;;
		\?)
			echo "Invalid option: -$OPTARG"
			echo "$0 -h for help"
			exit 1
		;;
	esac
done

if $h; then
	echo "Call $0 to reset the environment."
	echo "     -b to execute bundle as well"
	echo "     -s to execute rails s when done resetting"
	echo "     -h you're looking at it (and terminate)"
	exit 0
fi

if $b; then
	bundle install
fi

rake db:reset
rake db:test:prepare

if $s; then
	rails s
fi