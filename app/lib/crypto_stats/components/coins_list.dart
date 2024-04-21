import 'package:cached_network_image/cached_network_image.dart';
import 'package:crypto_stats/controllers/coins_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';

class CoinsList extends ConsumerStatefulWidget {
  const CoinsList({super.key});

  @override
  _CoinsListState createState() => _CoinsListState();
}

class _CoinsListState extends ConsumerState<CoinsList> {
  final CoinsController _coinsController = CoinsController();
  int displayedItems = 30;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _coinsController.getCoins(ref);
  }

  Widget _buildShimmerContainer() {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: MediaQuery.sizeOf(context).height * 0.035,
          horizontal: MediaQuery.sizeOf(context).width * 0.03),
      margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.sizeOf(context).width * 0.03, vertical: 5),
      width: MediaQuery.sizeOf(context).width * 0.6,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    final coins = ref.watch(getAllCoinsProvider);

    return coins.isEmpty
        ? Container(
            margin: EdgeInsets.symmetric(horizontal: screenSize.width * 0.05),
            width: screenSize.width,
            height: screenSize.height * 0.5,
            child: ListView.separated(
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: _buildShimmerContainer(),
                    ),
                  );
                },
                separatorBuilder: (context, index) => SizedBox(
                      height: screenSize.height * 0.02,
                    ),
                itemCount: 10))
        : NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              if (!isLoading &&
                  scrollInfo.metrics.pixels ==
                      scrollInfo.metrics.maxScrollExtent) {
                _loadMoreItems();
                return true;
              }
              return false;
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: screenSize.width * 0.05),
              width: screenSize.width,
              height: screenSize.height * 0.5,
              child: ListView.builder(
                itemCount: displayedItems < coins.length
                    ? displayedItems + 1
                    : displayedItems,
                itemBuilder: (context, index) {
                  if (index == displayedItems) {
                    return _buildLoader();
                  }
                  final coin = coins[index];
                  return Container(
                    padding: EdgeInsets.symmetric(
                        vertical: 8, horizontal: screenSize.width * 0.03),
                    margin: EdgeInsets.symmetric(
                        horizontal: screenSize.width * 0.03, vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          child: CachedNetworkImage(
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                            imageUrl: coin.image ??
                                'https://s3.eu-central-1.amazonaws.com/bbxt-static-icons/type-id/png_512/4caf2b16a0174e26a3482cea69c34cba.png',
                          ),
                        ),
                        const Spacer(),
                        Text(
                          coin.name ?? '--',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        const Spacer(),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
  }

  Widget _buildLoader() {
    return Container(
      padding: EdgeInsets.all(16),
      alignment: Alignment.center,
      child: CircularProgressIndicator(),
    );
  }

  void _loadMoreItems() {
    setState(() {
      isLoading = true;
    });

    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        displayedItems += 30;
        isLoading = false;
      });
    });
  }
}
