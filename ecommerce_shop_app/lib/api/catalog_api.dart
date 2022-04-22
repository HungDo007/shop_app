import '../api/http_client.dart';

class CatalogApi {
  Future<void> getAllDirectory() async {
    final httpClient = HttpClient();
    final url = Uri.parse(
        "https://shop-app-58d69-default-rtdb.asia-southeast1.firebasedatabase.app/products.json");
    await httpClient.get(url);
  }
}
