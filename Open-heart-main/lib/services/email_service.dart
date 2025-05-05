import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class EmailSender {
  static Future<void> sendEmailConfirmation(
      BuildContext context, String email, int amount) async {
    const serviceId = 'service_wqpeqxv';
    const templateId = 'template_nenc1dj';
    const userId = 'Bm503EkAxqgOAqJvi';

    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');

    try {
      final response = await http.post(
        Uri.parse('https://api.emailjs.com/api/v1.0/email/send'),
        headers: {
          'origin': 'http://localhost',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'service_id': serviceId,
          'template_id': templateId,
          'user_id': userId,
          'template_params': {
            'to_email': email,           // <-- MATCHES "To Email"
            'user_email': email,         // <-- MATCHES template variable
            'name': 'Open Heart Team',   // <-- Optional
            'amount': amount.toString(), // <-- Used in body
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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Email send error: $e"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
