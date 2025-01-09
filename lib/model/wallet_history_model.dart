// To parse this JSON data, do
//
//     final walletHistoryModel = walletHistoryModelFromJson(jsonString);

import 'dart:convert';

WalletHistoryModel walletHistoryModelFromJson(String str) =>
    WalletHistoryModel.fromJson(json.decode(str));

String walletHistoryModelToJson(WalletHistoryModel data) =>
    json.encode(data.toJson());

class WalletHistoryModel {
  WalletHistoryModel({
    required this.history,
  });

  List<History> history;

  factory WalletHistoryModel.fromJson(Map<String, dynamic> json) =>
      WalletHistoryModel(
        history:
            List<History>.from(json["history"].map((x) => History.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "history": List<dynamic>.from(history.map((x) => x.toJson())),
      };
}

class History {
  History({
    this.id,
    this.buyerId,
    this.paymentGateway,
    this.paymentStatus,
    this.amount,
  });

  int? id;
  int? buyerId;
  String? paymentGateway;
  String? paymentStatus;
  int? amount;

  factory History.fromJson(Map<String, dynamic> json) => History(
        id: json["id"],
        buyerId: json["buyer_id"],
        paymentGateway: json["payment_gateway"],
        paymentStatus: json["payment_status"],
        amount: json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "buyer_id": buyerId,
        "payment_gateway": paymentGateway,
        "payment_status": paymentStatus,
        "amount": amount,
      };
}
