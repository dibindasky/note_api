import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_api/business_logic/notes/notes_bloc.dart';

import '../../model/to_do_model/item.dart';

enum ActionType {
  update,
  create,
}

ValueNotifier<bool> isDeleting = ValueNotifier(false);
ValueNotifier<bool> isSaving = ValueNotifier(false);

class ScreenEditAdd extends StatelessWidget {
  ScreenEditAdd({super.key, this.note, required this.action});

  final Item? note;
  final ActionType action;
  final TextEditingController textController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    if (action == ActionType.update) {
      textController.text = note!.description!;
      titleController.text = note!.title!;
    }
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        actions: [
          Container(
            width: size.width * 0.20,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.white),
            child: BlocBuilder<NotesBloc, NotesState>(
              builder: (context, state) {
                return state.isDeleting
                    ? const Center(child: CircularProgressIndicator())
                    : ActionType.update == action
                        ? IconButton(
                            onPressed: () async {
                            context
                                  .read<NotesBloc>()
                                  .add(DeleteNoteEVent(id: note!.id!));
                                  
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.delete),
                          )
                        : IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.clear_sharp));
              },
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Container(
              width: size.width * 0.23,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.white),
              child: BlocBuilder<NotesBloc, NotesState>(
                builder: (context, state) {
                  return state.isSaving
                      ? const Center(child: CircularProgressIndicator())
                      : TextButton.icon(
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              if (action == ActionType.create) {
                                Item noteTemp = Item.create(
                                    description: textController.text,
                                    title: titleController.text,
                                    isCompleted: false);
                                // await addNote(note: noteTemp);
                                context
                                    .read<NotesBloc>()
                                    .add(AddNoteEvent(model: noteTemp));
                              } else {
                                context
                                    .read<NotesBloc>()
                                    .add(UpdateNoteEvent(model: note!));
                                // await updateNote(note: note!);
                              }
                              Navigator.pop(context);
                            }
                          },
                          icon: const Icon(
                            Icons.check,
                            color: Colors.black,
                          ),
                          label: const Text(
                            'Save',
                            style: TextStyle(color: Colors.black),
                          ),
                        );
                },
              )),
          const SizedBox(
            width: 20,
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) return 'title canot be empty';
                    return null;
                  },
                  textAlign: TextAlign.center,
                  controller: titleController,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Title',
                      suffixIcon: Icon(Icons.edit_outlined)),
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const Divider(
                  color: Colors.white,
                ),
                Container(
                  height: size.height * 0.7,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 2)),
                  margin: const EdgeInsets.all(15),
                  padding: const EdgeInsets.all(5),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) return 'notes cannot be empty';
                      return null;
                    },
                    maxLines: 35,
                    controller: textController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'your notes here',
                    ),
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}




// // ignore_for_file: use_build_context_synchronously

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:todo_api/business_logic/notes/notes_bloc.dart';

// import '../../model/to_do_model/item.dart';

// enum ActionType {
//   update,
//   create,
// }

// ValueNotifier<bool> isDeleting = ValueNotifier(false);
// ValueNotifier<bool> isSaving = ValueNotifier(false);

// class ScreenEditAdd extends StatelessWidget {
//   ScreenEditAdd({super.key, this.note, required this.action});

//   final Item? note;
//   final ActionType action;
//   final TextEditingController textController = TextEditingController();
//   final TextEditingController titleController = TextEditingController();
//   final formKey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     if (action == ActionType.update) {
//       textController.text = note!.description!;
//       titleController.text = note!.title!;
//     }
//     final size = MediaQuery.of(context).size;
//     return Scaffold(
//       backgroundColor: Colors.grey[200],
//       appBar: AppBar(
//         backgroundColor: Colors.grey[200],
//         actions: [
//           Container(
//               width: size.width * 0.20,
//               decoration: const BoxDecoration(
//                   borderRadius: BorderRadius.all(Radius.circular(10)),
//                   color: Colors.white),
//               child: ValueListenableBuilder(
//                 valueListenable: isDeleting,
//                 builder: (context, value, child) {
//                   return isDeleting.value
//                       ? const Center(child: CircularProgressIndicator())
//                       : ActionType.update == action
//                           ? IconButton(
//                               onPressed: () async {
//                                 isDeleting.value = true;
//                                 context.read<NotesBloc>().add(DeleteNoteEVent(id: note!.id!));
//                                 // await deleteNote(note!.id!);
//                                 isDeleting.value = false;
//                                 Navigator.pop(context);
//                               },
//                               icon: const Icon(Icons.delete),
//                             )
//                           : IconButton(
//                               onPressed: () {
//                                 Navigator.pop(context);
//                               },
//                               icon: const Icon(Icons.clear_sharp));
//                 },
//               )),
//           const SizedBox(
//             width: 20,
//           ),
//           Container(
//               width: size.width * 0.23,
//               decoration: const BoxDecoration(
//                   borderRadius: BorderRadius.all(Radius.circular(10)),
//                   color: Colors.white),
//               child: ValueListenableBuilder(
//                 valueListenable: isSaving,
//                 builder: (context, value, child) {
//                   return isSaving.value
//                       ? const Center(child: CircularProgressIndicator())
//                       : TextButton.icon(
//                           onPressed: () async {
//                             if (formKey.currentState!.validate()) {
//                               isSaving.value = true;
//                               if (action == ActionType.create) {
//                                 Item noteTemp = Item.create(
//                                     description: textController.text,
//                                     title: titleController.text,
//                                     isCompleted: false);
//                                 // await addNote(note: noteTemp);
//                                 context.read<NotesBloc>().add(AddNoteEvent(model: noteTemp));
//                               } else {
//                                 context.read<NotesBloc>().add(UpdateNoteEvent(model: note!));
//                                 // await updateNote(note: note!);
//                               }
//                               isSaving.value = false;
//                               Navigator.pop(context);
//                             }
//                           },
//                           icon: const Icon(
//                             Icons.check,
//                             color: Colors.black,
//                           ),
//                           label: const Text(
//                             'Save',
//                             style: TextStyle(color: Colors.black),
//                           ),
//                         );
//                 },
//               )),
//           const SizedBox(
//             width: 20,
//           )
//         ],
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Form(
//             key: formKey,
//             child: Column(
//               children: [
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 TextFormField(
//                   validator: (value) {
//                     if (value!.isEmpty) return 'title canot be empty';
//                     return null;
//                   },
//                   textAlign: TextAlign.center,
//                   controller: titleController,
//                   decoration: const InputDecoration(
//                       border: InputBorder.none,
//                       hintText: 'Title',
//                       suffixIcon: Icon(Icons.edit_outlined)),
//                   style: const TextStyle(
//                       fontSize: 20, fontWeight: FontWeight.bold),
//                 ),
//                 const Divider(
//                   color: Colors.white,
//                 ),
//                 Container(
//                   height: size.height * 0.7,
//                   decoration: BoxDecoration(
//                       border: Border.all(color: Colors.white, width: 2)),
//                   margin: const EdgeInsets.all(15),
//                   padding: const EdgeInsets.all(5),
//                   child: TextFormField(
//                     validator: (value) {
//                       if (value!.isEmpty) return 'notes cannot be empty';
//                       return null;
//                     },
//                     maxLines: 35,
//                     controller: textController,
//                     decoration: const InputDecoration(
//                       border: InputBorder.none,
//                       hintText: 'your notes here',
//                     ),
//                     style: const TextStyle(color: Colors.black),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

