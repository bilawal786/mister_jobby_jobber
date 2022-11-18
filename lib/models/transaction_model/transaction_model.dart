// To parse this JSON data, do
//
//     final transactionModel = transactionModelFromJson(jsonString);

import 'dart:convert';

TransactionModel transactionModelFromJson(String str) => TransactionModel.fromJson(json.decode(str));

String transactionModelToJson(TransactionModel data) => json.encode(data.toJson());

class TransactionModel {
  TransactionModel({
    required this.wallet,
    required this.transactions,
  });

  String wallet;
  List<Transaction> transactions;

  factory TransactionModel.fromJson(Map<String, dynamic> json) => TransactionModel(
    wallet: json["wallet"],
    transactions: List<Transaction>.from(json["transactions"].map((x) => Transaction.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "wallet": wallet,
    "transactions": List<dynamic>.from(transactions.map((x) => x.toJson())),
  };
}

class Transaction {
  Transaction({
    required this.transactionId,
    required this.invoiceNo,
    required this.price,
    required this.proposalPrice,
    required this.percentage,
    required this.jobberGet,
    required this.type,
    required this.jobTitle,
  });

  int transactionId;
  String invoiceNo;
  String price;
  String proposalPrice;
  String percentage;
  String jobberGet;
  String type;
  String jobTitle;

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
    transactionId: json["transaction_id"],
    invoiceNo: json["invoice_no"],
    price: json["price"],
    proposalPrice: json["proposal_price"],
    percentage: json["percentage"],
    jobberGet: json["jobber_get"],
    type: json["type"],
    jobTitle: json["job_title"],
  );

  Map<String, dynamic> toJson() => {
    "transaction_id": transactionId,
    "invoice_no": invoiceNo,
    "price": price,
    "proposal_price": proposalPrice,
    "percentage": percentage,
    "jobber_get": jobberGet,
    "type": type,
    "job_title": jobTitle,
  };
}
