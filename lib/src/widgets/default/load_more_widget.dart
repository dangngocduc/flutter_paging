import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadMoreWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      alignment: Alignment.center,
      child: CupertinoActivityIndicator(),
    );
  }
}
