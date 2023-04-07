//import 'package:encrypt/encrypt.dart ' as encrypt;

import 'package:encrypt/encrypt.dart';
//import 'package:flutter/cupertino.dart';

class MyEncryption {
  // static final key = encrypt.Key.fromLength(32);
  // static final iv = encrypt.IV.fromLength(16);
  // static final encrypter = encrypt.Encrypter(encrypt.AES(key));
  // static encryptAES(Text) {
  //   final encrypted = encrypter.encrypt(Text, iv: iv);
  //   //print(encrypted.bytes);

  //   print(encrypted.base64);

  //   // print(encrypted);

  //   return encrypted;
  // }

  static final key = Key.fromUtf8('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdef');
  static final iv = IV.fromUtf8("5684878965471256");
  // static final iv = IV.fromLength(16);
  // static final key = Key.fromLength(32);

  static anotherencryption(Textt) {
    final plainText = Textt;
    if (Textt == "" || Textt == " ") {
      print("null");
    } else {
      //final encrypter = Encrypter(AES(key));
      //final encrypted = encrypter.encrypt(plainText, iv: iv);
      final encrypter =
          Encrypter(AES(key, mode: AESMode.cbc, padding: 'PKCS7'));
      final encrypted = encrypter.encrypt(plainText, iv: iv);

      final decrypted = encrypter.decrypt(encrypted, iv: iv);

      return encrypted.base64;
    }
  }

  static CryptoGraphy(type, Text) {
    final encrypter = Encrypter(AES(key, mode: AESMode.cbc, padding: 'PKCS7'));
    if (type == "Encryption") {
      final encrypted = encrypter.encrypt(Text, iv: iv);
      return encrypted.base64;
    } else if (type == "Decryption") {
      final decrypted = encrypter.decrypt64(Text, iv: iv);
      return decrypted;
    }
  }
}
