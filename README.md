# 🖥️ User & Group Manager

> 🐚 A chill terminal tool for managing Linux users & groups — built with **Bash** + **whiptail**
> 
> 👨‍💻 Developed by **Omar Hesham**

---

## 📚 Table of Contents

- [Overview](#-overview)
- [Features](#-features)
- [Requirements](#-requirements)
- [Installation & Usage](#-installation--usage)
- [Menu Options](#-menu-options)
- [Project Structure](#-project-structure)
- [Commands Reference](#-commands-reference)
- [Author](#-author)

---

## 🌟 Overview

No more memorizing long Linux commands! This script gives you a clean, interactive menu right in your terminal — powered by **whiptail**. Just pick what you want to do and the script handles the rest. Every action has validation and confirmation dialogs so you don't accidentally break anything 😅

![Menu](https://github.com/OmarHesham249/Bash-Script-Project/blob/main/Bash%20project/Menu%20Image.png)

---

## ✨ Features

### 👤 User Management

| Feature | Description |
|---|---|
| ➕ Add User | Create a new user with a home directory and password |
| ✏️ Modify User | Rename, change home directory, or change login shell |
| 🗑️ Delete User | Remove a user and their home directory |
| 📋 List Users | Display all regular system users (UID ≥ 1000) |
| 🔒 Disable User | Lock an account to prevent login |
| 🔓 Enable User | Unlock a previously locked account |
| 🔑 Change Password | Reset any user's password interactively |

### 👥 Group Management

| Feature | Description |
|---|---|
| ➕ Add Group | Create a new system group |
| ✏️ Modify Group | Rename a group or add a user to it |
| 🗑️ Delete Group | Remove an existing group |
| 📋 List Groups | Display all system groups with their GIDs |

---

## 📦 Requirements

- 🐧 Linux system (Debian / Ubuntu / RHEL / Rocky or any distro)
- 🪟 `whiptail` installed
- 🔐 Root privileges (`sudo`)

### 🔧 Install whiptail

```bash
# Debian / Ubuntu
sudo apt install whiptail

# RHEL / Rocky / Fedora
sudo dnf install newt
```

---

## 🚀 Installation & Usage

### 1. 📥 Clone the repository

```bash
git clone https://github.com/your-username/user-group-manager.git
cd user-group-manager
```

### 2. ⚙️ Make the script executable

```bash
chmod +x project.sh
```

### 3. ▶️ Run as root

```bash
sudo ./project.sh
```

---

## 🗂️ Menu Options

```
┌─────────────────────────────────────┐
│             Main Menu               │
├─────────────────────────────────────┤
│  1.  Add User                       │
│  2.  Modify User                    │
│  3.  Delete User                    │
│  4.  List Users                     │
│  5.  Add Group                      │
│  6.  Modify Group                   │
│  7.  Delete Group                   │
│  8.  List Groups                    │
│  9.  Disable User                   │
│  10. Enable User                    │
│  11. Change Password                │
│  12. About                          │
└─────────────────────────────────────┘
```

> 💡 Press **Cancel** or **Esc** at the main menu to exit.

---

## 📁 Project Structure

```
Bash project/
│
├── project.sh            # 🐚 Main script
└── README.md             # 📄 You're reading this!
```

---

## 📖 Commands Reference

| Command | Flag | Purpose |
|---|---|---|
| `useradd` | `-m` | Create user with home directory |
| `userdel` | `-r` | Delete user and home directory |
| `usermod` | `-l` | Rename user |
| `usermod` | `-d -m` | Change and move home directory |
| `usermod` | `-s` | Change login shell |
| `usermod` | `-L / -U` | 🔒 Lock / 🔓 Unlock account |
| `usermod` | `-aG` | Add user to a group |
| `chpasswd` | — | Set password from stdin |
| `groupadd` | — | Create a new group |
| `groupmod` | `-n` | Rename a group |
| `groupdel` | — | Delete a group |
| `id` | — | Check if user exists |
| `getent group` | — | Check if group exists |

---

## 👨‍💻 Author

### Omar Hesham

🎓 System Administration Track — ITI
