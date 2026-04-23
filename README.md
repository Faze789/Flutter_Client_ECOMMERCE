# PakWheels - Vehicle Marketplace Client

A Flutter-based vehicle marketplace application inspired by PakWheels. This app provides a complete buyer-and-seller experience for listing, browsing, and purchasing vehicles. It features image uploads via Cloudinary, push notifications through OneSignal, Firebase integration, JWT-based authentication, a shopping cart, and dedicated seller post management.

## Features

- **Buyer & Seller Screens** -- Separate interfaces tailored for buyers browsing listings and sellers managing posts
- **Vehicle Listings** -- Browse, search, and view detailed vehicle information
- **Image Upload** -- Upload vehicle photos via Cloudinary integration
- **Push Notifications** -- Real-time notifications powered by OneSignal
- **JWT Authentication** -- Secure token-based user authentication
- **Shopping Cart** -- Add vehicles to cart and manage selections before checkout
- **Seller Post Management** -- Create, edit, and manage vehicle listings as a seller

## Tech Stack

| Layer | Technology |
|---|---|
| Framework | Flutter |
| Backend Services | Firebase |
| Image Hosting | Cloudinary |
| Notifications | OneSignal |
| State Management | Provider |
| Authentication | JWT |

## Getting Started

### Prerequisites

- Flutter SDK installed ([installation guide](https://docs.flutter.dev/get-started/install))
- Firebase project configured with `google-services.json` / `GoogleService-Info.plist`
- Cloudinary account credentials
- OneSignal app ID

### Installation

```bash
git clone https://github.com/Faze789/Flutter_Client_ECOMMERCE.git
cd Flutter_Client_ECOMMERCE
flutter pub get
flutter run
```
