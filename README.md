# LinuxCmdTaskSwicher

This is a simple script I use with xbindkeys  
to swich between tasks with one keykombination  
it just swiches to the next task based on time that it was opened  

Main Repo: https://codeberg.org/marvin1099/LinuxCmdTaskSwicher  
Backup Repo: https://github.com/marvin1099/LinuxCmdTaskSwicher  

# Install 

To use this script ou need to install:  
    ```xdotool, xorg-xprop, xorg-xwininfo```  
If you want to get notified on the desktop you also need the  
"**notify-send**" command or you need to replace it in the script  
Then you just download the script on one of these options:  
Main Repo: https://codeberg.org/marvin1099/LinuxCmdTaskSwicher/releases  
Backup Repo: https://github.com/marvin1099/LinuxCmdTaskSwicher/releases  

# Usage

To use it just run it in bash or add it in as a shortcut (For example in xbindkeys).  
You can tell the script to show the Desktop after all programms are opened.  
Also you can tell it to show desktop notifications (You need the "**notify-send**" comand for that).  
The syntax is:  
    ```./SwitchOpenWindows.sh "Here-true-IfYouWantToShowDesktopOtherwise-false-" "Here-true-IfYouWantToShowNDesktopNotificationsOtherwise-false-"```  
You can also just use:  
    ```./SwitchOpenWindows.sh```  
and change the to start options in the script.  
By default both of these options are set to false.
