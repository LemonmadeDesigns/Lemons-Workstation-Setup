# Workstation Setup for Developers

This project provides a streamlined, standalone setup script (`setup.sh`) that automates the essential tools and configurations needed to prepare a macOS machine for full-stack JavaScript and Node.js development. It’s powered by [Bash](https://www.gnu.org/software/bash/) and leverages [Homebrew](https://brew.sh/) to handle all package installations cleanly and efficiently.

---

## 🎯 Purpose

The goal of this script is to make it fast and consistent to set up a new development machine — whether you’re just getting started or rebuilding from scratch. It installs only what’s necessary for most JavaScript, Node.js, and MongoDB-based workflows.

This is especially useful for individuals or teams who need a repeatable process without reinventing the wheel every time.

---

## 💡 Why This Format?

- Bash is native, editable, and flexible — no fancy wrappers
- Everything is in one file — easy to fork, modify, and reuse
- It keeps the setup minimal while covering the core developer needs
- No extra dependencies — just `bash`, `git`, and `macOS`
- Perfect for solo developers, instructors, or team leads building onboarding docs

---

## 🚫 What This Doesn’t Do

This script keeps things lean on purpose:

- It doesn’t try to install every possible library or language — only general-purpose tools
- It avoids custom dotfile or terminal configurations
- It doesn’t enforce IDE or terminal preferences — you decide how deep you want to customize

---

## ⚙️ Prerequisites

Before you run the setup:

- Ensure you’re on the latest version of **macOS** or close to it
- Install the [Command Line Tools for Xcode](https://developer.apple.com/download/all/?q=Command%20Line%20Tools%20for%20Xcode)

You can install them via terminal if needed:

```bash
xcode-select --install
```

---

## 📥 Cloning This Repo

Open Terminal and run:

```bash
mkdir -p ~/workspace &&
cd ~/workspace &&
git clone https://github.com/your-username/workstation-setup.git &&
cd workstation-setup
```

---

## 🧪 Running the Script

To begin installing your dev tools, simply run:

```bash
chmod +x setup.sh
./setup.sh
```

This script will:

- Ask for your password one time (via `sudo`)
- Check for Homebrew and install it if needed
- Install Node.js, MongoDB, mongosh, and developer CLI tools

**Note:** This script is standalone — no dependencies on other shell scripts, folders, or config files.

---

## 🧰 What Gets Installed

### Core Tools

- **Node.js** (includes `npm` and `npx`)
- **MongoDB Community Edition**
- **mongosh** – official MongoDB shell

### Global npm packages

- `prettier`
- `eslint`
- `nodemon`
- `typescript`
- `yarn`

### Services

- MongoDB is started as a background service with `brew services`

All versions of installed tools are displayed at the end of the script.

---

## 🧠 Tips & Gotchas

- Don’t run with `sudo` — the script handles privilege escalation for you.

- If you see a lock error with Homebrew:

  ```bash
  sudo chown -R $(whoami) /usr/local/var/homebrew
  ```

- If `code` doesn’t work in terminal, open VS Code and run:

  > `Shell Command: Install 'code' command in PATH`

---

## 🛠 Customization

Want to customize it for your own workflow?

1. Fork this repo
2. Modify `setup.sh` to add tools you care about (like `docker`, `python`, or `nvm`)
3. Share with your team — or just keep it in your own backup playbook

---

## ❓ FAQs

**Q: Can I run the script more than once?**
A: Yes. It won’t reinstall packages if Homebrew already has them cached. But it may overwrite configs or start services again.

**Q: What if I want to install more tools later?**
A: You can add them directly to `setup.sh`, or manually with `brew install` or `npm install -g`.

**Q: Can I make this script run on Linux?**
A: With slight tweaks, yes — though this version is optimized for macOS and Homebrew.

---

## ✍️ Author

Built by [Terrell D. Lemons](https://linkedin.com/in/terrelldlemons),
Software Engineer | Release Coordinator | Remote Instruction Manager
[@terrelldlemons on GitHub](https://github.com/terrelldlemons)

---

## ⚖️ License

This project is licensed under the MIT License. Use it, fork it, remix it — just don’t make it worse.
