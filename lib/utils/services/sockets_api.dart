

import 'dart:convert';

import 'package:currency_app/constants/coinapi_key.dart';
import 'package:currency_app/modules/home/controllers/home_controller.dart';
import 'package:currency_app/modules/home/models/currency.dart';
import 'package:get/get.dart';
import 'package:web_socket_channel/io.dart';


class WebSockets {
  static IOWebSocketChannel? _chanel;

  static void init(String? currencyAssetId) {
    if(currencyAssetId !=null) {
      _listenUpdates(currencyAssetId);
    }
  }

  static Future kill() async{
      await _chanel?.sink.close();
  }

  static Future<void> _listenUpdates(String currencyAssetId) async
  {
    HomeController controller = Get.find<HomeController>();
    _chanel = _connectWS(currencyAssetId);
    _chanel?.stream.listen((event) {
      final eventData = json.decode(event);
      if(eventData.containsKey('type') && eventData['type'] == 'hearbeat')
      {
        controller.update();
      }
      else{
      controller.currentCurrency = 
      Currency.fromJson(eventData);
      }

    });
  }

  static IOWebSocketChannel _connectWS(String currencyAssetId) {
    const _url = 'wss://ws-sandbox.coinapi.io/v1/';
    final IOWebSocketChannel _chanel = IOWebSocketChannel.connect(_url);
    _chanel.sink.add(
      json.encode({
  "type": "hello",
  "apikey": coinapiKey,
  "heartbeat": true,
  "subscribe_data_type": ["quote"],
  "subscribe_filter_asset_id": [currencyAssetId],
  "subscribe_update_limit_ms_quote": 2500
})
      );
      return _chanel;
  }
}