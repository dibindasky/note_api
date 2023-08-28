part of 'notes_bloc.dart';

class NotesState {
  List<Item> notesList;
  NotesState({required this.notesList});
}

final class NotesInitial extends NotesState {
  NotesInitial() : super(notesList: <Item>[]);
}
