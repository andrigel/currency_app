import 'package:currency_app/modules/home/models/currencyAsset.dart';
import 'package:currency_app/modules/home/models/historical_data.dart';
import 'package:currency_app/utils/services/api.dart';

class HomeApi extends Client {

   Future<List<CurrencyAsset>> getCurrencyAssets() async
  {
    const url = 'v1/assets';
    try {
    var responce = await dio.get(url,
    queryParameters: {
      'filter_asset_id': 'ETH,BTC,DOGE,SHIB'
    });
    return responce.data.map<CurrencyAsset>((currency) => CurrencyAsset.fromJson(currency)).toList();
    } catch (e){
      return []; 
    }
  }
    Future<CurrencyAsset?> getCurrency(String assetId) async
  {
    final url = 'v1/assets/' + assetId;
    try {
    var responce = await dio.get(url);
    return CurrencyAsset.fromJson(responce.data);
    } catch (e){
      return null; 
    }
  }
  Future<List<HistoricalData>> getHistoricalData(
    {required String symboolId}) async
  {
    final url = 'v1/ohlcv/COINBASE_SPOT_${symboolId}_USD/latest';
    try{
    var response = await dio.get(url,
    queryParameters: {
      'period_id': '1MTH'
    });
    return response.data.map<HistoricalData>((hsData)=> HistoricalData.fromJson(hsData)).toList();
    }catch(e){
      return[];
    }
  }
}