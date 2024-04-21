import 'dart:convert';

import 'package:crypto_stats/controllers/coins_controller.dart';
import 'package:crypto_stats/generated/assets.gen.dart';
import 'package:crypto_stats/providers/socket_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';

class LiveCoinsPrice extends ConsumerStatefulWidget {
  const LiveCoinsPrice({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LiveCoinsPriceState();
}

class _LiveCoinsPriceState extends ConsumerState<LiveCoinsPrice> {
  Widget _buildShimmerContainer() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          3,
          (index) => Container(
            height: MediaQuery.sizeOf(context).height * 0.22,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            margin: EdgeInsets.symmetric(
                horizontal: MediaQuery.sizeOf(context).width * 0.025,
                vertical: 5),
            width: MediaQuery.sizeOf(context).width * 0.6,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
        ),
      ),
    );
  }

  final CoinsController _coinsController = CoinsController();
  String getStringy(dynamic value) {
    return value != null ? value.toString() : '...';
  }

  @override
  Widget build(BuildContext context) {
    final webSocketvalue = ref.watch(webSocketProvider);
    final btcValue = ref.watch(btcDataProvider);
    final etcvalue = ref.watch(etcDataProvider);
    final adavalue = ref.watch(adaDataProvider);
    return webSocketvalue.when(
      data: (socket) {
        return StreamBuilder(
          stream: socket.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var data = jsonDecode(snapshot.data);
              Future.delayed(Duration.zero, () {
                _coinsController.setLiveCoins(ref, data);
              });

              return Container(
                  width: MediaQuery.sizeOf(context).width,
                  height: MediaQuery.sizeOf(context).height * 0.22,
                  margin: const EdgeInsets.only(left: 25),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      CoinDetail(
                        image: AssetImage(Assets.images.btc.assetName),
                        text: 'BTC',
                        price: getStringy(btcValue['price']),
                        action: getStringy(btcValue['taker_side']),
                      ),
                      CoinDetail(
                        image: AssetImage(Assets.images.eth.assetName),
                        text: "ETH",
                        price: getStringy(etcvalue['price']),
                        action: getStringy(etcvalue['taker_side']),
                      ),
                      CoinDetail(
                        image: AssetImage(Assets.images.ada.assetName),
                        text: "ADA",
                        price: getStringy(adavalue['price']),
                        action: getStringy(adavalue['taker_side']),
                      )
                    ],
                  ));
            } else if (snapshot.hasError) {
              // Handle error
              return Text('Error: ${snapshot.error}');
            } else {
              // Loading state
              return Padding(
                padding: EdgeInsets.all(8.0),
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: _buildShimmerContainer(),
                ),
              );
            }
          },
        );
      },
      loading: () => const CircularProgressIndicator(),
      error: (error, stackTrace) => Text('Error: $error'),
    );
  }
}

class CoinDetail extends StatelessWidget {
  final String text;
  final ImageProvider<Object> image;
  final String price;
  final String action;

  const CoinDetail(
      {Key? key,
      required this.image,
      required this.text,
      required this.price,
      required this.action})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.sizeOf(context).width * 0.025, vertical: 5),
      width: MediaQuery.sizeOf(context).width * 0.6,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 2),
              blurRadius: 1,
              spreadRadius: 1,
              color: Colors.grey.withOpacity(.7),
            ),
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SizedBox(
                  height: 50,
                  width: 50,
                  child: Image(image: image, fit: BoxFit.cover)),
              SizedBox(
                width: 20,
              ),
              Text(
                text,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text("/USD",
                  style: TextStyle(
                    fontSize: 20,
                  ))
            ],
          ),
          Text(
            price,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Text(action),
        ],
      ),
    );
  }
}
