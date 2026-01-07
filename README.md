# 📰 AlgoOcean – Flutter News Application

A modern Flutter news application that displays the latest headlines by category and search keyword using **NewsAPI**, built with **Provider** state management, clean architecture, and responsive UI.

---

## 📌 Features

- 🗂 Category-wise news  
  - Business  
  - Entertainment  
  - Health  
  - Science  
  - Sports  
  - Technology
- 🔍 Search news with infinite scroll pagination
- 📄 News detail page
- ♾ Lazy loading (pagination)
- ⏳ Loading indicators
- 📱 Portrait-only layout
- 🎨 Responsive UI using `flutter_screenutil`
- 🔄 Centralized state management with Provider

---

## 🛠 Tech Stack

- Flutter (Dart)
- Provider – State management
- REST API – NewsAPI
- HTTP – API communication
- Google Fonts – Typography
- Intl – Date formatting
- Flutter ScreenUtil – Responsive design

---

## 📂 Project Structure

lib/
│
├── core/
│ ├── config/ # API configuration
│ ├── provider/ # AppProvider (state management)
│ └── service/ # API service & networking
│
├── model/ # Data models
│ ├── news_response.dart
│ └── category_model.dart
│
├── ui/
│ ├── category/ # Category listing
│ ├── news/ # News list & details
│ └── search/ # Search screen
│
├── utils/ # Colors, constants
├── widget/ # Reusable widgets
└── main.dart # Application entry point


---

## 🧠 Architecture & Design

- Provider Pattern for state management
- Service layer for API calls
- Separation of concerns
- MVVM-style architecture
- Pagination handled at Provider level

---

## 📦 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  provider: ^6.1.2
  http: ^1.2.0
  flutter_screenutil: ^5.9.0
  google_fonts: ^6.1.0
  intl: ^0.19.0
