import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';

Future<void> saveDataToSharedPreferences(Map<String, dynamic> responseData) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  
  await prefs.setString("nationalPhoneNumber", responseData["nationalPhoneNumber"] ?? "");
  await prefs.setString("formattedAddress", responseData["formattedAddress"] ?? "");
  await prefs.setDouble("rating", responseData["rating"] ?? 0.0);
  await prefs.setBool("isOpenNow", responseData["isOpenNow"] ?? false);
  await prefs.setString("priceLevel", responseData["priceLevel"] ?? "");
  await prefs.setString("displayName", responseData["displayName"] ?? "");
}

Future<Map<String, dynamic>> getDataFromSharedPreferences() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  
  String nationalPhoneNumber = prefs.getString("nationalPhoneNumber") ?? "";
  String formattedAddress = prefs.getString("formattedAddress") ?? "";
  double rating = prefs.getDouble("rating") ?? 0.0;
  bool isOpenNow = prefs.getBool("isOpenNow") ?? false;
  String priceLevel = prefs.getString("priceLevel") ?? "";
  String displayName = prefs.getString("displayName") ?? "";

  return {
    "nationalPhoneNumber": nationalPhoneNumber,
    "formattedAddress": formattedAddress,
    "rating": rating,
    "isOpenNow": isOpenNow,
    "priceLevel": priceLevel,
    "displayName": displayName,
  };
}


Future<Map<String, dynamic>> fetchNearbyPlaces() async {
  Map<String, dynamic> responseData = {}; 

  Map<String, dynamic> requestData = {
    "includedTypes": ["restaurant"],
    "maxResultCount": 20,
    "locationRestriction": {
      "circle": {
        "center": {"latitude": 47.478419, "longitude": -0.563166},
        "radius": 500.0
      }
    }
  };

  String requestBody = jsonEncode(requestData);

  Map<String, String> headers = {
    'Content-Type': 'application/json',
    'X-Goog-Api-Key': 'AIzaSyBY9ljgFMmrMPCdb2-66IUtcTURP4I3RCg', 
    'X-Goog-FieldMask': 'places.websiteUri,places.displayName.text,places.nationalPhoneNumber,places.formattedAddress,places.rating,places.regularOpeningHours.openNow,places.priceLevel'
  };

  String apiUrl = 'https://places.googleapis.com/v1/places:searchNearby';

  try {
    http.Response response = await http.post(
      Uri.parse(apiUrl),
      headers: headers,
      body: requestBody, 
    );

    // Gérer la réponse
    if (response.statusCode == 200) {
      // Si succès alors : 
      Random random = Random();
      int randomNumber = random.nextInt(20);

      Map<String, dynamic> jsonData = json.decode(response.body);
      Map<String, dynamic> chosenItem = jsonData['places'][randomNumber];

      String nationalPhoneNumber = chosenItem["nationalPhoneNumber"];
      String formattedAddress = chosenItem["formattedAddress"];
      double rating = chosenItem["rating"].toDouble(); 
      bool isOpenNow = chosenItem["regularOpeningHours"]["openNow"];
      String priceLevel = chosenItem.containsKey("priceLevel") ? chosenItem["priceLevel"] : "null"; 
      String displayName = chosenItem["displayName"]["text"];

      responseData = {
        "nationalPhoneNumber": nationalPhoneNumber,
        "formattedAddress": formattedAddress,
        "rating": rating,
        "isOpenNow": isOpenNow,
        "priceLevel": priceLevel,
        "displayName": displayName,
      };

      await saveDataToSharedPreferences(responseData);
    } else {
      throw('Échec de la requête : ${response.statusCode}');
    }
  } catch (e) {
    throw('Erreur lors de la requête : $e');
  }

  return responseData; 
  
}
