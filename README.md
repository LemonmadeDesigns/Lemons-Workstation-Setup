# 💻 Workstation Setup for Developers

This project provides a streamlined, standalone setup script (`setup.sh`) to automate the installation of essential tools and configurations for macOS-based full-stack JavaScript and Node.js development. It’s powered by [Bash](https://www.gnu.org/software/bash/) and leverages [Homebrew](https://brew.sh/) to install packages cleanly and efficiently — with added support for modern IDEs like **iTerm2**, **VSCode**, and **Windsurf**.

## 🎯 Purpose

The goal of this script is to make spinning up a reliable and consistent dev environment quick — whether you're setting up a new Mac, rebuilding your workstation, or onboarding new devs to your team. This script handles the boring stuff so you can jump straight into building.

## 💡 Why This Format?

* 🧠 **Simple & native**: No framework, no YAML — just pure bash
* 📂 **One file, one command**: Easy to fork, reuse, and extend
* 🧹 **Clean and lightweight**: Only installs what's commonly needed
* 🧩 **Modular**: Customize it to fit your workflow
* 👥 **Ideal for individuals and team leads**: Especially helpful when onboarding new engineers or students

## 🚫 What This Doesn’t Do

This script stays lean on purpose:

* Doesn’t install every dev stack under the sun — focuses on JavaScript/Mongo
* Doesn’t mess with dotfiles or personal terminal themes
* Doesn’t assume your editor of choice — installs multiple IDEs, you pick your weapon

## ⚙️ Prerequisites

Before running the setup, make sure:

* You’re on an up-to-date version of **macOS**
* You’ve installed the **Command Line Tools for Xcode** (required for Homebrew)

Install with:

```bash
xcode-select --install
```

## 📥 Cloning This Repo

Open Terminal and run:

```bash
mkdir -p ~/workspace &&
cd ~/workspace &&
git clone https://github.com/LemonmadeDesigns/Lemons-Workstation-Setup.git &&
cd Lemons-Workstation-Setup
```

## 🧪 Running the Script

To install your full dev environment, run:

```bash
chmod +x setup.sh
./setup.sh
```

This script will:

* Prompt for your Mac password once (via `sudo`)
* Install Homebrew if missing
* Install Node.js, MongoDB, `mongosh`, global CLI tools, and 3 IDEs

> **Note:** The script is completely standalone. No external configs or linked scripts are required.

## 🧰 What Gets Installed

### 🧱 Core Tooling

* **Node.js** (includes `npm` and `npx`)
* **MongoDB Community Edition**
* **mongosh** (MongoDB’s official shell)

### 📦 Global npm packages

* `prettier`
* `eslint`
* `nodemon`
* `typescript`
* `yarn`

### 🛠 Developer IDEs & Tools

* **iTerm2** – better terminal for power users
* **Visual Studio Code** – the default full-stack editor
* **Windsurf IDE** – installed via official GitHub release script

> ✅ These are installed via Homebrew Casks and secure curl-based installers.

### 🔄 Services

* MongoDB is installed and launched as a background service using `brew services`

## 🧠 Tips & Gotchas

* No need to run this with `sudo`. The script handles elevation as needed.

* If Homebrew throws a permissions error, run:

  ```bash
  sudo chown -R $(whoami) /usr/local/var/homebrew
  ```

* After installing VS Code, make sure to enable the command line tool:

    > Launch VS Code → Press Cmd+Shift+P → Type: Shell Command → Click Install 'code' command in PATH

## 🛠 Customization

Want to add Docker, Python, or your favorite fonts?

1. Fork this repo
2. Modify `setup.sh` — it’s well-commented and modular
3. Use it for new machines, remote onboarding, or team training

## ❓ Frequently Asked Questions

**Q: Can I run the script more than once?**
**A:** Yes. It won’t reinstall what's already there. It’s safe to re-run.

**Q: Can I modify it to install different stacks (like Python or Ruby)?**
**A:** Absolutely. Just `brew install` or `npm install -g` anything else you need.

**Q: Does it work on Linux or Windows?**
**A:** Not as-is. This version is built specifically for macOS. A Linux version would need different package managers (`apt`, `dnf`, etc.).

## ✍️ Author

**Built by [Terrell D. Lemons](https://linkedin.com/in/terrelldlemons)**
Software Engineer | Release Coordinator | Remote Instruction Manager
[GitHub @terrelldlemons](https://github.com/LemonmadeDesigns/)

## ⚖️ License

Licensed under the MIT License.
Use it. Fork it. Share it. Just don’t bloat it.
