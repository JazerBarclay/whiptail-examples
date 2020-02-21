#!/bin/sh

PASSWORD=$(whiptail --passwordbox "please enter your secret password" 8 78 --title "password dialog" 3>&1 1>&2 2>&3)
                                                                        # A trick to swap stdout and stderr.
# Again, you can pack this inside if, but it seems really long for some 80-col terminal users.
exitstatus=$?
if [ $exitstatus = 0 ]; then
    echo "User selected Ok and entered " $PASSWORD
else
    echo "User selected Cancel."
fi

echo "(Exit status was $exitstatus)"