class WinnerPrice {
  WinnerPrice({
    this.rank,
    this.priceMoney,
    this.totalPrice,
  });

  late int? rank;
  late double? priceMoney;
  late double? totalPrice;

  WinnerPrice.fromJson(Map<String, dynamic> json) {
    rank = json['rank'] ?? 0;
    priceMoney = json['priceMoney'] ?? 0.0;
    totalPrice = json['totalPrice'] ?? 0.0;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      'rank': rank,
      'priceMoney': priceMoney,
      'totalPrice': totalPrice,
    };
    return data;
  }
}
