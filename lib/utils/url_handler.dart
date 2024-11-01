import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlHandler {
  static Future<void> openGitHub(BuildContext context) async {
    final Uri url = Uri.parse('https://github.com/Yuzu02/exerapp');
    try {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Could not open ${url.toString()}'),
          ),
        );
      }
    }
  }
}
