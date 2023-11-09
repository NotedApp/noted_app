import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:noted_app/repository/settings/settings_repository.dart';
import 'package:noted_app/util/errors/noted_exception.dart';
import 'package:noted_models/noted_models.dart';

// TODO: Test this file.
// coverage:ignore-file
class FirebaseSettingsRepository extends SettingsRepository {
  final FirebaseFirestore _firestore;

  DocumentReference _settings(String userId) => _firestore.collection('settings').doc(userId);

  FirebaseSettingsRepository({
    FirebaseFirestore? firestore,
  }) : _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Future<SettingsModel> fetchSettings({required String userId}) async {
    try {
      final DocumentSnapshot snapshot = await _settings(userId).get();

      if (snapshot.exists) {
        final Object? data = snapshot.data();
        final Map<String, dynamic>? map = data == null ? null : data as Map<String, dynamic>;
        return map == null ? SettingsModel() : SettingsModel.fromMap(map);
      } else {
        final SettingsModel settings = SettingsModel();
        await _settings(userId).set(settings);
        return settings;
      }
    } on FirebaseException catch (e) {
      throw NotedError(ErrorCode.settings_fetch_failed, message: e.code);
    } catch (_) {
      throw NotedError(ErrorCode.settings_fetch_failed);
    }
  }

  @override
  Future<void> updateStyleSettings({required String userId, required StyleSettingsModel style}) async {
    try {
      final Map<String, dynamic> data = {'style': style.toMap()};
      await _settings(userId).set(data, SetOptions(merge: true));
    } on FirebaseException catch (e) {
      throw NotedError(ErrorCode.settings_updateStyle_failed, message: e.code);
    } catch (_) {
      throw NotedError(ErrorCode.settings_updateStyle_failed);
    }
  }

  @override
  Future<void> updateTagSettings({required String userId, required TagSettingsModel tags}) async {
    try {
      final Map<String, dynamic> data = {'tags': tags.toMap()};
      await _settings(userId).set(data, SetOptions(merge: true));
    } on FirebaseException catch (e) {
      throw NotedError(ErrorCode.settings_updateTags_failed, message: e.code);
    } catch (_) {
      throw NotedError(ErrorCode.settings_updateTags_failed);
    }
  }

  @override
  Future<void> updatePluginSettings({required String userId, required PluginSettingsModel plugins}) async {
    try {
      final Map<String, dynamic> data = {'plugins': plugins.toMap()};
      await _settings(userId).set(data, SetOptions(merge: true));
    } on FirebaseException catch (e) {
      throw NotedError(ErrorCode.settings_updatePlugins_failed, message: e.code);
    } catch (_) {
      throw NotedError(ErrorCode.settings_updatePlugins_failed);
    }
  }
}
