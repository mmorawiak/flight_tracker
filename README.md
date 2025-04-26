# ✈️ Flight Tracker

Aplikacja mobilna Flutter do śledzenia lotów – wykorzystująca API AviationStack i ReqRes oraz mapy Google do prezentowania szczegółowych informacji o połączeniach lotniczych.

---

## 📱 Funkcje aplikacji

- Logowanie użytkownika przez API ReqRes (zapis sesji w Hive)
- Wyszukiwanie lotów po nazwie miasta lub kodzie IATA
- Prezentacja listy wyników z:
  - godziną wylotu i przylotu
  - nazwą przewoźnika
  - miastem wylotu i przylotu
  - datą lotu
- Ekran szczegółów z dodatkowymi informacjami o locie
- Widok trasy lotu na mapie (Google Maps) z zakrzywioną trajektorią
- Pokazywanie pozycji na żywo samolotu (jeśli dostępna)
- Wylogowywanie użytkownika i czyszczenie sesji
- Obsługa błędów API i fallback na dane testowe
- Przejrzysty interfejs (UI/UX) w języku polskim

---

## 🧪 Dane testowe

Jeśli API nie zwróci wyników lub limit zostanie przekroczony, aplikacja pokazuje loty testowe:

- **LO33 (LOT Polish Airlines)** – Warszawa → Chicago  
- **BA283 (British Airways)** – Londyn → Los Angeles  
- **SQ26 (Singapore Airlines)** – Singapur → Frankfurt  
- **DL173 (Delta)** – Tokio → Seattle  
- **QF12 (Qantas)** – Los Angeles → Sydney

Status oznaczony jako `scheduled (TEST)`.

---

## 🛠️ Technologie

- Flutter (3.29.2)
- Dart (3.7.2)
- Hive (lokalna baza danych)
- AviationStack API
- ReqRes API (autoryzacja)
- Google Maps Flutter Plugin (`google_maps_flutter`)
- Obsługa `.env` plików (`flutter_dotenv`)

---

## 🚧 Napotkane problemy i rozwiązania

- **`flutter` not recognized** – dodano Flutter do PATH
- **Niepoprawna nazwa paczki** – zmieniono na `flight_tracker`
- **Brak danych geo** – fallback na loty testowe
- **Błąd NDK** – wymuszono wersję NDK w `build.gradle.kts`
- **Wymóg API Key dla ReqRes** – rozwiązany przez lokalne .env
- **Wylogowanie i przekierowanie** – czyszczona sesja Hive i reset ekranu

---

## ▶️ Uruchomienie aplikacji

1. **Zainstaluj Flutter SDK**  
👉 https://docs.flutter.dev/get-started/install

2. **Klonuj repozytorium**

```bash
git clone https://github.com/mmorawiak/flight_tracker.git
cd flight_tracker
```

3. **Utwórz plik `.env`**

```env
AVIATIONSTACK_API_KEY=your_api_key_here
GOOGLE_MAPS_API_KEY=your_maps_key_here
REQRES_API_KEY=your_dummy_key_if_needed
```

4. **Instalacja zależności**

```bash
flutter pub get
```

5. **Dodaj klucz Google Maps do AndroidManifest.xml**

```xml
<meta-data
  android:name="com.google.android.geo.API_KEY"
  android:value="${GOOGLE_MAPS_API_KEY}" />
```

6. **Uruchom emulator Androida**

7. **Start aplikacji**

```bash
flutter run
```

---

## 🗺️ Możliwe do zrealizowania funkcje

- [ ] Zapis ulubionych lotów (Hive)
- [ ] Testy jednostkowe i widgetowe
- [ ] Tryb offline (cacheowanie danych)
- [ ] Responsywność (tablet, landscape mode)
- [ ] System tłumaczeń (i18n)

---

## 🔑 API Keys

- AviationStack API Key (w `.env`)
- Google Maps API Key (w `.env`)
- ReqRes API (symulacja autoryzacji)

---

## 📁 Struktura projektu

```
lib/
├── main.dart
├── models/
│   └── flight_model.dart
├── services/
│   ├── flight_service.dart
│   └── user_service.dart
└── screens/
    ├── login_screen.dart
    ├── search_screen.dart
    ├── flights_list_screen.dart
    ├── flight_details_screen.dart
    └── flight_map_screen.dart

```

---

## 📄 Licencja

MIT License

