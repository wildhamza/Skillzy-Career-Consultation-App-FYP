# Career Consultation Platform

A cross-platform application for career guidance and skill assessment, featuring a Flutter-based frontend and a Node.js/TypeScript backend with integrated machine learning models for career recommendations.

---

## Table of Contents
- [Overview](#overview)
- [Features](#features)
- [Project Structure](#project-structure)
- [Frontend Setup (Flutter)](#frontend-setup-flutter)
- [Backend Setup (Node.js/TypeScript & Python ML)](#backend-setup-nodejstypescript--python-ml)
- [Machine Learning Models](#machine-learning-models)
- [Developer Credits](#developer-credits)
- [License](#license)

---

## Overview
This project provides a comprehensive career consultation platform, allowing users to:
- Assess their skills
- Receive personalized career recommendations
- Manage their profiles
- Interact with a modern, responsive UI

The backend leverages both Node.js/TypeScript for API and business logic, and Python for advanced machine learning-based career mapping.

## Features
- **User Authentication** (register, login, password reset)
- **Skill Assessment** and **Career Recommendation**
- **Profile Management**
- **Onboarding Experience**
- **Admin Dashboard** (optional, if implemented)
- **ML-powered career prediction**

## Project Structure
```
career-consultation-flutter/
  ├── Front-End/      # Flutter app (mobile/web)
  └── Back-End/       # Node.js/TypeScript API + Python ML scripts
```

## Frontend Setup (Flutter)
1. **Requirements:**
   - Flutter SDK (see [Flutter installation guide](https://docs.flutter.dev/get-started/install))
   - Dart SDK (usually included with Flutter)

2. **Install dependencies:**
   ```bash
   cd Front-End
   flutter pub get
   ```

3. **Run the app:**
   - For mobile:
     ```bash
     flutter run
     ```
   - For web:
     ```bash
     flutter run -d chrome
     ```

4. **Assets:**
   - Images and SVGs are in `assets/img/` and `assets/svg/`.
   - App uses [Google Fonts](https://pub.dev/packages/google_fonts), [liquid_swipe](https://pub.dev/packages/liquid_swipe), [get](https://pub.dev/packages/get), and more (see `pubspec.yaml`).

## Backend Setup (Node.js/TypeScript & Python ML)
### Node.js/TypeScript API
1. **Requirements:**
   - Node.js v18.x
   - npm

2. **Install dependencies:**
   ```bash
   cd Back-End
   npm install
   ```

3. **Development server:**
   ```bash
   npm run dev
   ```

4. **Production build:**
   ```bash
   npm run build
   npm start
   ```

5. **Configuration:**
   - Environment variables are managed via `.env` (see `src/interface/dotenv.d.ts` for types).
   - API endpoints and logic are in `src/app/`, `src/controllers/`, and `src/routes/`.

### Python Machine Learning Models
1. **Requirements:**
   - Python 3.8+
   - pip

2. **Install dependencies:**
   ```bash
   cd Back-End/src/script/model-1
   pip install -r ../../requirements.txt
   # or for model-2
   cd ../model-2
   pip install -r ../../requirements.txt
   ```

3. **Model files:**
   - Model 1: `src/script/model-1/model.py`, `modified_model.h5`
   - Model 2: `src/script/model-2/train-model.py`, `career_model.h5`
   - Data: `src/script/career-mapping.csv`

4. **Documentation:**
   - See `Back-End/ML_MODELS.md` for detailed explanation of the ML models, data preprocessing, and usage.

## Machine Learning Models
- The backend integrates two neural network models for career prediction.
- For details on architecture, training, and usage, refer to [`Back-End/ML_MODELS.md`](Back-End/ML_MODELS.md).

## Developer Credits
- **Shayan Khan**
- **Hamza Ali**
- **Abu Akash Afridi**

## License
This project is for academic and demonstration purposes. Please contact the authors for reuse or collaboration. 