# 📚 Hafsa Ayesha's Bookie Store (x86 Assembly Project)

This is a **semester group project** developed by **Hafsa** and **Ayesha**.  
It is a console-based book store system written in **x86 Assembly Language (MASM/TASM)** that simulates a book shopping experience in a text-based DOS environment.

---

## 👩‍💻 Authors

- **Hafsa**
- **Ayesha**

🎓 *Submitted as part of our semester project for Assembly Language Programming.*

---

## 🎯 Project Overview

This project allows users to:

- View a welcome screen and category menu.
- Choose from 5 book categories:
  - 📖 Islamic Books
  - 📗 English Books
  - 📘 History Books
  - 🔬 Science Books
  - 📚 Urdu Literature
- Select individual books by number.
- Add multiple books to a cart.
- Choose a payment method:
  - 💵 Cash (adds Rs.50 COD fee)
  - 💳 Card (no extra fee)
- View total bill and a thank-you message.

---

## 📁 Files

- `bookie_store.asm` — Main assembly source code
- `README.md` — This documentation file

---

## 🔧 Requirements

- **Assembler:** MASM or TASM
- **Optional:** DOSBox (for modern systems)

---

## 🚀 How to Compile & Run

### ✅ If you're using MASM / TASM:

```bash
tasm bookie_store.asm      ; Assemble the source code
tlink bookie_store.obj     ; Link the object file
bookie_store.exe           ; Run the executable
