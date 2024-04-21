# crypto_stats

[![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link]

An application that shows current prices for famous cryptocurrencies.

---

## Getting Started 🚀

## Assets 🎨

The `assets` directory houses images, fonts, and any other files you want to
include with your application.

The `assets/images` directory contains [resolution-aware images][resolution_aware_assets_link].

### Generating assets 🖼

We use [flutter_gen][flutter_gen_link] to generate asset classes like `Assets` and `FontFamily`. This helps us avoid commiting typos when writing an asset file name and to access additional properities like height of images.

The configuration for this tool is already on your pubspec. Also the `flutter_gen_runner` is packed, so your asset classes are generated when you run:

```sh
dart run build_runner build --delete-conflicting-outputs
```

Then, to reference the asset you can call:

```dart
Assets.images.noScopeLogo.image(height: 42),
```

_\*Note: Remember to add your asset directories to your pubspec too._

## Localization 🌎

This project relies on [flutter_localizations][flutter_localizations_link] and follows the [official internationalization guide for Flutter][internationalization_link].

It generates localized messages based on arb files found in the `lib/src/l10n` directory.

### Adding Strings 🪢

1. To add a new localizable string, open the `app_en.arb` file at `lib/l10n/arb/app_en.arb`.

```arb
{
    "@@locale": "en",
    "hello": "Hello!",
    "@hello": {
        "description": "Hello message"
    }
}
```

2. Then add a new key/value and description.

```arb
{
    "@@locale": "en",
    "hello": "Hello!",
    "@hello": {
        "description": "Hello message"
    },
    "goodbye": "Good-bye!",
    "@goodbye": {
        "description": "Good-bye message"
    }
}
```

3. Use the new string.

```dart
import 'package:crypto_stats/l10n/l10n.dart';

@override
Widget build(BuildContext context) {
  final l10n = context.l10n;
  return Text(l10n.hello);
}
```

### Adding Supported Locales 📍

Update the `CFBundleLocalizations` array in the `Info.plist` at `ios/Runner/Info.plist` to include the new locale.

```xml
    ...

    <key>CFBundleLocalizations</key>
	<array>
		<string>en</string>
		<string>es</string>
	</array>

    ...
```

### Adding Translations 🔄

To support additional languages, please visit the tutorial on [Internationalizing Flutter apps][internationalizing_flutter_apps_link].

1. For each supported locale, add a new ARB file in `lib/l10n/arb`.

```
├── l10n
│   ├── arb
│   │   ├── app_en.arb
│   │   └── app_es.arb
```

2. Add the translated strings to each `.arb` file:

`app_en.arb`

```arb
{
    "@@locale": "en",
    "hello": "Hello!",
    "@hello": {
        "description": "Hello message"
    }
}
```

`app_es.arb`

```arb
{
    "@@locale": "es",
    "hello": "¡Hola!",
    "@hello": {
        "description": "Mensaje de hola"
    }
}
```


[flutter_docs_link]: https://flutter.dev/docs
[flutter_gen_link]: https://pub.dev/packages/flutter_gen
[flutter_localizations_link]: https://api.flutter.dev/flutter/flutter_localizations/flutter_localizations-library.html
[internationalization_link]: https://flutter.dev/docs/development/accessibility-and-localization/internationalization
[internationalizing_flutter_apps_link]: https://flutter.dev/docs/development/accessibility-and-localization/internationalization
[mason_link]: https://github.com/felangel/mason
[resolution_aware_assets_link]: https://flutter.dev/docs/development/ui/assets-and-images#resolution-aware
[skeleton_pr_link]: https://github.com/flutter/flutter/pull/83530
[very_good_analysis_badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis
[very_good_core_link]: https://github.com/VeryGoodOpenSource/very_good_cli/blob/main/doc/very_good_core.md
[very_good_ventures_link]: https://github.com/vGVentures/