import 'package:noted_app/state/noted_bloc.dart';
import 'package:noted_app/util/errors/noted_exception.dart';
import 'package:noted_models/noted_models.dart';

sealed class NotesEvent extends NotedEvent implements TrackableEvent {
  const NotesEvent();
}

class NotesSubscribeEvent extends NotesEvent {}

class NotesUpdateEvent extends NotesEvent {
  final List<NoteModel> notes;

  const NotesUpdateEvent(this.notes);
}

class NotesUpdateErrorEvent extends NotesEvent {
  final NotedError error;

  const NotesUpdateErrorEvent(this.error);
}

class NotesAddEvent extends NotesEvent {
  final NoteModel note;

  const NotesAddEvent(this.note);
}

class NotesUpdateNoteEvent extends NotesEvent {
  final NoteModel note;

  const NotesUpdateNoteEvent(this.note);
}

class NotesDeleteEvent extends NotesEvent {
  final String noteId;

  const NotesDeleteEvent(this.noteId);
}

class NotesResetEvent extends NotesEvent {}
