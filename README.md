# Kalakaari - Indian Artisan Marketplace 🪔

A beautiful Flutter app dedicated to connecting traditional Indian artisans with modern buyers. Discover authentic handmade crafts from across India while supporting local artisans and preserving cultural heritage.

## Features ✨

### 🎨 Beautiful Indian Design
- Rich color palette with saffron, deep green, maroon, cream, and gold
- State-wise cultural themes and backgrounds
- Smooth animations and transitions
- Modern, clean UI with Indian aesthetics

### 🏺 Core Functionality
- **Animated Splash Screen** - Rotating artisan craft visuals
- **Onboarding Flow** - Introduction to app features
- **Authentication** - Login/Signup with email, phone, and Google
- **Home Page** - Search, state-wise carousels, trending products
- **Categories** - Grid of craft categories (Handloom, Pottery, Jewelry, etc.)
- **Product Details** - Rich product pages with artisan information
- **State Exploration** - Discover crafts by Indian states
- **Cultural Heritage** - Learn about craft traditions and history

### 🛍️ Marketplace Features
- Product browsing with high-quality images
- Artisan profiles and stories
- Reviews and ratings
- Add to cart functionality
- State-wise product organization
- Cultural context and heritage information

## Getting Started 🚀

### Prerequisites
- Flutter SDK (3.0.0 or higher)
- Dart SDK
- Android Studio / VS Code
- Android/iOS device or emulator

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/nandinireddy-02/Kalakaari.git
   cd Kalakaari
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

### Building for Release

```bash
# Android APK
flutter build apk --release

# Android App Bundle
flutter build appbundle --release

# iOS (macOS only)
flutter build ios --release
```

## Project Structure 📁

```
lib/
├── main.dart                 # App entry point
├── models/                   # Data models
│   ├── artisan.dart         # Artisan model
│   ├── product.dart         # Product model
│   └── category.dart        # Category model
├── screens/                  # UI screens
│   ├── splash_screen.dart   # Animated splash
│   ├── onboarding_screen.dart
│   ├── auth/                # Authentication screens
│   ├── home/               # Home screen
│   ├── categories/         # Category screens
│   └── product/           # Product detail screens
├── widgets/                # Reusable widgets
│   ├── product_card.dart   # Product cards
│   ├── category_card.dart  # Category cards
│   └── state_carousel.dart # State carousel
├── utils/                  # Utilities
│   ├── colors.dart        # App colors
│   └── theme.dart         # App theme
└── services/              # Data services
    └── dummy_data.dart    # Sample data
```

## Sample Crafts Featured 🎭

### By State
- **Rajasthan** - Blue Pottery, Desert Crafts
- **Tamil Nadu** - Kanchipuram Silk Sarees, Bronze Work
- **West Bengal** - Terracotta Horses, Handloom
- **Bihar** - Madhubani Paintings, Folk Art
- **Assam** - Bamboo Crafts, Traditional Weaving
- **Kerala** - Coconut Crafts, Spice Art
- **Gujarat** - Embroidery, Textile Crafts

### By Category
- 🧵 **Handloom** - Sarees, Fabrics, Traditional Textiles
- 🏺 **Pottery** - Blue Pottery, Terracotta, Ceramics
- 💍 **Jewelry** - Traditional Ornaments, Silver Work
- 🎨 **Paintings** - Madhubani, Warli, Folk Art
- 🪵 **Woodwork** - Carved Items, Furniture
- 🎋 **Bamboo Crafts** - Eco-friendly Products

## Design Philosophy 🎨

### Color Palette
- **Saffron (#FF9933)** - Primary brand color, represents spirituality and courage
- **Deep Green (#138808)** - Success, prosperity, and nature
- **Maroon (#800020)** - Tradition, heritage, and craftsmanship
- **Cream (#F5F5DC)** - Elegance and purity
- **Gold (#FFD700)** - Luxury and cultural richness

### Typography
- **Primary Font** - Poppins (Modern, clean, readable)
- **Indian Script** - Noto Sans Devanagari (Cultural authenticity)

### Animation Principles
- Smooth page transitions with Hero animations
- Fade and slide animations for content
- Rotating splash screen elements
- Staggered list animations

## Cultural Authenticity 🇮🇳

This app celebrates India's rich craft heritage by:
- Featuring authentic artisan stories and backgrounds
- Highlighting regional craft traditions and history
- Using culturally appropriate color schemes for each state
- Incorporating traditional design elements and patterns
- Supporting local artisans and craft preservation

## Development Notes 📝

### Key Dependencies
- `flutter` - UI framework
- `google_fonts` - Typography
- `carousel_slider` - Image carousels
- `smooth_page_indicator` - Carousel indicators
- `cached_network_image` - Efficient image loading
- `provider` - State management
- `animations` - Advanced animations

### Future Enhancements
- Real-time chat with artisans
- AR/VR craft viewing
- Live craft-making sessions
- Multilingual support (Hindi, Tamil, Bengali, etc.)
- Payment gateway integration
- Push notifications for new crafts
- Social features and craft sharing

## Contributing 🤝

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit changes (`git commit -m 'Add amazing feature'`)
4. Push to branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## Support 💬

For support, email kalakaari.support@gmail.com or create an issue in the GitHub repository.

## License 📄

This project is licensed under the MIT License - see the LICENSE file for details.

---

**Made with ❤️ for Indian Artisans and Craft Enthusiasts**

*Preserving Tradition, Embracing Innovation* 🪔