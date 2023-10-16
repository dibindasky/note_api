part of 'notes_bloc.dart';

class NotesState {
  List<Item> notesList;
  bool isLoading;
  bool isSaving;
  bool isDeleting;
  NotesState(
      {required this.notesList,
      this.isLoading = false,
      this.isDeleting = false,
      this.isSaving = false});
}

class NotesInitial extends NotesState {
  NotesInitial() : super(notesList: <Item>[]);
}
