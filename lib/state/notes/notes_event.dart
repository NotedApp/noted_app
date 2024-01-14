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

class NotesDeleteEvent extends NotesEvent {
  final List<String> noteIds;

  const NotesDeleteEvent(this.noteIds);
}

class NotesResetEvent extends NotesEvent {}
