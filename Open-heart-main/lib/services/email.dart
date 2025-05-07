import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EmailSender {
  static Future<void> sendEmailConfirmation(
      BuildContext context,
      String email,
      int amount, {
        String charityDescription = '',
        String userName = '',
      }) async {
    const serviceId = 'service_wqpeqxv';
    const templateId = 'template_2iw23b6';
    const userId = 'Bm503EkAxqgOAqJvi';

    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');

    try {
      final response = await http.post(
        url,
        headers: {
          'origin': 'http://localhost',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'service_id': serviceId,
          'template_id': templateId,
          'user_id': userId,
          'template_params': {
            'to_email': email,
            'user_email': email,
            'amount': amount.toString(),
            'charity_description': charityDescription,
            'user_name': userName,
          },
        }),
      );

      if (response.statusCode == 200) {
        print('✅ Email sent successfully!');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Email confirmation sent."),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        print('❌ Email failed: ${response.body}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Email failed: ${response.body}"),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      print('⚠️ Email error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Email send error: $e"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
