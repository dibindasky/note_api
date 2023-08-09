// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

import '../controller/api_calls.dart';
import '../model/to_do_model/item.dart';

ValueNotifier<bool> isDeleting = ValueNotifier(false);

class ScreenEditAdd extends StatelessWidget {
  ScreenEditAdd({super.key, this.note});

  final Item? note;
  final TextEditingController textController = TextEditingController();
  final TextEditingController titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (note != null) {
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
            width: size.width* 0.20,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.white),
              child: ValueListenableBuilder(
                valueListenable: isDeleting,
                builder: (context, value, child) {
                  return isDeleting.value
                      ? const Center(child: CircularProgressIndicator())
                      : IconButton(
                          onPressed: () async {
                            isDeleting.value = true;
                            await deleteNote(note!.id!);
                            isDeleting.value=false;
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.delete),
                        );
                },
              )),
          const SizedBox(
            width: 20,
          ),
          Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.white),
              child: TextButton.icon(
                onPressed: () {},
                icon: const Icon(
                  Icons.check,
                  color: Colors.black,
                ),
                label: const Text(
                  'Save',
                  style: TextStyle(color: Colors.black),
                ),
              )),
          const SizedBox(
            width: 20,
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              TextField(
                textAlign: TextAlign.center,
                controller: titleController,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Title',
                    suffixIcon: Icon(Icons.edit_outlined)),
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                child: TextField(
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
    );
  }
}
