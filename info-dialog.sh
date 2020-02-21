#!/bin/sh

whiptail --title "Example Dialog" --infobox "This is an example of an info box." 8 78

## To fix emulators that don't keep the info box on the screen, we can use the following command
## TERM=ansi whiptail --title "Example Dialog" --infobox "This is an example of an info box" 8 78
