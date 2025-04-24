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
- Widok trasy lotu na mapie (Google Maps)
- Obsługa błędów API i danych
- Interfejs w języku polskim

---

## 🧪 Dane testowe

Jeśli API nie zwróci wyników lub limit zostanie przekroczony, aplikacja pokazuje loty testowe, np.:

- **LO33 (LOT Polish Airlines)** – Warszawa → Chicago  
- **BA283 (British Airways)** – Londyn → Los Angeles  
- **SQ26 (Singapore Airlines)** – Singapur → Frankfurt  
- **DL173 (Delta)** – Tokio → Seattle  
- **QF12 (Qantas)** – Los Angeles → Sydney  

Każdy z nich oznaczony jest jako `status: scheduled (TEST)`.

---

## 🛠️ Technologie

- Flutter (3.29.2)
- Dart (3.7.2)
- AviationStack API (plan: free tier)
- Google Maps Flutter plugin (`google_maps_flutter`)
- Obsługa .env (`flutter_dotenv`)

---

## 🚧 Napotkane problemy i rozwiązania

### 🔸 Problem: `flutter` not recognized  
**Rozwiązanie:** dodanie Fluttera do zmiennej środowiskowej `PATH`.

### 🔸 Problem: `"FlightTracker" is not a valid Dart package name`  
**Rozwiązanie:** poprawa nazwy folderu projektu na `flight_tracker`.

### 🔸 Problem: brak danych geograficznych z API  
**Rozwiązanie:** fallback do lotów testowych z predefiniowanymi koordynatami.

### 🔸 Problem: NDK version mismatch (Google Maps)  
**Rozwiązanie:** dodano `ndkVersion = "27.0.12077973"` do `build.gradle.kts`

---

## ▶️ Uruchomienie aplikacji

1. **Zainstaluj Flutter SDK**  
   https://docs.flutter.dev/get-started/install/windows

2. **Klonuj repozytorium**

```bash
git clone https://github.com/mmorawiak/flight_tracker.git
cd flight_tracker
```

3. **Ustaw klucze API**

Utwórz plik `.env` w katalogu głównym i dodaj:

```
AVIATIONSTACK_API_KEY=your_api_key_here
GOOGLE_MAPS_API_KEY=your_maps_key_here
```

4. **Zainstaluj zależności**

```bash
flutter pub get
```

5. **Uruchom emulator Androida**

6. **Odpal aplikację**

```bash
flutter run
```

---

## 🗺️ Planowane funkcje

- Przechowywanie ulubionych lotów
- Filtrowanie wyników wyszukiwania
- Testy jednostkowe i integracyjne
- Responsywność na inne rozdzielczości i tablety

---

## 🔑 API Keys

- **AviationStack**: w pliku `.env` i używany w `lib/services/flight_service.dart`
- **Google Maps**: również w `.env`, wykorzystywany przez `AndroidManifest.xml`

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
│   ├── flights_list_screen.dart
│   ├── flight_details_screen.dart
│   └── flight_map_screen.dart
└── widgets/
    └── detail_row.dart
```

---

## 📄 Licencja

MIT License