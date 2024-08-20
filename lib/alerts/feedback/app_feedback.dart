import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/widgets/stretch_button.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

extension AppFeedbacks on BuildContext {
  void showToast(String msg) {
    Fluttertoast.showToast(msg: msg);
  }

  void showSnackBar(
    String msg, {
    bool floating = true,
    int duration = 4,
  }) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(msg),
        behavior: floating ? SnackBarBehavior.floating : SnackBarBehavior.fixed,
        duration: Duration(seconds: duration),
      ),
    );
  }

  Future<T?> showDialog<T>({
    String? titleText,
    String? confirmTitle,
    Widget? titleWidget,
    String? bodyText,
    Widget? bodyWidget,
    List<Widget>? actions,
    double? maxWidth,
    Color? confirmButtonBackgroundColor,
    Color? cancelButtonForegroundColor,
    bool warning = false,
  }) async {
    return showGeneralDialog<T?>(
      barrierDismissible: true,
      barrierLabel: '',
      context: this,
      transitionBuilder: (context, a1, a2, widget) {
        return Opacity(
          opacity: a1.value,
          child: AlertDialog(
            titlePadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            title: titleWidget ??
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 25,
                      height: 25,
                      child: IconButton.outlined(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        padding: EdgeInsets.zero,
                        icon: const Center(child: Icon(Icons.close)),
                      ),
                    ),
                    Text(titleText!),
                    const SizedBox(width: 25),
                  ],
                ),
            content: bodyWidget ?? Text(bodyText!, textAlign: TextAlign.center),
            actions: actions ??
                [
                  // TextButton(
                  //   onPressed: () {
                  //     context.pop();
                  //   },
                  //   style: TextButton.styleFrom(
                  //     foregroundColor: cancelButtonForegroundColor ?? (warning ? context.colorScheme.onSurface : null),
                  //   ),
                  //   child: Text(context.appLocalization.cancel),
                  // ),
                  StretchedButton(
                    backgroundColor: confirmButtonBackgroundColor ?? (warning ? context.colorPalette.redE66 : null),
                    onPressed: () {
                      context.pop(true);
                    },
                    child: Text(confirmTitle?? context.appLocalization.confirm),
                  ),
                ],
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 240),
      pageBuilder: (BuildContext context, animation1, animation2) {
        return const SizedBox.shrink();
      },
    ).then<T?>((value) => value);
  }

  Future<T?> showBottomSheet<T>(
    BuildContext context, {
    required Widget Function(BuildContext) builder,
    double? maxHeight,
  }) {
    return showModalBottomSheet<T?>(
      context: context,
      isScrollControlled: true,
      enableDrag: true,
      showDragHandle: true,
      useSafeArea: true,
      useRootNavigator: true,
      backgroundColor: context.colorScheme.background,
      elevation: 0,
      constraints: maxHeight == null ? null : BoxConstraints(maxHeight: maxHeight),
      builder: builder,
    ).then((value) => value);
  }

  
}
