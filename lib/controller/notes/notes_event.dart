part of 'notes_bloc.dart';

class NotesEvent {}

class ReCallApiEvent extends NotesEvent {}

class AddNoteEvent extends NotesEvent {
  Item model;
  AddNoteEvent({required this.model});
}

class UpdateNoteEvent extends NotesEvent {
  Item model;
  UpdateNoteEvent({required this.model});
}

class DeleteNoteEVent extends NotesEvent {
  String id;
  DeleteNoteEVent({required this.id});
}
