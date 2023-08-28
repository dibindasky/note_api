import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../controller/business_logic/notes/notes_bloc.dart';
import 'screen_add_edit.dart';
import '../widget/note_tile.dart';

class ScreenNotes extends StatelessWidget {
  ScreenNotes({super.key});
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      context.read<NotesBloc>().add(ReCallApiEvent());
    });
    final size = MediaQuery.of(context).size;
    return Scaffold(
      key: _key,
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Column(
          children: [
            InkWell(
              onTap: () => context.read<NotesBloc>().add(ReCallApiEvent()),
              child: Container(
                margin: const EdgeInsets.only(bottom: 10, top: 10),
                height: size.height * 0.05,
                width: size.width * 0.50,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: const Center(child: Text('AllNotes')),
              ),
            ),
            Expanded(
              child: BlocBuilder<NotesBloc, NotesState>(
                builder: (context, state) {
                  return GridView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    shrinkWrap: true,
                    itemCount: state.notesList.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, childAspectRatio: 1 / 1.3),
                    itemBuilder: (context, index) {
                      int color = Random().nextInt(Colors.primaries.length);
                      return NoteTile(
                        color: color,
                        note: state.notesList[index],
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        onPressed: () async {
          // await getAllNotes();
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
