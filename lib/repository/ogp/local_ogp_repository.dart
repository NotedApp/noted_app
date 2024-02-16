import 'package:noted_app/repository/local_repository_config.dart';
import 'package:noted_app/repository/ogp/ogp_repository.dart';

class LocalOgpRepository extends OgpRepository {
  var _imageUrl = '';
  var _msDelay = LocalRepositoryConfig.mockNetworkDelayMs;

  set imageUrl(String value) => _imageUrl = value;
  set msDelay(int value) => _msDelay = value;

  @override
  Future<String> fetchImage(String url) async {
    await Future.delayed(Duration(milliseconds: _msDelay));
    return _imageUrl;
  }

  void reset() {
    imageUrl = '';
    msDelay = LocalRepositoryConfig.mockNetworkDelayMs;
  }
}
