#!/bin/bash

TITLE="User Manager"

add_user() {
    username=$(whiptail --inputbox "Enter new username:" 8 40 --title "Add User" 3>&1 1>&2 2>&3) || return
    password=$(whiptail --passwordbox "Enter password:" 8 40 --title "Add User" 3>&1 1>&2 2>&3)  || return

    [[ -z "$username" ]] && msg "Username cannot be empty." && return

    if id "$username" &>/dev/null; then
        whiptail --msgbox "User '$username' already exists!" 8 40 --title "Error"
        return
    fi

    useradd -m "$username" && echo "$username:$password" | chpasswd
    whiptail --msgbox "User '$username' added successfully." 8 40 --title "Done"
}

modify_user() {
    username=$(whiptail --inputbox "Enter username to modify:" 8 40 --title "Modify User" 3>&1 1>&2 2>&3) || return

    if ! id "$username" &>/dev/null; then
        whiptail --msgbox "User '$username' not found!" 8 40 --title "Error"
        return
    fi

    choice=$(whiptail --menu "What to modify?" 12 50 3 \
        "1" "Change username" \
        "2" "Change home directory" \
        "3" "Change shell" \
        --title "Modify User" 3>&1 1>&2 2>&3) || return

    case $choice in
        1)
            newname=$(whiptail --inputbox "Enter new username:" 8 40 --title "Modify User" 3>&1 1>&2 2>&3) || return
            usermod -l "$newname" "$username"
            whiptail --msgbox "Username changed to '$newname'." 8 40 --title "Done"
            ;;
        2)
            newhome=$(whiptail --inputbox "Enter new home directory:" 8 40 --title "Modify User" 3>&1 1>&2 2>&3) || return
            usermod -d "$newhome" -m "$username"
            whiptail --msgbox "Home directory changed to '$newhome'." 8 40 --title "Done"
            ;;
        3)
            newshell=$(whiptail --inputbox "Enter new shell (e.g. /bin/bash):" 8 40 --title "Modify User" 3>&1 1>&2 2>&3) || return
            usermod -s "$newshell" "$username"
            whiptail --msgbox "Shell changed to '$newshell'." 8 40 --title "Done"
            ;;
    esac
}

delete_user() {
    username=$(whiptail --inputbox "Enter username to delete:" 8 40 --title "Delete User" 3>&1 1>&2 2>&3) || return

    if ! id "$username" &>/dev/null; then
        whiptail --msgbox "User '$username' not found!" 8 40 --title "Error"
        return
    fi

    whiptail --yesno "Delete user '$username' and their home directory?" 8 50 --title "Confirm" || return
    userdel -r "$username" 2>/dev/null
    whiptail --msgbox "User '$username' deleted." 8 40 --title "Done"
}

list_users() {
    users=$(awk -F: '$3 >= 1000 && $1 != "nobody" {print $1 " (UID:" $3 ")"}' /etc/passwd)
    whiptail --msgbox "${users:-No regular users found.}" 20 50 --title "System Users"
}

add_group() {
    groupname=$(whiptail --inputbox "Enter new group name:" 8 40 --title "Add Group" 3>&1 1>&2 2>&3) || return

    if getent group "$groupname" &>/dev/null; then
        whiptail --msgbox "Group '$groupname' already exists!" 8 40 --title "Error"
        return
    fi

    groupadd "$groupname"
    whiptail --msgbox "Group '$groupname' added successfully." 8 40 --title "Done"
}

modify_group() {
    groupname=$(whiptail --inputbox "Enter group name to modify:" 8 40 --title "Modify Group" 3>&1 1>&2 2>&3) || return

    if ! getent group "$groupname" &>/dev/null; then
        whiptail --msgbox "Group '$groupname' not found!" 8 40 --title "Error"
        return
    fi

    choice=$(whiptail --menu "What to modify?" 10 50 2 \
        "1" "Rename group" \
        "2" "Add user to group" \
        --title "Modify Group" 3>&1 1>&2 2>&3) || return

    case $choice in
        1)
            newname=$(whiptail --inputbox "Enter new group name:" 8 40 --title "Modify Group" 3>&1 1>&2 2>&3) || return
            groupmod -n "$newname" "$groupname"
            whiptail --msgbox "Group renamed to '$newname'." 8 40 --title "Done"
            ;;
        2)
            username=$(whiptail --inputbox "Enter username to add:" 8 40 --title "Modify Group" 3>&1 1>&2 2>&3) || return
            usermod -aG "$groupname" "$username"
            whiptail --msgbox "User '$username' added to '$groupname'." 8 40 --title "Done"
            ;;
    esac
}

