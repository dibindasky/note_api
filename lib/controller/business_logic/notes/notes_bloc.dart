import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_api/controller/api/api_calls.dart';

import '../../../model/to_do_model/item.dart';

part 'notes_event.dart';
part 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  NotesBloc() : super(NotesInitial()) {
    ApiCalls api = ApiCalls();

    on<ReCallApiEvent>((event, emit) async {
      List<Item> notes = await api.getAllNotes();
      return emit(NotesState(notesList: notes));
    });

    on<AddNoteEvent>((event, emit) async {
      await api.addNote(note: event.model);
      List<Item> notes = await api.getAllNotes();
      return emit(NotesState(notesList: notes));
    });

    on<UpdateNoteEvent>((event, emit) async {
      await api.updateNote(note: event.model);
      List<Item> notes = await api.getAllNotes();
      return emit(NotesState(notesList: notes));
    });

    on<DeleteNoteEVent>((event, emit) async {
      await api.deleteNote(event.id);
      List<Item> notes = await api.getAllNotes();
      return emit(NotesState(notesList: notes));
    });
  }
}
