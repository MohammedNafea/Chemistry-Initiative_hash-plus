import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provider for bookmarked topics - shared state across QuestionPage and BookmarkScreen.
final bookmarkProvider =
    NotifierProvider<BookmarkNotifier, List<Map<String, String>>>(BookmarkNotifier.new);

class BookmarkNotifier extends Notifier<List<Map<String, String>>> {
  @override
  List<Map<String, String>> build() => [];

  void add(Map<String, String> topic) {
    final key = '${topic['image']}_${topic['title']}';
    if (state.any((t) => '${t['image']}_${t['title']}' == key)) return;
    state = [...state, topic];
  }

  void remove(Map<String, String> topic) {
    final key = '${topic['image']}_${topic['title']}';
    state = state.where((t) => '${t['image']}_${t['title']}' != key).toList();
  }

  bool contains(Map<String, String> topic) {
    final key = '${topic['image']}_${topic['title']}';
    return state.any((t) => '${t['image']}_${t['title']}' == key);
  }
}
