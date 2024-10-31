// github_icon_button.dart
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:exerapp/utils/url_handler.dart';

class GitHubIconButton extends StatelessWidget {
  const GitHubIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const FaIcon(FontAwesomeIcons.github),
      onPressed: () async {
        final messenger =
            ScaffoldMessenger.of(context); // Obtiene el ScaffoldMessenger
        try {
          UrlHandler.openGitHub(context); // Llama a la función openGithub
        } catch (e) {
          messenger.showSnackBar(SnackBar(
              content: Text(e
                  .toString()))); // Muestra un mensaje de error si no se puede abrir el enlace
        }
      },
      tooltip: 'Ver código en GitHub',
    );
  }
}
