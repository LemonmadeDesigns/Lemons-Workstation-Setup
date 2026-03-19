# 💻 Professional Development Workstation Setup

🚀 A production-grade macOS developer bootstrap script that gets your environment fully set up in one run.

No guesswork. No wasted time. Just a clean, consistent setup.

---

## 🎯 Purpose

This script creates a **reliable and repeatable development environment** for:

* 👨‍💻 Engineers
* 🧑‍💼 Remote teams
* 🏢 Professional environments
* 💻 New machines

---

## ⚙️ What Gets Installed

### 🧱 Core Stack

* 🍺 Homebrew (package manager)
* 🟢 Node.js (LTS via NVM)
* 🍃 MongoDB (optional)
* 🧾 mongosh

---

### 📦 Dev Tooling

* 🎨 prettier
* 🧹 eslint
* 🔄 nodemon
* 🧠 typescript
* 🧵 yarn
* 🔥 firebase-tools (optional)

---

### 🐳 Infrastructure

* 🐳 Docker Desktop (optional but recommended)

---

### 🔌 Backend Tools

* 🔥 Firebase CLI (optional)
* ⚡ Supabase CLI (optional)

---

### 🛠 IDEs & Tools

* 🖥 iTerm2
* 🧑‍💻 Visual Studio Code

---

### ⚡ Shell Enhancements

* 💻 Oh My Zsh
* 🤖 zsh-autosuggestions
* 🌈 zsh-syntax-highlighting

---

### 🔐 Git Setup

* 🪪 Safe defaults (non-intrusive)
* 🌿 Default branch → `main`
* ✍️ VS Code as editor

---

## 🧩 Configurable via `.env`

This script supports optional configuration using a `.env` file.

### 📄 Example:

```
NODE_VERSION=20
INSTALL_DOCKER=true
INSTALL_SUPABASE=true
INSTALL_FIREBASE=true
INSTALL_MONGODB=true
```

💡 If no `.env` is provided, safe defaults are used.

---

## 🚫 What This Does NOT Do

* ❌ Doesn’t install every language or framework
* ❌ Doesn’t override your personal dotfiles
* ❌ Doesn’t force a specific workflow

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

## ⚠️ After Setup (Required)

### 🐳 1. Open Docker

Docker must be launched manually the first time.

---

### 🧑‍💻 2. Enable VS Code CLI

Open VS Code →
Press `Cmd + Shift + P` →
Search: `Install 'code' command in PATH`

---

### ⚡ 3. Reload Your Shell

```
source ~/.zshrc
```

---

## 🔁 Re-Runnable

🔄 You can safely run this script multiple times.

* Skips installed tools
* Updates where needed
* No duplicate installs

---

## 🛠 Customization

Want to extend your setup?

* ➕ Add Python / Go / Rust
* ☁️ Add AWS CLI / Terraform
* 🎨 Add themes, fonts, aliases

---

## ❓ FAQ

**❓ Can I use this for a team?**
Yes — it’s built for consistent environments across machines.

**❓ Does this support Apple Silicon (M1/M2/M3)?**
Yes — fully compatible.

**❓ Will this break my existing setup?**
No — it respects existing configurations.

---

## ✍️ Author

Terrell D. Lemons

---

## ⚖️ License

MIT License

Use it. Improve it. Share it.
