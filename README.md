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

This package allows you to quickly set up Microsoft Azure Translator for Flutter. All you need is your `Ocp-Apim-Subscription-Key` & `

## Features

TODO: List what your package can do. Maybe include images, gifs, or videos.

## Getting started

Head our to this link tocreate your Azure account and setup translator resources:
https://learn.microsoft.com/en-gb/azure/cognitive-services/Translator/create-translator-resource

## Usage

Initialize the translator by passing the subscriptKey andsubscriptionRegion

```dart
  MicrosoftAzureTranslator.initialize(dotenv.env['MICROSOFT_AZURE_SUBSCRIPTION_KEY']!, dotenv.env['MICROSOFT_AZURE_SUBSCRIPTION_REGION']!);

  List<dynamic>? translated = await MicrosoftAzureTranslator.instance.translate("how are you?", "en", "yue");

   if (translated != null) {
      print('received translation from package..');
      print(translated);

      translated.forEach((translatedItem) {
        print(translatedItem);
        print(translatedItem["text"]);
      });
    }
```

## Additional information

TODO: 
- Allow passing a list of languages codes to be translated at once

