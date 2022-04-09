class Currency
{
  final DateTime? dateTime;
  final num price;
  Currency.fromJson(Map json) :
  dateTime = DateTime.tryParse(json['time_coinapi'])?.toLocal(),
  price = json['ask_price'];
}