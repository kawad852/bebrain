import 'package:flutter/material.dart';

class AuthHeader extends StatelessWidget {
  final String title;
  final String? body;

  const AuthHeader({
    super.key,
    required this.title,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return ListBody(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 6),
        if (body != null)
          Padding(
            padding: const EdgeInsets.only(top: 6, bottom: 30),
            child: Text(
              body!,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),
      ],
    );
  }
}
