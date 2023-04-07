import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import '../globals.dart';
import 'package:secure_apk/reuseablewidgets.dart/sessionexpire.dart';

class MyHttpClient {
  final BuildContext context;
  MyHttpClient(this.context);
  late sessionExpired sessionexpired = new sessionExpired(context);
  Future<Response?> PostMethod(String ApiendPoint, Map Payload,
      String MobileUrl, bool _IncludeHeaders) async {
    final headers;
    if (!_IncludeHeaders) {
      headers = null;
    } else {
      headers = {
        "MobileURL": MobileUrl,
        "CPF_NO": globalInt.toString(),
        "Authorization": "Bearer $JWT_Tokken"
      };
    }

    http.Response response =
        await post(Uri.parse(ApiendPoint), body: Payload, headers: headers);
    if (response.statusCode == 401) {
      var isunauth = response.reasonPhrase;
      if (isunauth == "Unauthorized") {
        sessionexpired.LogoutUser();

        return null;
      }
    }
    return response;
  }

  Future<Response?> GetMethod(
      String ApiendPoint, String MobileUrl, bool _IncludeHeaders) async {
    final headers;
    if (!_IncludeHeaders) {
      headers = null;
    } else {
      headers = {
        "MobileURL": MobileUrl,
        "CPF_NO": globalInt.toString(),
        "Authorization": "Bearer $JWT_Tokken"
      };
    }
    http.Response response =
        await get(Uri.parse(ApiendPoint), headers: headers);
    if (response.statusCode == 401) {
      var isunauth = response.reasonPhrase;
      if (isunauth == "Unauthorized") {
        sessionexpired.LogoutUser();

        return null;
      }
    }
    return response;
  }
}
