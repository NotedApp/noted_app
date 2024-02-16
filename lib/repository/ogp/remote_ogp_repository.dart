import 'package:noted_app/repository/ogp/ogp_repository.dart';
import 'package:ogp_data_extract/ogp_data_extract.dart';

// coverage:ignore-file
class RemoteOgpRepository extends OgpRepository {
  @override
  Future<String> fetchImage(String url) async {
    try {
      final OgpData? ogpData = await OgpDataExtract.execute(url);
      return ogpData?.image ?? '';
    } catch (_) {
      return '';
    }
  }
}
