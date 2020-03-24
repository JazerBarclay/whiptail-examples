# Whiptail Examples

*Please download/clone this repository and have a play around with the examples*<br>
*Check the manual on https://linux.die.net/man/1/whiptail or run ``man whiptail`` from your terminal for all the juicy details*

## What is Whiptail?
Whiptail is a program that displays information and input prompts which can be used within the terminal. It works as a drop-in alternative to the ``dialog`` command. I have included use cases as individual runnable scripts and a breakdown in this README document below.

## Installing Whiptail
### Ubuntu
```
sudo apt install whiptail
```

### Arch
```
sudo pacman -S libnewt
```

## Download and use this repo
```
# Download the repository
git clone https://github.com/JazerBarclay/whiptail-examples.git

# Open the folder with the examples
cd whiptail-examples

# Set all the example scripts to runnable (check the files before running them)
chmod +x check-list.sh input-box.sh message-box.sh progress-bar.sh yes-no.sh info-dialog.sh menu.sh password-box.sh radio-list.sh text-box.sh

# You're all good to go and break things!
```

## Examples
### Info box
The info box is a simple type of dialog box of text that displays to the user.

```
whiptail --title "Example Title" --infobox "This is an example info box." 8 70
```

In this example, ``title`` is displayed at the top of the box . The ``infobox`` is the dialog body and the final two arguments are the height and width of the box.

There is a bug that makes the Info Box not display on some shells. If this is the case you can set the terminal emulation to something different and it will work.

```
TERM=ansi whiptail --title "Example Title" --infobox "This is an example info box" 8 70
```


### Message box
The message box is very similar to the info box however awaits the user to hit the OK button to continue past the prompt.

```
whiptail --title "Example Title" --msgbox "This is an example message box. Press OK to continue." 8 70
```

### Yes/no box
The yes/no input does what it says on the tin. It displays a prompt with the options of yes or no.

```
# A simple if/then to do different things based on if yes or no is pressed

if (whiptail --title "Example Title" --yesno "This is an example yes/no box." 8 70); then
    echo "YES"
else
    echo "NO"
fi
```


### Input box
The input box adds an input field for text to be typed. If the user presses enter, the OK button is pressed. If the user selects Cancel then 

```
COLOR=$(whiptail --inputbox "What is your favorite Color?" 8 78 Blue --title "Example Dialog" 3>&1 1>&2 2>&3)
# The `3>&1 1>&2 2>&3` is a small trick to swap the stderr with stdout
# Meaning instead of return the error code, it returns the value entered
# A trick to swap stdout and stderr.

# Now to check if the user pressed OK or Cancel
exitstatus=$?
if [ $exitstatus = 0 ]; then
    echo "User selected Ok and entered " $COLOR
else
    echo "User selected Cancel."
fi

echo "(Exit status was $exitstatus)"
```

### Text box
A text box is similar to the message box however gets the body of text from a specified file. Add --scrolltext if the file is longer than the displayed window.

```
echo "Welcome to Bash $BASH_VERSION" > test_textbox

# filename height width
whiptail --textbox test_textbox 12 80
```


### Password box
A password box is an input box with the characters displayed as asterisks to hide your input.

```
PASSWORD=$(whiptail --passwordbox "Enter your new password" 8 70 --title "New Password" 3>&1 1>&2 2>&3)

exitstatus=$?
if [ $exitstatus = 0 ]; then
    echo "User selected Ok and entered " $PASSWORD
else
    echo "User selected Cancel."
fi

echo "(Exit status was $exitstatus)"

```


### Menus
The menu dialog can show a list of items that the user can select a single item from. The additional value ``16`` beside the height and width is the total rows displayable before the menu becomes scrollable.

```
whiptail --title "Menu example" --menu "Choose an option" 25 78 16 \
"<-- Back" "Return to the main menu." \
"Add User" "Add a user to the system." \
"Modify User" "Modify an existing user." \
"List Users" "List all users on the system." \
"Add Group" "Add a user group to the system." \
"Modify Group" "Modify a group and its list of members." \
"List Groups" "List all groups on the system."
```

The values are a list of menu options in the format ``tag item``, where tag is the name of the option which is printed to stderr when selected, and item is the description of the menu option.

If you are presenting a very long menu and want to make best use of the available screen, you can calculate the best box size by.

```
eval `resize`
whiptail ... $LINES $COLUMNS $(( $LINES - 8 )) ...
```

### Check list
The check list dialog is a multi-selectable menu where a single or multiple items in the list can be selected

```
whiptail --title "Check list example" --checklist \
"Choose user's permissions" 20 78 4 \
"NET_OUTBOUND" "Allow connections to other hosts" ON \
"NET_INBOUND" "Allow connections from other hosts" OFF \
"LOCAL_MOUNT" "Allow mounting of local devices" OFF \
"REMOTE_MOUNT" "Allow mounting of remote devices" OFF
```

When the user confirms their selections, a list of the choices is printed to stderr.

### Radio list
A radio list is a dialog where the user can select one option from a list. The difference between a radio list and a menu is that the user selects an option (using the space bar in whiptail) and then confirms that choice by hitting OK.

```
whiptail --title "Radio list example" --radiolist \
"Choose user's permissions" 20 78 4 \
"NET_OUTBOUND" "Allow connections to other hosts" ON \
"NET_INBOUND" "Allow connections from other hosts" OFF \
"LOCAL_MOUNT" "Allow mounting of local devices" OFF \
"REMOTE_MOUNT" "Allow mounting of remote devices" OFF
```

### Progress gauge
`Syntax: whiptail --gauge <text> <height> <width> [<percent>]`

Also reads percent from stdin:

```
#!/bin/bash
{
    for ((i = 0 ; i <= 100 ; i+=5)); do
        sleep 0.1
        echo $i
    done
} | whiptail --gauge "Please wait while we are sleeping..." 6 50 0
```
