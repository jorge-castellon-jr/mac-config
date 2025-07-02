#!/usr/bin/env sh

sketchybar --add event aerospace_workspace_change
RED=0xffed8796

# Function to get custom label for workspace ID
get_custom_label() {
    local sid="$1"
    case "$sid" in
        "y") echo "L2" ;;
        "u") echo "L1" ;;
        "o") echo "R1" ;;
        "p") echo "R2" ;;
        *) echo "$sid" ;;  # For regular numbered workspaces, keep the number
    esac
}

# Function to get order priority for workspace ID (for sorting)
get_order_priority() {
    local sid="$1"
    case "$sid" in
        # Main monitor workspaces (1-7) come first in their natural order
        [1-9]) echo "1$sid" ;;
        # Left monitor workspaces next
        "u") echo "20" ;;  # L1
        "y") echo "21" ;;  # L2
        # Right monitor workspaces last
        "o") echo "30" ;;  # R1
        "p") echo "31" ;;  # R2
        *) echo "99" ;;    # Others
    esac
}

# Get all workspaces and sort them based on our custom order
all_spaces=$(aerospace list-workspaces --all)
ordered_spaces=""

# Build the ordered list
for priority in $(seq 1 99); do
    for sid in $all_spaces; do
        if [ "$(get_order_priority "$sid")" = "$priority" ]; then
            ordered_spaces="$ordered_spaces $sid"
        fi
    done
done

# Create workspace items in the ordered sequence
for sid in $ordered_spaces; do
    custom_label=$(get_custom_label "$sid")
    
    sketchybar --add item "space.$sid" left \
        --subscribe "space.$sid" aerospace_workspace_change \
        --set "space.$sid" \
        icon="$custom_label"\
                              icon.padding_left=12                          \
                              icon.padding_right=12                         \
                              icon.width=30                                 \
                              icon.color=$WHITE                             \
                              icon.highlight_color=$RED                     \
                              icon.align=center                             \
                              background.color=0x44ffffff \
                              background.corner_radius=5 \
                              background.height=30 \
                              background.width=20 \
                              background.drawing=off                         \
                              label.font="sketchybar-app-font:Regular:16.0" \
                              label.background.height=30                    \
                              label.background.drawing=on                   \
                              label.background.color=0xff494d64             \
                              label.background.corner_radius=9              \
                              label.drawing=off                             \
        click_script="aerospace workspace $sid" \
        script="$CONFIG_DIR/plugins/aerospacer.sh $sid"
done

sketchybar   --add item       separator left                          \
             --set separator  icon=                                  \
                              icon.font="Hack Nerd Font:Regular:16.0" \
                              background.padding_left=15              \
                              background.padding_right=15             \
                              label.drawing=off                       \
                              associated_display=active               \
                              icon.color=$WHITE
