#!/bin/sh

# the script will not work if xrandr is not available
if [ -z "$(which xrandr)" ]; then
    exit 1
fi

TO_DISABLE=""
PRIMARY_OUT=""

INTERNAL_SUBSTRING="eDP"
PRIMARY_INTERNAL=""
FIRST=""

old_IFS="${IFS}"
IFS=$'\n'
for out in `xrandr | grep connected | cut -d ' ' -f 1-2`; do
  name=`echo $out | cut -d ' ' -f 1`
  state=`echo $out | cut -d ' ' -f 2`

  if [ "$state" = "connected" ]; then
    isInternal=false

    case "$name" in
      ${INTERNAL_SUBSTRING}*)
        isInternal=true

        if [ -z "$FIRST" ]; then
          FIRST="$name"
        fi

        if [ -z "$PRIMARY_INTERNAL" ]; then
          PRIMARY_INTERNAL="$name"
        fi
        ;;
      *)

      if [ -z "$FIRST" ]; then
        FIRST="$name"
      fi

      # set the 'first' external monitor as the
      # primary one, disable the other external monitors
      if [ -z "$PRIMARY_OUT" ] && [ "$isInternal" = false ]; then
        PRIMARY_OUT="$name"
      else
        xrandr --output "$name" --off
      fi
      ;;
    esac
  fi
done
IFS="${old_IFS}"

# If there is an internal screen, as well as at least one external monitor, then
# disable the internal monitor and use the external monitor as the primary one.
#
# Otherwise, if there are any external monitors, use the 'first' detected one
# as the primary monitor.
if [ -n "$PRIMARY_OUT" ]; then
  xrandr --output "$PRIMARY_OUT" --primary --auto
elif [ -n "$PRIMARY_INTERNAL" ]; then
  xrandr --output "$PRIMARY_INTERNAL" --primary --auto
else
  xrandr --output "$FIRST" --primary --auto
fi

# Disable internal if primary exist
if [ -n "$PRIMARY_OUT" ] && [ -n "$PRIMARY_INTERNAL" ]; then
  xrandr --output "$PRIMARY_INTERNAL" --off
fi

exit 0

