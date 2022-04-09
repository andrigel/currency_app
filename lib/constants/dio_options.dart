import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'coinapi_key.dart';

final BaseOptions dioOptions = BaseOptions(
      baseUrl: 'https://rest-sandbox.coinapi.io/',
      headers: {'X-CoinAPI-Key':coinapiKey},
      validateStatus: (int? status) {
        if(status == 200) {
          return true;
        } else {
          if (kDebugMode) {
            print('Wrong status code: ' + status.toString());
          }
        }
        return false;
      }
      );