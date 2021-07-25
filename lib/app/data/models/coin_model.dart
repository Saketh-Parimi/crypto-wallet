class Coin {
  String? id;
  String? amount;

  Coin({required this.id, required this.amount});

  Coin.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['amount'] = amount;
    return data;
  }
}
