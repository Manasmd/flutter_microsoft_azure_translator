library microsoft_azure_translator;

import 'dart:convert';
import 'package:http/http.dart' as http_client;

/// A Calculator.
class MicrosoftAzureTranslator {
  static final MicrosoftAzureTranslator instance = MicrosoftAzureTranslator._internal();

  late String _subscriptionKey;
  late String _subscriptionRegion;

  MicrosoftAzureTranslator._internal();

  get getSubscriptionKey => _subscriptionKey;

  get getSubscriptionRegion => _subscriptionRegion;

  factory MicrosoftAzureTranslator.initialize(String subscriptionKey, String subscriptionRegion) {
    instance._subscriptionKey = subscriptionKey;
    instance._subscriptionRegion = subscriptionRegion;
    return instance;
  }

  Future<List<dynamic>?> translate(String text, String fromLanguageCode, String toLanguageCode) async {
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
    var response = await http_client.post(url, headers: headers, body: json.encode(items));
    if (!response.body.isNotEmpty) {
      var decodedTranslations = [];
      var decodedData = json.decode(response.body);
      if (decodedData[0]["translations"] != null) {
        decodedTranslations = decodedData[0]["translations"];
      }
      return decodedTranslations;
    }
    return null;
  }
}
