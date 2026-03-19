# E-commerce App (Ecomeee) 🛒

A high-performance Flutter e-commerce application built with **Clean Architecture** principles. This project demonstrates advanced networking, reactive programming, and robust state management.

---

## 🛠️ Tech Stack

- **Framework:** [Flutter](https://flutter.dev/)
- **State Management:** [BLoC (Business Logic Component)](https://pub.dev/packages/flutter_bloc) - Used for predictable state changes and separation of concerns.
- **Networking:** - [Dio](https://pub.dev/packages/dio): A powerful HTTP client for Dart.
    - [Retrofit](https://pub.dev/packages/retrofit): Type-safe REST client generator for Dio (inspired by Android's Retrofit).
- **Architecture:** BLoC Pattern with Data/Repository layers.
- **API Source:** [FakeStoreAPI](https://fakestoreapi.com/)

---

## 🏗️ Architecture Overview

The app follows a structured layered approach:
1.  **Data Layer:** Handles API calls using `Retrofit` interfaces and `Dio`.
2.  **Repository Layer:** Acts as a mediator between the Data layer and Business logic.
3.  **Business Logic (BLoC):** Manages the app state (Loading, Success, Error) and reacts to user events.
4.  **UI Layer:** Purely presentational widgets that listen to BLoC states.

---

## 📝 Technical Notes (Mock API Behavior)

> **Important:** The "Add Product" functionality uses a `POST` request. 
> - While the request returns a successful response (`id: 21`), the **FakeStore API** does not persist this data. 
> - I have handled this by ensuring the BLoC reacts to the success status, confirming the app's architecture is ready for a real production database.
![photo_2026-03-20_02-24-50](https://github.com/user-attachments/assets/996a201b-1873-4f63-9cb6-2e3a322c0596)

---![photo_2026-03-20_02-24-50 (2)](https://github.com/user-attachments/assets/d1a35ea3-ae08-4afc-9cae-c36bf1badcaf)

![photo_2026-03-20_02-24-50 (3)](https://github.com/user-attachments/assets/f4eb4d14-4917-4645-906b-e2b0453d78ab)

## ⚙️ How it Works (Retrofit + BLoC)

- **API Client:** Generated via `retrofit_generator` for compile-time safety.
- **State Flow:** `UI Event` ➡️ `BLoC` ➡️ `Repository` ➡️ `Retrofit Client` ➡️ `FakeStore API`

---

## 🚀 Getting Started

1. Clone the repo.
2. Run `flutter pub get`.
3. **Crucial:** Run the generator to build the Retrofit classes:
   ```bash
   dart run build_runner build --delete-conflicting-outputs
