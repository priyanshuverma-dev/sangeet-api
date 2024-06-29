<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

Sangeet API is a SDK on top of Jio cinema API to integrate with Sangget app.

## Features

* Fetch Songs by Id, Song lyrics, song radio.
* Fetch Artist by Id, Artist songs, Artist albums.
* Fetch Playlist by Id.
* Fetch Album by Id.
* Fetch Seach songs, artist, playlist, album and global search.
* Fetch browse data, trending data, charts.
* Unit Tests. ✅

## Getting started

Just install and use.

```bash
flutter pub add sangeet_api
```

## Usage

How to use.
Make a instance of SDK and use that
```dart
const api = SangeetAPI();
final result = await api.explore.trends();
// use result 

```

## Additional information

Author [Priyanshu Verma](https://github.com/priyanshuverma-dev/sangeet-api)
