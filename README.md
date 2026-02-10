# 🎮 Pokemon App - Flutter Web

A beautiful Pokemon web application built with Flutter, featuring modern UI/UX with glassmorphism effects, animations, and deep linking support.

## ✨ Features

- 🎨 Modern, beautiful UI with glassmorphism and gradient effects
- 📱 Responsive design (mobile, tablet, desktop)
- 🔗 Deep linking support with GoRouter
- ⚡ Fast performance with caching
- 🎭 Shiny Pokemon variants
- 📊 Detailed Pokemon stats and information
- 🌐 Web-optimized with SEO support

## 🚀 Quick Deploy to Vercel

### Option 1: Deploy via Vercel Dashboard (Recommended)

1. **Push to GitHub:**
   ```bash
   git init
   git add .
   git commit -m "Initial commit"
   git remote add origin YOUR_GITHUB_REPO_URL
   git push -u origin main
   ```

2. **Deploy on Vercel:**
   - Go to [vercel.com](https://vercel.com)
   - Click "Add New Project"
   - Import your GitHub repository
   - Vercel will auto-detect `vercel.json`
   - Click "Deploy"
   - Wait ~5-10 minutes for first build

3. **Done!** Your app will be live at `https://your-project.vercel.app`

### Option 2: Deploy via Vercel CLI

```bash
# Install Vercel CLI
npm install -g vercel

# Login
vercel login

# Deploy
vercel --prod
```

### Option 3: Use Helper Script

```bash
# Make script executable (first time only)
chmod +x deploy.sh

# Run deploy helper
./deploy.sh
```

## 🛠️ Local Development

```bash
# Install dependencies
flutter pub get

# Run on web
flutter run -d chrome

# Build for web
flutter build web --release
```

## 📖 Full Documentation

See [DEPLOY_GUIDE.md](./DEPLOY_GUIDE.md) for detailed deployment instructions and troubleshooting.

## 🔧 Configuration

The app is configured with:
- **Routing**: GoRouter for web-friendly URLs
- **State Management**: BLoC pattern
- **Dependency Injection**: GetIt
- **Clean Architecture**: Domain, Data, Presentation layers

## 🌐 Environment

- Flutter SDK: ^3.9.2
- Web Renderer: Auto (CanvasKit for better graphics)
- Base URL: Configured for root path deployment

## 📝 Project Structure

```
lib/
├── config/          # App configuration (theme, routes)
├── core/            # Core utilities and base classes
├── features/        # Feature modules (Clean Architecture)
│   └── pokemon/
│       ├── data/        # Data layer (models, repositories)
│       ├── domain/      # Domain layer (entities, use cases)
│       └── presentation/# Presentation layer (UI, BLoC)
├── models/          # Legacy models (to be migrated)
├── screens/         # Legacy screens (to be migrated)
└── services/        # Legacy services (to be migrated)
```

## 🎯 API

Using [PokéAPI](https://pokeapi.co/) for Pokemon data.

## 📄 License

This project is for educational purposes.

---

Made with ❤️ using Flutter
