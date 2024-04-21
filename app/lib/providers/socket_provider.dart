import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_socket_channel/io.dart';

final webSocketProvider = FutureProvider.autoDispose<IOWebSocketChannel>((ref) {
  return connectWs();
});

Future<IOWebSocketChannel> connectWs() async {
  final baseURI = Uri.parse('wss://ws.coinapi.io/v1/');
  final _uri = Uri(
    scheme: baseURI.scheme == 'https' ? 'wss' : 'ws',
    host: baseURI.host,
    port: baseURI.port,
    path: baseURI.path,
  );

  final socket = IOWebSocketChannel.connect(_uri.toString());

  socket.sink.add(
    json.encode({
      'type': 'hello',
      'apikey': 'C0A2F68E-9838-4DAF-8312-81EBB6AD5BAF',
      'heartbeat': false,
      'subscribe_data_type': ['trade'],
      'subscribe_filter_symbol_id': [
        r'COINBASE_SPOT_BTC_USD$',
        r'COINBASE_SPOT_ETH_USD$',
        r'COINBASE_SPOT_ADA_USD$'
      ]
    }),
  );

  return socket;
}
