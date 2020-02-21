#!/bin/sh

COLOR=$(whiptail --inputbox "What is your favorite Color?" 8 78 Blue --title "Example Dialog" 3>&1 1>&2 2>&3)
                                                                        # A trick to swap stdout and stderr.
# Again, you can pack this inside if, but it seems really long for some 80-col terminal users.
exitstatus=$?
if [ $exitstatus = 0 ]; then
    echo "User selected Ok and entered " $COLOR
else
    echo "User selected Cancel."
fi

echo "(Exit status was $exitstatus)"