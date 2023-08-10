import 'dart:math';

import 'package:flutter/material.dart';

import '../controller/api_calls.dart';
import 'add_edit.dart';
import 'widget/note_tile.dart';

class ScreenNotes extends StatelessWidget {
  ScreenNotes({super.key});
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getAllNotes();
    });
    final size = MediaQuery.of(context).size;
    return Scaffold(
      key: _key,
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 10,top: 10),
              height: size.height * 0.05,
              width: size.width * 0.50,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: const Center(child: Text('AllNotes')),
            ),
            Expanded(
                child: ValueListenableBuilder(
              valueListenable: itemsNotifier,
              builder: (context, items, child) => GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                shrinkWrap: true,
                itemCount: items.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (context, index) {
                  int color = Random().nextInt(Colors.primaries.length);
                  return NoteTile(
                    color: color,
                    note: items[index],
                  );
                },
              ),
            )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        onPressed: () async {
          await getAllNotes();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ScreenEditAdd(action: ActionType.create),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
