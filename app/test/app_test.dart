import 'dart:convert';

import 'package:crypto_stats/Models/coins_model.dart';
import 'package:crypto_stats/controllers/coins_controller.dart';
import 'package:crypto_stats/crypto_stats/components/wellcome_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';

class MockCoinsRepository {
  Future<Response> getAllCoins() async {
    return Response(
      json.encode([
        {'name': 'Bitcoin', 'image': 'bitcoin.png'},
        {'name': 'Ethereum', 'image': 'ethereum.png'},
        {'name': 'Cardano', 'image': 'cardano.png'}
      ]),
      200,
    );
  }
}

class MockCoinsController {
  MockCoinsRepository _mockCoinsRepository = MockCoinsRepository();
  Future<List<CoinModel>> getCoins() async {
    try {
      final res = await _mockCoinsRepository.getAllCoins();
      final decodeResult = jsonDecode(res.body);
      final coins = (decodeResult as List)
          .map((data) => CoinModel(name: data['name'], image: data['image']))
          .toList();
      return coins;
    } catch (e) {
      // print(e);
      return [];
    }
  }
}

void main() {
  //*****************************  Widget Test *************************************//

  // Wellcome Header Wiget Test
  testWidgets('WellcomeHeader widget test', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: WellcomeHeader(username: 'TestUser'),
      ),
    ));

    // checking both text widgets are displayed with the correct username.
    expect(find.text('Wellcome'), findsOneWidget);
    expect(find.text('TestUser'), findsOneWidget);

    // checking that the CircleAvatar widget is displayed.
    expect(find.byType(CircleAvatar), findsOneWidget);

    // checking first letter of the username is displayed in the CircleAvatar.
    expect(find.text('T'), findsOneWidget);
  });

  //************************************* Unit Test for state Provider ***********************************//

  group('CoinsController', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    test('getAllCoinsProvider updates state with fetched coins', () async {
      final controller = MockCoinsController();

      container.read(getAllCoinsProvider.notifier).state =
          await controller.getCoins();

      // Expect the state of getAllCoinsProvider to be updated with fetched coins
      expect(container.read(getAllCoinsProvider.notifier).state.length, 3);
      expect(container.read(getAllCoinsProvider.notifier).state[0].name,
          'Bitcoin');
      expect(container.read(getAllCoinsProvider.notifier).state[1].name,
          'Ethereum');
      expect(container.read(getAllCoinsProvider.notifier).state[2].name,
          'Cardano');
    });
  });
}
