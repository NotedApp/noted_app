import 'package:noted_app/state/noted_bloc.dart';
import 'package:noted_app/util/errors/noted_exception.dart';
import 'package:noted_models/noted_models.dart';

sealed class EditEvent extends NotedEvent implements TrackableEvent {
  const EditEvent();
}

class EditLoadEvent extends EditEvent {
  final String id;

  const EditLoadEvent(this.id);
}

class EditAddEvent extends EditEvent {
  final NoteModel note;

  const EditAddEvent(this.note);
}

class EditUpdateEvent extends EditEvent {
  final NoteModel note;

  const EditUpdateEvent(this.note);
}

class EditDeleteEvent extends EditEvent {}

class EditRemoteUpdateEvent extends EditEvent {
  final NoteModel note;

  const EditRemoteUpdateEvent(this.note);
}

class EditRemoteUpdateErrorEvent extends EditEvent {
  final NotedError error;

  const EditRemoteUpdateErrorEvent(this.error);
}

class EditCloseEvent extends EditEvent {}
