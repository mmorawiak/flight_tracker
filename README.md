# ✈️ Flight Tracker

Aplikacja mobilna Flutter do śledzenia lotów – wykorzystująca API AviationStack i mapy Google do prezentowania szczegółowych informacji o połączeniach lotniczych.

---

## 📱 Funkcje aplikacji

- Wyszukiwanie lotów po nazwie miasta lub kodzie IATA
- Prezentacja listy wyników z:
  - godziną wylotu i przylotu
  - nazwą przewoźnika
  - miastem wylotu i przylotu
  - datą lotu
- Ekran szczegółów z dodatkowymi informacjami
- Interfejs w języku polskim
- Obsługa błędów API
- Wersjonowanie repozytorium Git (feature branche)
- Mapy Google – (w trakcie wdrażania)

---

## 🛠️ Technologie

- Flutter (3.29.2)
- Dart (3.7.2)
- AviationStack API (plan: free tier)
- Google Maps Flutter plugin (`google_maps_flutter`)

---

## 🚧 Napotkane problemy i rozwiązania

### 🔸 Problem: `flutter` not recognized
**Rozwiązanie:** dodanie Fluttera do zmiennej środowiskowej `PATH`.

### 🔸 Problem: brak `SearchScreen`, błędy builda
**Rozwiązanie:** stworzenie brakujących plików i klas, uruchomienie aplikacji od nowa.

### 🔸 Problem: `"FlightTracker" is not a valid Dart package name`
**Rozwiązanie:** poprawa nazwy folderu projektu na `flight_tracker`.

### 🔸 Problem: NDK version mismatch (Google Maps)
**Rozwiązanie:**
- Dodano `ndkVersion = "27.0.12077973"` do `android/app/build.gradle.kts`
- Poprawiono `local.properties`
- Restart Fluttera i czyszczenie: `flutter clean`

---

## ▶️ Uruchomienie aplikacji

1. **Zainstaluj Flutter SDK**  
   https://docs.flutter.dev/get-started/install/windows

2. **Klonuj repozytorium**

```bash
git clone https://github.com/mmorawiak/flight_tracker.git
cd flight_tracker
```

3. **Zainstaluj zależności**

```bash
flutter pub get
```

4. **Uruchom emulator Androida (np. przez Android Studio)**

5. **Uruchom aplikację**

```bash
flutter run
```

---

## 🗺️ Planowane funkcje

- Mapa z lokalizacją lotu (Google Maps)
- Filtrowanie wyników
- Przechowywanie ulubionych lotów
- Testy jednostkowe
- Responsywność na inne rozdzielczości

---

## 🔑 API Keys

- **AviationStack**: w `lib/services/flight_service.dart`
- **Google Maps**: w `android/app/src/main/AndroidManifest.xml`

---

## 📁 Struktura projektu

```
lib/
├── main.dart
├── models/
│   └── flight_model.dart
├── services/
│   └── flight_service.dart
├── screens/
│   ├── search_screen.dart
│   ├── flight_list_screen.dart
│   └── flight_details_screen.dart
└── widgets/
    └── detail_row.dart
```

---

## 📄 Licencja

MIT License