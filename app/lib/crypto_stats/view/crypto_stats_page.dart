import 'package:crypto_stats/crypto_stats/components/balance_card.dart';
import 'package:crypto_stats/crypto_stats/components/coins_list.dart';
import 'package:crypto_stats/crypto_stats/components/live_coins.dart';
import 'package:crypto_stats/crypto_stats/components/wellcome_header.dart';
// import 'package:crypto_stats/l10n/l10n.dart';
import 'package:flutter/material.dart';

/// {@template crypto_stats_page}
///  Page that hanldes the user interface for crypto stats feature.
/// {@endtemplate}
class CryptoStatsPage extends StatelessWidget {
  /// {@macro crypto_stats_page}
  const CryptoStatsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final l10n = context.l10n;
    return Scaffold(
      body: SafeArea(
        child: ListView(
          // child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            const WellcomeHeader(username: 'Asher Aslam'),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.04,
            ),
            const BalanceCard(),
            _heading('Live Prices'),
            const LiveCoinsPrice(),
            _heading('Crypto assets'),
            const CoinsList()
          ],
        ),
        // ),
      ),
    );
  }

  Widget _heading(String heading) {
    return Container(
        alignment: Alignment.centerLeft,
        margin: const EdgeInsets.all(10),
        child: Text(heading));
  }
}
