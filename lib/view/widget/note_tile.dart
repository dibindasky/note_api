import 'package:flutter/material.dart';
import 'package:todo_api/view/add_edit.dart';

import '../../model/to_do_model/item.dart';

class NoteTile extends StatelessWidget {
  const NoteTile({
    super.key,
    required this.color,
    required this.note,
  });

  final int color;
  final Item note;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ScreenEditAdd(note: note,action: ActionType.update),
          )),
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.primaries[color].withOpacity(0.3),
          borderRadius: BorderRadius.circular(15),
        ),
        margin: const EdgeInsets.all(5),
        child:  Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
              note.title!,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Divider(
              color: Colors.white,
            ),
            Text(
              maxLines: 7,
              note.description!,
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
