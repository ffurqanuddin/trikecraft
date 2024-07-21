


import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:intl/intl.dart';

String generateOrderId(String email) {
  final emailPart = email.substring(0, 5);
  final timestamp = DateFormat('yyyyMMddHHmmssSSS').format(DateTime.now());
  final combinedString = '$emailPart$timestamp';

  final bytes = utf8.encode(combinedString);
  final digest = sha256.convert(bytes);

  // Return first 16 characters of the hash
  return digest.toString().substring(0, 16).toUpperCase();
}