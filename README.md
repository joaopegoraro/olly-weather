# Olly Weather

## Index

- [About](#about)
- [Images](#images)
- [Libraries](#tech)
- [API](#api)
- [How to run?](#how-to-run)
- [Features](#features)

## [About](#about)

Test project for the Fullstack Flutter engineer position at [Olly Olly](https://www.ollyolly.com/).

## [Images](#images)

### Mobile
<p float="left">
  <img src="./screenshots/screenshot-mobile-1.png?raw=true" width="32%" />
  <img src="./screenshots/screenshot-mobile-2.png?raw=true" width="32%" />
  <img src="./screenshots/screenshot-mobile-3.png?raw=true" width="32%" />
</p>
<p float="left">
  <img src="./screenshots/screenshot-mobile-4.png?raw=true" width="32%" />
  <img src="./screenshots/screenshot-mobile-5.png?raw=true" width="32%" />
  <img src="./screenshots/screenshot-mobile-6.png?raw=true" width="32%" />
</p>

### Web
<p float="left">
  <img src="./screenshots/screenshot-web-1.png?raw=true" width="100%" />
  <img src="./screenshots/screenshot-web-2.png?raw=true" width="100%" />
</p>
<p float="left">
  <img src="./screenshots/screenshot-web-3.png?raw=true" width="100%" />
  <img src="./screenshots/screenshot-web-4.png?raw=true" width="100%" />
</p>

## [Libraries](#tech)

- [flutter_dotenv](https://pub.dev/packages/flutter_dotenv)
  - Used to store the API information
- [http](https://pub.dev/packages/http)
  - Needed to make API calls
- [logger](https://pub.dev/packages/logger)
  - Makes debug console prints easier to read
- [mvvm_riverpod](https://github.com/joaopegoraro/mvvm_riverpod) - My library!
  - MVVM architecture made easy with Riverpod
- [riverpod](https://pub.dev/packages/riverpod)
  - No comments needed
- [shared_preferences](https://pub.dev/packages/shared_preferences)
  - Simple persistence for all platforms
- [geolocator](https://pub.dev/packages/geolocator)
  - Needed to grab location info for the weather
- [flutter_svg](https://pub.dev/packages/flutter_svg) & [vector_graphics](https://pub.dev/packages/vector_graphics)
  - Display SVGs
- [lottie](https://pub.dev/packages/lottie)
  - Render After Effects animations. Used to display those nice weather animations
- [intl](https://pub.dev/packages/intl)
  - Deal with date formatting

## [API](#api)

Used the [OpenWeatherAPI](https://openweathermap.org), more specifically the [5 day weather forecast](https://openweathermap.org/forecast5).

- [Response reference](https://openweathermap.org/forecast5#parameter)
- [Climate conditions reference](https://openweathermap.org/weather-conditions)

## [How to run?](#how-to-run)

Since I commited the [`.env`](/.env) file, the project is plug and play:

- Download or clone the project.
- `flutter run` in the project root.
- If `flutter run -d chrome`, make sure to **NOT** use the HTML rendering, otherwise the Lottie animations won't work (see [this](https://stackoverflow.com/a/73699401) for more details).
  
## [Features](#features)

✔️ User authentication

✔️ Hour-by-hour forecast for the next 5 days of the current location (user can update the current location by pressing a button)

✔️ User can choose their preferred temperature unit to display (metric, imperial, standard)

✔️ Animated icons for the various climate conditions

✔️ Web, mobile web and mobile app designs

✔️ Dark mode

✔️ Navigation animation

