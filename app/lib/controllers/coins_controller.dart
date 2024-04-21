import 'dart:convert';

import 'package:crypto_stats/Models/coins_model.dart';
import 'package:crypto_stats/repository/coins_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';

final getAllCoinsProvider = StateProvider<List<CoinModel>>((ref) => []);

final btcDataProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final etcDataProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final adaDataProvider = StateProvider<Map<String, dynamic>>((ref) => {});

class CoinsController {
  final CoinsRepository _coinsRepository = CoinsRepository();

  void getCoins(WidgetRef ref) async {
    try {
      Response res = await _coinsRepository.getAllCoins();
      if (res.statusCode == 200) {
        var decodeResult = jsonDecode(res.body);
        final coins = (decodeResult as List)
            .map((data) => CoinModel.fromJson(data))
            .where((coin) =>
                coin.image != null &&
                coin.image!.toLowerCase().endsWith('.png'))
            .toList();

        ref.read(getAllCoinsProvider.notifier).state = coins;
      }
    } catch (e) {
      print(e);
    }
  }

  void setLiveCoins(WidgetRef ref, data) {
    if (data["symbol_id"] == "COINBASE_SPOT_BTC_USD") {
      ref.read(btcDataProvider.notifier).state = data;
    } else if (data["symbol_id"] == "COINBASE_SPOT_ETH_USD") {
      ref.read(etcDataProvider.notifier).state = data;
    } else {
      ref.read(adaDataProvider.notifier).state = data;
    }
  }
}

// class LiveCoinData{
// {"time_exchange":"2024-04-21T13:26:34.6972320Z",
// "time_coinapi":"2024-04-21T13:26:34.7538801Z",
// "uuid":"ff768200-6e95-4440-a373-488517d4a78e",
// "price":0.5017,"size":95.52947747,
// "taker_side":"SELL",
// "symbol_id":"COINBASE_SPOT_ADA_USD",
// "sequence":233265,"type":"trade"}
// }