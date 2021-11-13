import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'remote_exception.dart';

final _indent = ' ' * 11;

void _logRequest(
  Uri url,
  String method, {
  Map<String, String>? headers,
  Map<String, dynamic>? body,
  Map<String, String>? multipartFields,
  List<http.MultipartFile>? multipartFiles,
}) {
  debugPrint('[http] --> $method $url');
  debugPrint('${_indent}headers: $headers');

  if (method == 'POST' || method == 'PUT') {
    debugPrint('${_indent}body: $body');

    if (method == 'POST') {
      if (multipartFields != null) {
        debugPrint('${_indent}multipartFields: $multipartFields');
      }
      if (multipartFields != null) {
        debugPrint('${_indent}multipartFiles: $multipartFiles');
      }
    }
  }
}

void _logResponse(http.Response response) {
  debugPrint('[http] <-- ${response.statusCode} ${response.request}');
  try {
    debugPrint('${_indent}body: ' + response.body);
  } catch (_) {}
}

class NetworkUtils {
  static Future get(
    Uri url, {
    Map<String, String>? headers,
  }) async {
    _logRequest(url, 'GET', headers: headers);

    final response = await http.get(url, headers: headers);
    _logResponse(response);
    return _parse(response);
  }

  static dynamic _parse(http.Response response) {
    final body = response.body;
    final statusCode = response.statusCode;

    var decoded;
    try {
      decoded = json.decode(body);
    } catch (error) {
      print("Json parser error: $error");
    }
    if (decoded == null || statusCode < 200 || statusCode >= 300) {
      var message = 'Unknow Error';
      if (statusCode >= 500) {
        message = 'Server Error';
      }
      if (decoded != null && decoded['message'] != null) {
        message = decoded['message'];
      }
      throw RemoteDataSourceException(statusCode, message);
    }

    return decoded;
  }
}
