import 'package:example/data/models/note.dart';
import 'package:example/data/note_repository.dart';
import 'package:paging/paging.dart' as paging;
import 'package:tuple/tuple.dart';

class ListViewDataSource extends paging.PageKeyedDataSource<int, Note> {
  NoteRepository noteRepository;
  ListViewDataSource(this.noteRepository) {
    isEndList = false;
  }

  @override
  Future<Tuple2<List<Note>, int>> loadInitial() async {
    final result = await noteRepository.getNotes(0);
    return Tuple2(result, 0);
  }

  @override
  Future<Tuple2<List<Note>, int>> loadPageAfter(int params) async {
    if (params == 6) isEndList = true;
    final result = await noteRepository.getNotes(params + 1);
    return Tuple2(result, params + 1);
  }
}