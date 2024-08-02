import 'package:cloud_firestore/cloud_firestore.dart';

class P2PPaymentModel {
  String transactionId;
  String senderName;
  String contactInfo;
  String paymentMethod;
  String accountName;
  String amount;
  DateTime transactionDate;
  String transactionStatus;

  P2PPaymentModel({
    required this.transactionId,
    required this.senderName,
    required this.contactInfo,
    required this.paymentMethod,
    required this.accountName,
    required this.amount,
    required this.transactionDate,
    required this.transactionStatus,
  });

  factory P2PPaymentModel.fromFirestore(Map<String, dynamic> doc) {
    return P2PPaymentModel(
      transactionId: doc['transactionId'] as String,
      senderName: doc['senderName'] as String,
      contactInfo: doc['contactInfo'] as String,
      paymentMethod: doc['paymentMethod'] as String,
      accountName: doc['accountName'] as String,
      amount: doc['amount'] as String,
      transactionDate: (doc['transactionDate'] as Timestamp).toDate(),
      transactionStatus: doc['transactionStatus'] as String,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'transactionId': transactionId,
      'senderName': senderName,
      'contactInfo': contactInfo,
      'paymentMethod': paymentMethod,
      'accountName': accountName,
      'amount': amount,
      'transactionDate': transactionDate,
      'transactionStatus': transactionStatus,
    };
  }
}
