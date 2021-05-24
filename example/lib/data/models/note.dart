class Note {
  static const TAG = 'Note';
  
  int id;
  String title;
  String content;

  Note(this.id, this.title, this.content);
  
  factory Note.fakeId(int id) {
    return Note(id, 'This is title $id', 'A callback can be called only once, and will throw if called again.');
  }
}