/// A repository that handles OGP data.
abstract class OgpRepository {
  /// Returns the image URL associated with the given URL, or an empty string if there is no associated image URL.
  Future<String> fetchImage(String url);
}