delete_group() {
    groupname=$(whiptail --inputbox "Enter group name to delete:" 8 40 --title "Delete Group" 3>&1 1>&2 2>&3) || return

    if ! getent group "$groupname" &>/dev/null; then
        whiptail --msgbox "Group '$groupname' not found!" 8 40 --title "Error"
        return
    fi

    whiptail --yesno "Delete group '$groupname'?" 8 40 --title "Confirm" || return
    groupdel "$groupname"
    whiptail --msgbox "Group '$groupname' deleted." 8 40 --title "Done"
}

list_groups() {
    groups=$(awk -F: '{print $1 " (GID:" $3 ")"}' /etc/group)
    whiptail --msgbox "${groups:-No groups found.}" 30 50 --title "System Groups" --scrolltext
}

disable_user() {
    username=$(whiptail --inputbox "Enter username to lock:" 8 40 --title "Disable User" 3>&1 1>&2 2>&3) || return

    if ! id "$username" &>/dev/null; then
        whiptail --msgbox "User '$username' not found!" 8 40 --title "Error"
        return
    fi

    usermod -L "$username"
    whiptail --msgbox "User '$username' has been locked." 8 40 --title "Done"
}

enable_user() {
    username=$(whiptail --inputbox "Enter username to unlock:" 8 40 --title "Enable User" 3>&1 1>&2 2>&3) || return

    if ! id "$username" &>/dev/null; then
        whiptail --msgbox "User '$username' not found!" 8 40 --title "Error"
        return
    fi

    usermod -U "$username"
    whiptail --msgbox "User '$username' has been unlocked." 8 40 --title "Done"
}

change_password() {
    username=$(whiptail --inputbox "Enter username:" 8 40 --title "Change Password" 3>&1 1>&2 2>&3) || return

    if ! id "$username" &>/dev/null; then
        whiptail --msgbox "User '$username' not found!" 8 40 --title "Error"
        return
    fi

    password=$(whiptail --passwordbox "Enter new password:" 8 40 --title "Change Password" 3>&1 1>&2 2>&3) || return
    echo "$username:$password" | chpasswd
    whiptail --msgbox "Password for '$username' changed successfully." 8 50 --title "Done"
}

about() {
    whiptail --msgbox "User & Group Manager\n\nA whiptail project\nfor managing Linux users and groups.\n\nDeveloped by Omar Hesham." \
        12 45 --title "About"
}

while true; do
    choice=$(whiptail --menu "" 20 60 12 \
        "Add User"       "Add a user to the system." \
        "Modify User"    "Modify an existing user." \
        "Delete User"    "Delete an existing user." \
        "List Users"     "List all users on the system." \
        "Add Group"      "Add a user group to the system." \
        "Modify Group"   "Modify a group and its members." \
        "Delete Group"   "Delete an existing group." \
        "List Groups"    "List all groups on the system." \
        "Disable User"   "Lock the user account." \
        "Enable User"    "Unlock the user account." \
        "Change Password" "Change Password of a user." \
        "About"          "Information about this program." \
        --title "Main Menu" 3>&1 1>&2 2>&3) || break

    case "$choice" in
        "Add User")       add_user ;;
        "Modify User")    modify_user ;;
        "Delete User")    delete_user ;;
        "List Users")     list_users ;;
        "Add Group")      add_group ;;
        "Modify Group")   modify_group ;;
        "Delete Group")   delete_group ;;
        "List Groups")    list_groups ;;
        "Disable User")   disable_user ;;
        "Enable User")    enable_user ;;
        "Change Password") change_password ;;
        "About")          about ;;
    esac
done
