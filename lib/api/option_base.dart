import 'dart:io';

import 'package:dio/dio.dart';

class BaseOptionApi extends BaseOptions {
  static final int _receiveTimeout = 10000;

  static final int _connectTimeout = 10000;

  static final String _baseUrl = "https://607a9689bd56a60017ba2d1f.mockapi.io/";



  BaseOptionApi()
      : super(
      receiveTimeout: _receiveTimeout,
      connectTimeout: _connectTimeout,
      headers: {},
      baseUrl: _baseUrl);
}
