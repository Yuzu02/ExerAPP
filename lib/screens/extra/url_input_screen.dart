// screens/extra/url_input_screen.dart
import 'package:exerapp/exercise/web_view.dart';
import 'package:flutter/material.dart';

class UrlInputScreen extends StatefulWidget {
  const UrlInputScreen({super.key});

  @override
  State<UrlInputScreen> createState() => _UrlInputScreenState();
}

class _UrlInputScreenState extends State<UrlInputScreen> {
  final TextEditingController _urlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('URL Input'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _urlController,
              decoration: const InputDecoration(
                labelText: 'Enter URL',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _navigateToWebView,
              child: const Text('Go'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }

  bool isValidUrl(String url) {
    try {
      final uri = Uri.parse(url);
      return uri.isAbsolute;
    } catch (e) {
      return false;
    }
  }

  void _navigateToWebView() {
    String url = _urlController.text.trim();

    // Add https:// if no protocol is specified
    if (!url.startsWith('http://') && !url.startsWith('https://')) {
      url = 'https://$url';
    }

    if (isValidUrl(url)) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WebViewScreen(url: url),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor ingresa una URL válida'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
