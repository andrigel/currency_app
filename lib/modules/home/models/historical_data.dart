class HistoricalData {
  DateTime? periodEnd;
  num? price;
  bool get hasData => periodEnd!=null&&price != null;
  HistoricalData.fromJson(Map json):
  periodEnd = DateTime.tryParse(json['time_period_end']),
  price = json['price_high'];
}
