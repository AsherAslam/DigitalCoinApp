import 'package:http/http.dart';

class CoinsRepository {
  final Client _client = Client();

  final Map<String, String> _coinsHeaderKey = {
    'X-CoinAPI-Key': 'C0A2F68E-9838-4DAF-8312-81EBB6AD5BAF'
  };

  Future<Response> getAllCoins() async {
    final res = await _client.get(
        Uri.parse('https://rest.coinapi.io/v1/assets/icons/100'),
        headers: {..._coinsHeaderKey});
    return res;
  }
}
