library microsoft_azure_translator;

import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as httpClient;

/// A Calculator.
class MicrosoftAzureTranslator {
  /// Returns [value] plus 1.
  static final MicrosoftAzureTranslator instance = MicrosoftAzureTranslator._internal();

  late String _subscriptionKey;
  late String _subscriptionRegion;

  MicrosoftAzureTranslator._internal() {
    print('Microsoft Azure Translator instance has been created');
  }

  get getSubscriptionKey => _subscriptionKey;

  get getSubscriptionRegion => _subscriptionRegion;

  factory MicrosoftAzureTranslator.initialize(String subscriptionKey, String subscriptionRegion) {
    instance._subscriptionKey = subscriptionKey;
    instance._subscriptionRegion = subscriptionRegion;
    return instance;
  }

  Future<List<dynamic>?> translate(String text, String fromLanguageCode, String toLanguageCode) async {
    print('running translate funtion in package...');
    String domain = "api.cognitive.microsofttranslator.com";
    String path = "/translate";
    Map<String, String> parameters = {
      "api-version": "3.0",
      "from": fromLanguageCode,
      "to": toLanguageCode,
    };

    List<Map<String, String>> items = [
      {"Text": text}
    ];

    Map<String, String> headers = {"Ocp-Apim-Subscription-Key": _subscriptionKey, "Ocp-Apim-Subscription-Region": _subscriptionRegion, "Content-Type": "application/json"};

    var url = Uri.https(domain, path, parameters);
    var response = await httpClient.post(url, headers: headers, body: json.encode(items));
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response != null) {
      if (response.body != null) {
        var decodedTranslations = [];
        var decodedData = json.decode(response.body);
        if (decodedData[0]["translations"] != null) {
          decodedTranslations = decodedData[0]["translations"];
        }
        return decodedTranslations;
      }
      return null;
    }
    return null;
  }
}
