import 'package:bebrain/helper/validation_helper.dart';
import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/widgets/editors/base_editor.dart';
import 'package:bebrain/widgets/titled_textfield.dart';
import 'package:flutter/material.dart';

class PasswordEditor extends StatefulWidget {
  final String? initialValue;
  final Function(String?) onChanged;
  final bool withErrorIndicator;

  const PasswordEditor({
    super.key,
    required this.onChanged,
    required this.initialValue,
    this.withErrorIndicator = true,
  });

  @override
  State<PasswordEditor> createState() => _PasswordEditorState();
}

class _PasswordEditorState extends State<PasswordEditor> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TitledTextField(
      title: context.appLocalization.password,
      child: BaseEditor(
        initialValue: widget.initialValue,
        obscureText: _obscureText,
        required: true,
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
          icon: Icon(_obscureText ? Icons.remove_red_eye : Icons.remove_red_eye_rounded),
        ),
        onChanged: (value) {
          if (value.isEmpty) {
            widget.onChanged(null);
          } else {
            widget.onChanged(value);
          }
        },
        validator: (value) => ValidationHelper.password(context, value),
      ),
    );
  }
}
