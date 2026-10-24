/// Follows `nextPageToken` until the API has no more pages, and returns the
/// first page together with the items of every page in order.
///
/// The first page is handed back because the fields beside the list (such
/// as `timeZone`) are only needed once.
///
/// Guarded twice against a server that never stops paging: a token seen
/// before ends the walk, and so does [maxPages]. Either would otherwise keep
/// a pull-to-refresh spinning on a loop of its own requests.
Future<({P first, List<T> items})> collectPages<P, T>({
  required Future<P> Function(String? pageToken) fetchPage,
  required List<T>? Function(P page) itemsOf,
  required String? Function(P page) nextTokenOf,
  int maxPages = 20,
}) async {
  final first = await fetchPage(null);
  final items = <T>[...?itemsOf(first)];
  final seenTokens = <String>{};

  var token = nextTokenOf(first);
  var pages = 1;

  while (token != null &&
      token.isNotEmpty &&
      pages < maxPages &&
      seenTokens.add(token)) {
    final page = await fetchPage(token);
    items.addAll(itemsOf(page) ?? const []);
    token = nextTokenOf(page);
    pages++;
  }

  return (first: first, items: items);
}
