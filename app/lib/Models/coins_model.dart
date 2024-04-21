class CoinModel {
  String? name;
  String? image;

  CoinModel({this.name, this.image});

  CoinModel.fromJson(Map<String, dynamic> json) {
    name = json['asset_id'];
    image = json['url'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['asset_id'] = name;
    data['url'] = image;

    return data;
  }
}
