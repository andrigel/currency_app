class CurrencyAsset {
  final String assetId;
  final String name;

  CurrencyAsset.fromJson(Map json):
  assetId = json['asset_id'],
  name = json['name'];
}