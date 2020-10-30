import 'dart:developer' as developer;

import 'package:example/data/models/note.dart';

class NoteRepository {
  static const TAG = 'NoteRepository';

  Future<List<Note>> getNotes(int pageIndex) async {
    developer.log('getNotes [pageIndex] $pageIndex', name: TAG);
    List<Note> datas = [];
    for (var i = 0; i < 20 ; i++) {
      datas.add(Note.fakeId(i + 20*pageIndex));
    }
    return Future.delayed(
        Duration(milliseconds: 500),
        () => datas
    );
  }

}