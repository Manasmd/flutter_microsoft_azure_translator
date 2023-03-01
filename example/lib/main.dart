import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:microsoft_azure_translator/microsoft_azure_translator.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // MicrosoftAzureTranslator.translate(text, fromLanguageCode, toLanguageCode)
    // MicrosoftAzureTranslator.instance.translate("How are you?", "en", "ta");

    if (dotenv.env['MICROSOFT_AZURE_SUBSCRIPTION_KEY'] != null && dotenv.env['MICROSOFT_AZURE_SUBSCRIPTION_REGION'] != null) {
      MicrosoftAzureTranslator.initialize(dotenv.env['MICROSOFT_AZURE_SUBSCRIPTION_KEY']!, dotenv.env['MICROSOFT_AZURE_SUBSCRIPTION_REGION']!);
      translate();
    }
  }

  Future<void> translate() async {
    List<dynamic>? translated = await MicrosoftAzureTranslator.instance.translate("how are you?", "en", "yue");

    if (translated != null) {
      print('received translation from package..');
      print(translated);

      translated.forEach((translatedItem) {
        print(translatedItem);
        print(translatedItem["text"]);
      });
      // var decodedTranslations = json.decode(translated);

      // print(decodedTranslations[0]["translations"][0]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              "Test",
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
