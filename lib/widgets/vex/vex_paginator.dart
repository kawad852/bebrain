import 'package:bebrain/model/vex_paginator_model.dart';
import 'package:bebrain/widgets/custom_future_builder.dart';
import 'package:flutter/material.dart';

class VexPaginator<T> extends StatefulWidget {
  final Future<T> Function(int pageKey) query;
  final Function()? onLoading;
  final Function(AsyncSnapshot<T?> snapshot)? onError;
  final Future<List<Object>> Function(T query) onFetching;
  final dynamic Function(BuildContext context, VexPaginatorModel<T> snapshot) builder;
  final int pageSize;
  final bool sliver;

  const VexPaginator({
    super.key,
    required this.query,
    required this.builder,
    this.onLoading,
    this.onError,
    required this.onFetching,
    required this.pageSize,
    this.sliver = false,
  });

  @override
  State<VexPaginator<T>> createState() => VexPaginatorState<T>();
}

class VexPaginatorState<T> extends State<VexPaginator<T>> {
  late Future<T> _future;
  late VexPaginatorModel<T> _firePaginator;
  int get _pageSize => widget.pageSize;
  late Future<T> Function(int) _query;

  void _fetch() async {
    _firePaginator = VexPaginatorModel(
      docs: [],
      fetchMore: _fetchMore,
      fetch: _fetch,
      hasMore: true,
      isFetchingMore: false,
    );
    _future = _query(1);
    var querySnapshot = await widget.onFetching(await _future);
    _firePaginator.docs = querySnapshot;
  }

  void _fetchMore() async {
    _firePaginator.isFetchingMore = true;
    _firePaginator.pageKey++;
    var querySnapshot = await widget.onFetching(await _query(_firePaginator.pageKey));
    Future.microtask(() {
      setState(() {
        _firePaginator.docs.addAll(querySnapshot);
      });
      if (querySnapshot.length < _pageSize) {
        _firePaginator.hasMore = false;
      }
      _firePaginator.isFetchingMore = false;
    });
  }

  void refresh() {
    _fetch();
  }

  @override
  void initState() {
    super.initState();
    _query = widget.query;
    _fetch();
  }

  @override
  Widget build(BuildContext context) {
    return CustomFutureBuilder(
      future: _future,
      onRetry: _fetch,
      sliver: widget.sliver,
      onLoading: widget.onLoading,
      onError: widget.onError,
      onComplete: (context, snapshot) {
        return widget.builder(context, _firePaginator);
      },
    );
  }
}
