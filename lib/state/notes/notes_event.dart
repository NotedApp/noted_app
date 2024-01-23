import 'package:noted_app/state/noted_bloc.dart';
import 'package:noted_app/util/errors/noted_exception.dart';
import 'package:noted_models/noted_models.dart';

sealed class NotesEvent extends NotedEvent implements TrackableEvent {
  const NotesEvent();
}

class NotesSubscribeEvent extends NotesEvent {
  const NotesSubscribeEvent();
}

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

class NotesToggleSelectionEvent extends NotesEvent {
  final String id;

  const NotesToggleSelectionEvent(this.id);
}

class NotesResetSelectionsEvent extends NotesEvent {
  const NotesResetSelectionsEvent();
}

class NotesDeleteSelectionsEvent extends NotesEvent {
  const NotesDeleteSelectionsEvent();
}

class NotesResetEvent extends NotesEvent {
  const NotesResetEvent();
}
