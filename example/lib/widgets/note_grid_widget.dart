import 'dart:developer' as developer;
import 'package:example/data/models/note.dart';
import 'package:flutter/material.dart';

class NoteGridWidget extends StatelessWidget {
  final Note note;

  NoteGridWidget(this.note);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8))
          ),
          color: Theme.of(context).cardColor
      ),
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(note.title, style: Theme.of(context).textTheme.subtitle1.copyWith(
            fontWeight: FontWeight.w800
          ),),
          SizedBox(height: 12,),
          Text(note.content, style: Theme.of(context).textTheme.bodyText2,)
        ],
      ),
    );
  }
}
