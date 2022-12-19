import 'dart:convert';
import 'package:encrypt/encrypt.dart';

final key = Key.fromBase64('e9eZOkCXxpJGQhzOCbgAs2zil/uPhwGQc4U+5gOBIL0=');
final iv = IV.fromBase64('iKD1vVYLq760rnZ1RqFXfg==');

class DataEncrypt {
  final encrypter = Encrypter(AES(key, mode: AESMode.cbc, padding: "PKCS7"));

  String encrypt(Map data) {
    String plainText = json.encode(data);
    final encrypted = encrypter.encrypt(plainText, iv: iv);
    return encrypted.base64;
  }

  String decrypt(String data) {
    final decrypted = encrypter.decrypt(Encrypted.fromBase64(data), iv: iv);
    return decrypted;
  }
}
