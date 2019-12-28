import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:trial/models/send_email.dart';

class APIManager {
  static final String urlWebsite = "https://api.sendgrid.com/v3";

  static void postEmail(SendEmail email) async {
    final headers = {
      "Authorization":
          "Bearer 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",
      "Content-Type": "application/json",
    };

    try {
      final response = await http.post(
        '$urlWebsite/mail/send',
        headers: headers,
        body: json.encode(email),
      );
      if ((response.statusCode >= 200) & (response.statusCode < 300)) {
        print('ok success');
      } else {
        print('statusss: ${response.statusCode}');
        throw Exception('unsucess');
      }
    } on Exception catch (e) {
      throw Exception(e);
    }
  }
}
