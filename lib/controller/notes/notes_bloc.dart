import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/to_do_model/item.dart';
import '../../services/api/api_calls.dart';

part 'notes_event.dart';
part 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  NotesBloc() : super(NotesInitial()) {
    ApiCalls api = ApiCalls();

    on<ReCallApiEvent>((event, emit) async {
      emit(NotesState(notesList: <Item>[],isLoading: true));
      List<Item> notes = await api.getAllNotes();
      return emit(NotesState(notesList: notes,isLoading: false));
    });

    on<AddNoteEvent>((event, emit) async {
      emit(NotesState(notesList: <Item>[],isLoading: true,isSaving: true));
      await api.addNote(note: event.model);
      List<Item> notes = await api.getAllNotes();
      return emit(NotesState(notesList: notes,isLoading: false,isSaving: false));
    });

    on<UpdateNoteEvent>((event, emit) async {
      emit(NotesState(notesList: <Item>[],isLoading: true,isSaving: true));
      await api.updateNote(note: event.model);
      List<Item> notes = await api.getAllNotes();
      return emit(NotesState(notesList: notes,isLoading: false,isSaving: false));
    });

    on<DeleteNoteEVent>((event, emit) async {
      emit(NotesState(notesList: <Item>[],isDeleting: true));
      await api.deleteNote(event.id);
      List<Item> notes = await api.getAllNotes();
      return emit(NotesState(notesList: notes,isDeleting: false));
    });
  }
}
