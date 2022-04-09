import 'package:currency_app/modules/home/api/home_api.dart';
import 'package:currency_app/modules/home/models/currency.dart';
import 'package:currency_app/modules/home/models/currencyAsset.dart';
import 'package:currency_app/modules/home/models/historical_data.dart';
import 'package:currency_app/utils/services/sockets_api.dart';
import 'package:get/get.dart';

class HomeController extends GetxController
{
  final repository = HomeApi();
  bool isLoaded = false;
  List<CurrencyAsset> currency = [];
  List<HistoricalData> historicalData = [];

  
  String? get symboolText => _dropdownValue == null ? null : _dropdownValue! + '/USD';

  String? _dropdownValue;
  String? get dropdownValue => _dropdownValue;


  setDropdownValue(String? newValue) async {
    await WebSockets.kill();
    historicalData = await repository.getHistoricalData(symboolId: newValue!);
    _dropdownValue = newValue;
    WebSockets.init(symboolText);
    update();
  }
  Currency? _currentCurrency;
  ///Value that we can see at the market data
  Currency? get currentCurrency => _currentCurrency;
  set currentCurrency(Currency? value)
  {
    _currentCurrency = value;
  }


  @override
  void onInit() async {
    currency = await repository.getCurrencyAssets();
    await setDropdownValue(currency[0].assetId);
    isLoaded = true;
    super.onInit();
  }
}