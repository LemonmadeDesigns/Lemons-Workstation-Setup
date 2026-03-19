# 💻 Workstation Setup for Developers

This project provides a streamlined, standalone setup script (`setup.sh`) to automate the installation of essential tools and configurations for macOS-based full-stack JavaScript and Node.js development. It’s powered by [Bash](https://www.gnu.org/software/bash/) and leverages [Homebrew](https://brew.sh/) to install packages cleanly and efficiently — with added support for modern IDEs like **iTerm2** & **VSCode**.

---

A production-grade macOS developer bootstrap system designed to get you fully set up in one run.

---

## 🎯 Purpose

This script creates a consistent and reliable development environment for:

* Engineers
* Students
* Teams
* New machines

---

## ⚙️ What Gets Installed

### 🧱 Core Stack

* Homebrew
* Node.js (LTS via NVM)
* MongoDB (Community Edition)
* mongosh

---

### 📦 Dev Tooling

* prettier
* eslint
* nodemon
* typescript
* yarn
* firebase-tools

---

### 🐳 Infrastructure

* Docker Desktop

---

### 🔥 Backend Tools

* Firebase CLI
* Supabase CLI

---

### 🛠 IDEs

* iTerm2
* Visual Studio Code

---

### ⚡ Shell Enhancements

* Oh My Zsh
* zsh-autosuggestions
* zsh-syntax-highlighting

---

### 🔐 Git Setup

* Name + Email
* Default branch → main
* VS Code as editor

---

## 🚫 What This Does NOT Do

* Doesn’t install every language
* Doesn’t override your dotfiles
* Doesn’t force a workflow

---

## 📥 Installation

```
mkdir -p ~/workspace &&
cd ~/workspace &&
git clone https://github.com/LemonmadeDesigns/Lemons-Workstation-Setup.git &&
cd Lemons-Workstation-Setup
```

---

## 🚀 Run Setup

```
chmod +x setup.sh
./setup.sh
```

---

## ⚠️ After Setup

### 1. Open Docker

Docker must be launched manually the first time.

---

### 2. Enable VS Code CLI

Open VS Code → Cmd + Shift + P → Install "code" command in PATH

---

### 3. Enable Zsh Plugins

Edit:

```
nano ~/.zshrc
```

Add:

```
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)
```

Then run:

```
source ~/.zshrc
```

---

## 🔁 Re-Runnable

Safe to run multiple times.
Skips installed tools and updates what’s needed.

---

## 🛠 Customization

Extend as needed:

* Add Python / Go / Rust
* Add AWS CLI / Terraform
* Add fonts, themes, aliases

---

## ✍️ Author

Terrell D. Lemons

---

## ⚖️ License

MIT License
