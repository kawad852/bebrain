class VexPaginatorModel<M> {
  List<Object> docs;
  bool isFetchingMore;
  bool hasMore;
  int pageKey;
  Function() fetchMore;
  Function() fetch;

  VexPaginatorModel({
    required this.docs,
    this.pageKey = 1,
    required this.isFetchingMore,
    required this.hasMore,
    required this.fetchMore,
    required this.fetch,
  });
}
