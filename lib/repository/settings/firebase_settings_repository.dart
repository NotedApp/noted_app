import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:noted_app/repository/settings/settings_repository.dart';
import 'package:noted_app/util/noted_exception.dart';
import 'package:noted_models/noted_models.dart';

// TODO: Test this file.
// coverage:ignore-file
class FirebaseSettingsRepository extends SettingsRepository {
  final FirebaseFirestore _firestore;

  CollectionReference get _settings => _firestore.collection('settings');

  FirebaseSettingsRepository({
    FirebaseFirestore? firestore,
  }) : _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Future<NotedSettings> fetchSettings({required String userId}) async {
    try {
      final DocumentSnapshot snapshot = await _settings.doc(userId).get();

      if (snapshot.exists) {
        final Object? data = snapshot.data();
        final Map<String, dynamic>? map = data == null ? null : data as Map<String, dynamic>;
        return map == null ? NotedSettings() : NotedSettings.fromMap(map);
      } else {
        final NotedSettings settings = NotedSettings();
        await _settings.doc(userId).set(settings);
        return settings;
      }
    } on FirebaseException catch (e) {
      throw NotedException(ErrorCode.settings_fetch_failed, message: e.code);
    } catch (_) {
      throw NotedException(ErrorCode.settings_fetch_failed);
    }
  }

  @override
  Future<void> updateStyleSettings({required String userId, required NotedStyleSettings style}) async {
    try {
      final Map<String, dynamic> data = {'style': style.toMap()};
      await _settings.doc(userId).set(data, SetOptions(merge: true));
    } on FirebaseException catch (e) {
      throw NotedException(ErrorCode.settings_updateStyle_failed, message: e.code);
    } catch (_) {
      throw NotedException(ErrorCode.settings_updateStyle_failed);
    }
  }
}
