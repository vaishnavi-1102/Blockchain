# Drug Tracking dApp

![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)
![Platform: Ethereum](https://img.shields.io/badge/platform-Ethereum-blue)
![Status: In Development](https://img.shields.io/badge/status-active-brightgreen)
![Built with: Truffle](https://img.shields.io/badge/Built%20With-Truffle-8A2BE2?logo=truffle)

A decentralized application to track the lifecycle of drugs in the supply chain using Ethereum blockchain technology. Designed to improve drug authenticity, prevent fraud, and increase transparency from manufacturing to delivery.

---

## 🚀 Features

- ✅ Add drugs with name, quantity, price, and description.
- 🖼️ Store image references (locally or off-chain via Firebase/IPFS).
- 📍 Add detailed tracing records (e.g. transport, delivery).
- 🔍 View complete drug info and trace history.
- 🔐 Smart contract ensures data immutability and transparency.
- 🧠 Uses Web3.js for blockchain interaction.

---

## 🧰 Technologies Used

- **Solidity** – Smart contracts
- **Truffle Suite** – Blockchain development framework
- **Ganache** – Local Ethereum network
- **MetaMask** – Ethereum wallet
- **Web3.js** – JavaScript Ethereum API
- **HTML/CSS/JavaScript** – Frontend
- **Firebase / IPFS (optional)** – Off-chain image storage

---

## ⚙️ Setup Instructions

### 1. Prerequisites

- Node.js and npm
- Truffle (`npm install -g truffle`)
- Ganache (local blockchain)
- MetaMask browser extension

### 2. Compile & Deploy Smart Contract

```bash
truffle compile
truffle migrate --reset
```

### 3. Configure Frontend

- Copy ABI and contract address to your JS files
- Ensure MetaMask is connected to the same network
- Open `addproduct.html` or `tracingdetails.html` in the browser

---

## 💊 Usage

### ➕ Add Product
- Fill in drug data
- Provide image (stored off-chain)
- Submit form to record on blockchain

### ➕ Add Trace
- Enter drug index and trace details
- Record supply chain steps (location, time, status)

---

## 🔍 Smart Contract Overview

```solidity
struct Drug {
    string name;
    uint quantity;
    uint price;
    string description;
    address manufacturer;
}

struct Trace {
    string info;
    uint timestamp;
}
```

### Key Functions
- `addDrug(...)`
- `getDrug(index)`
- `addTrace(index, info)`
- `getTraceInfo(index)`

---

## 📈 Future Improvements

- 🔐 Role-based access control (admin, transporter, retailer)
- 🌍 IPFS/Firebase integration for secure image hosting
- 📱 Responsive UI with framework like React or Vue
- 📊 Dashboard to visualize supply chain movements
- 🔎 Drug search by name or batch number
- ✅ Smart contract upgradeability (via proxy pattern)

---

## 📄 License

This project is licensed under the MIT License.  
See the [LICENSE](LICENSE) file for details.
