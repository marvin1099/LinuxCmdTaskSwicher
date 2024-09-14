#!/bin/bash

scriptdir=$(dirname "$0")
mfile+=$scriptdir/minimized.txt

# Get list of all window IDs from the NET_CLIENT_LIST_STACKING property
order=$(xprop -root | awk '/NET_CLIENT_LIST_STACKING\(WINDOW\)/ {gsub(",", ""); for(i=5;i<=NF;i++){print $i}}')

# Variables to store the focused window and the list of window IDs
focused="last"
window_ids=""

desktop=false
restore=true

# Process command-line arguments
for arg in "$@"; do
    case $arg in
        desktop=false)
            desktop=false
            ;;
        desktop=true)
            desktop=true
            ;;
        restore=false)
            restore=false
            ;;
        restore=true)
            restore=true
            ;;
        *)
            echo " Unknown argument: $arg"
            echo " Use:"
            echo "desktop=false"
            echo "desktop=true"
            echo " to dis/enable showing the destop"
            echo "restore=false"
            echo "restore=true"
            echo " to dis/enable restoring windows after the desktop was shown"
            exit
            ;;
    esac
done

# Loop through all windows
for w in $order
do
    # Get window information using xwininfo
    win=$(xwininfo -all -id $w 2>/dev/null)

    # Skip if the window is the Desktop, a Notification or a Dock
    if [[ $(echo $win | awk '/Window type: Dock/ || /Window type: Desktop/ || /Window type: Notification/') ]]
    then
        continue
    fi

    decimal_w=$(printf "%d" "$w")

    # Store window IDs
    window_ids+="$decimal_w"$'\n'

    # Remember vissible windows
    if [[ $(echo "$win" | awk '/Map State: IsViewable/') ]]
    then
        visible+="$decimal_w"$'\n'
        #echo "$win"
    fi

    # Check if the window is focused
    if [[ $(echo "$win" | awk '{if ($1 == "Focused" && NF == 1){print $1}}') ]]
    then
        focused=$decimal_w
    fi
done


visible=$(echo "$visible" | awk 'NF')

# Sort window IDs (sorting by window ID ensures consistent order)
sorted_windows=$(echo "$window_ids" | awk 'NF' | sort -n)

# Main loop to find and focus the next window
activation=false

while [[ $activation == false ]]; do
    found_focused=false
    next_window=""

    # Iterate through sorted windows to find the next window after the focused one
    while read -r wid; do
        if [[ $found_focused == true ]] && [[ $wid ]]; then
            next_window=$wid
            break
        fi
        if [[ $wid == $focused ]]; then
            found_focused=true
        fi
    done <<< "$sorted_windows"

    # If no next window is found, loop back to the first window
    if [[ -z $next_window ]]; then
        if [[ $desktop == true ]] && [[ $focused -ne "last" ]]
        then
            if [[ $restore == true ]] && [[ $desktop == true ]] && [[ $visible ]]
            then
                echo "$visible" > $mfile
            fi
            for v in $sorted_windows
            do
                xdotool windowminimize $v
            done
            activation=true
            continue
        elif [[ $restore == true ]] && [[ $desktop == true ]] && [[ $focused == "last" ]] && [[ -f $mfile ]]
        then
            visible=$(awk 'NF' $mfile)
            # restore windows last visible if it was requested
            if [[ $visible ]]
            then
                for f in $(echo "$visible" | tac)
                do
                    xdotool windowactivate $f
                done
                rm $mfile
                activation=true
                continue
            fi
            rm $mfile
            next_window=$(echo "$sorted_windows" | head -n 1)
        else
            next_window=$(echo "$sorted_windows" | head -n 1)
        fi
    fi

    # Attempt to focus the next window
    if [[ -n $next_window ]]; then
        error_message=$(xdotool windowactivate "$next_window" 2>&1 >/dev/null)

        # If xdotool succeeds, set activation to true
        if [[ $? -eq 0 ]] && [[ -z $error_message ]]; then
            activation=true
        else
            # If activation failed, move the focus to the next window and try again
            focused=$next_window
        fi
    fi
done
