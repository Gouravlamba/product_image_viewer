##📦 Product Image Viewer App

A Flutter application that fetches product images from an API, displays them in a grid, allows users to mark favorites, switch between light/dark theme, and access a profile-style drawer.

#📝 Table of Contents

.Overview

.Features

.Screens Overview

.Architecture

.Folder Structure

.State Management (BLoC)

.API Details

.Theme Management

.How to Run

.Packages Used

##🔍 1. Overview

The Product Image Viewer App is a simple Flutter application built to demonstrate API integration, UI rendering, state management using BLoC, local persistence, dark/light theme switching, profile drawer integration, and clean architecture.

#This project fulfills the assignment requirement:

.Fetch product images from moc APIs
.Display in a grid
.Navigate to product detail screen
.Toggle favorites
.Persist favorites locally
.Include bottom navigation
.Add a profile/drawer section
.Add theme switch (Dark/Light mode)
.Maintain clean BLoC architecture

##🚀 2. Features
#🖼️ Product Grid

Fetches product list from API or fallback JSON

Displays products in a responsive GridView

Each product card includes image & title

##⭐ Product Detail Page

Enlarged image in Hero animation

Title shown clearly

Favorite button to toggle item

##❤️ Favorites System

Add/remove items from favorites

Favorites tab shows only liked products

Favorites are saved using SharedPreferences

##🌓 Theme Switching

Toggle Dark/Light theme using Switch

Theme preference is saved persistently

##📱 Bottom Navigation

.Home

.Favorites

.Profile / Drawer

#📂 Profile Drawer

.User avatar

.Name, subtitle

.About section

.Theme switch

.Email, phone, app version

.Logout button

##🖼️ 3. Screens Overview
.Home Screen

.Grid of all products

.Drawer menu access

.Navigate to product details

.Favorites Screen

.Shows only favorited items

.Product Detail Screen

.Large product image

.Favorite toggle

.Profile Drawer

.Complete profile info

.Theme toggle

.Helpful menu items

##🧱 4. Architecture

.The project follows Clean Architecture principles:

.presentation/ → UI Layer (Screens, Widgets)
.logic/        → State Management (BLoC)
.data/         → Repository, Services, Model
.utils/        → Constants, Helpers


##Uses BLoC pattern for:

.Products

.Favorites

.Theme switching

Ensures:
.separation of concerns
.clean UI
.reusability
.maintainability

##📂 5. Folder Structure
lib/
│
├── data/

│   ├── models/
│   │   └── product_model.dart

│   ├── repository/
│   │   └── product_repository.dart

│   └── services/
│       ├── api_service.dart
│       └── local_data_service.dart

│
├── logic/
│   ├── product_bloc/
│   ├── favorite_bloc/
│   ├── theme_bloc/

│
├── presentation/
│   ├── screens/
│   │   ├── home_screen.dart
│   │   ├── favorites_screen.dart
│   │   ├── product_detail_screen.dart
│   │   ├── main_screen.dart
│   │   └── profile_screen.dart

│   ├── widgets/
│   │   └── product_card.dart
│   │   └── app_drawer.dart

│   └── themes/
│       └── app_theme.dart

│
└── utils/
    ├── app_constants.dart
    ├── app_routes.dart
    └── helpers.dart
    

##⚙️ 6. State Management (BLoC)
ProductBloc

Loads products from API

Emits Loading, Loaded, Error states

FavoriteBloc

Stores favorite product IDs

Persists favorites with SharedPreferences

ThemeBloc

Switches between Light/Dark mode

Saves mode preference locally

##🌐 7. API Details

The app uses the mock endpoint:

GET https://mock.pavepilot.dev/products


Sample Response:

[
  {
    "id": "1",
    "title": "Running Shoes",
    "imageUrl": "https://picsum.photos/400?1"
  },
  {
    "id": "2",
    "title": "Leather Wallet",
    "imageUrl": "https://picsum.photos/400?2"
  }
]


✔If the API fails, the app loads a local JSON fallback.

##🎨 8. Theme Management

Uses ThemeBloc for toggling

Toggle available inside Drawer

Saves theme state in SharedPreferences

App reloads with last chosen theme

#▶️ 9. How to Run the Project

#1️⃣ Clone the repository

git clone https://github.com/yourusername/product_image_viewer_app.git

cd product_image_viewer_app

#2️⃣ Install dependencies
flutter pub get

#3️⃣ Run the app
flutter run

4️⃣ To run on Web with HTML renderer:
flutter run -d chrome --web-renderer html
