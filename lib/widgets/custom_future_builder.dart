import 'package:bebrain/alerts/errors/app_error_widget.dart';
import 'package:bebrain/widgets/custom_loading_indicator.dart';
import 'package:flutter/material.dart';

class CustomFutureBuilder<T> extends StatelessWidget {
  final Future<T> future;
  final VoidCallback onRetry;
  final Function(BuildContext context, AsyncSnapshot<T?> snapshot) onComplete;
  final Function()? onLoading;
  final Function(AsyncSnapshot<T?> snapshot)? onError;
  final bool withBackgroundColor;
  final bool sliver;

  const CustomFutureBuilder({
    Key? key,
    required this.future,
    required this.onRetry,
    required this.onComplete,
    this.onLoading,
    this.onError,
    this.withBackgroundColor = false,
    this.sliver = false,
  }) : super(key: key);

  Widget _buildLoading() {
    return onLoading == null ? CustomLoadingIndicator(withBackgroundColor: withBackgroundColor) : onLoading!();
  }

  Widget _buildError(AsyncSnapshot<T?> snapshot) {
    return onError == null
        ? AppErrorWidget(
            error: snapshot.error,
            onRetry: onRetry,
          )
        : onError!(snapshot);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T?>(
      future: future,
      builder: (context, AsyncSnapshot<T?> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return sliver ? SliverToBoxAdapter(child: _buildLoading()) : _buildLoading();
          case ConnectionState.done:
          default:
            if (snapshot.hasData) {
              return onComplete(context, snapshot);
            } else {
              return sliver ? SliverToBoxAdapter(child: _buildError(snapshot)) : _buildError(snapshot);
            }
        }
      },
    );
  }
}
