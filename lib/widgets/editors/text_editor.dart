import 'package:bebrain/helper/validation_helper.dart';
import 'package:bebrain/widgets/editors/base_editor.dart';
import 'package:flutter/material.dart';

class TextEditor extends StatefulWidget {
  final String? initialValue;
  final Function(String?) onChanged;
  final bool required;
  final Widget? suffixIcon;

  const TextEditor({
    super.key,
    required this.initialValue,
    required this.onChanged,
    this.required = true,
    this.suffixIcon,
  });

  @override
  State<TextEditor> createState() => _TextEditorState();
}

class _TextEditorState extends State<TextEditor> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BaseEditor(
      initialValue: widget.initialValue,
      required: widget.required,
      suffixIcon: widget.suffixIcon,
      onChanged: (value) {
        if (value.isEmpty) {
          widget.onChanged(null);
        } else {
          widget.onChanged(value);
        }
      },
      validator: (value) {
        if (!widget.required && (value == null || value.isEmpty)) {
          return null;
        }
        return ValidationHelper.general(context, value);
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
