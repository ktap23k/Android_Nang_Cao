// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:convert';

import 'package:encrypt/encrypt.dart';
import 'package:linkedin_clone/dataEncrypt.dart';

void main() {
  // final plainText = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit';
  var data = {'key': "trần anh tuấn"};
  String plainText = json.encode(data);

  final key = Key.fromBase64('e9eZOkCXxpJGQhzOCbgAs2zil/uPhwGQc4U+5gOBIL0=');
  final iv = IV.fromBase64('iKD1vVYLq760rnZ1RqFXfg==');

  final encrypter = Encrypter(AES(key, mode: AESMode.cbc, padding: "PKCS7"));

  final encrypted = encrypter.encrypt(plainText, iv: iv);
  print(encrypted.base64);

  var enc = "lyR6doHWxoRfO9MbRIxw1SrOEpPuoM+BGIcJvWPGtpg=";

  final decrypted = encrypter.decrypt(Encrypted.fromBase64(enc), iv: iv);
  print(decrypted); // Lorem ipsum dolor sit amet, consectetur adipiscing elit

  var encrypt = DataEncrypt();
  print(encrypt.encrypt(plainText));

  print(encrypt.decrypt(enc));
  Map valueMap = json.decode(encrypt.decrypt(enc));
  print(valueMap);

  // var dict = json.decode(decrypted);
  // print(dict);
}
