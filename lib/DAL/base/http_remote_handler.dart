import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart' as ioclient;
import 'package:wenia/DAL/base/http_remote_util.dart';

import 'package:wenia/core/Entities/common/result_entity.dart';

class HttpRemoteHandler {
  // [Properties]
  final int _httpOK = 200;
  final int _httpError = 404;
  final int _httpTimeOut = 408;
  final Duration _httpTimeout = const Duration(seconds: 20);

  // [Singleton]
  static final HttpRemoteHandler _instance = HttpRemoteHandler._constructor();

  factory HttpRemoteHandler() {
    return _instance;
  }

  // [Constructor]
  HttpRemoteHandler._constructor();

  // [Functions]
  Future<ResultEntity> resultOK(http.Response responseService) async {
    ResultEntity getResult = ResultEntity.empty();
    getResult.result = false;

    getResult.statusCode = responseService.statusCode;

    if (getResult.statusCode == _httpOK) {
      getResult.result = true;
      getResult.data = responseService.body;
    }
    else {
      log('Error in request: ${responseService.statusCode}');
      log('Server response: ${responseService.body}');
    }

    return getResult;
  }

  ResultEntity resultError(dynamic error, String endPoint) {
    ResultEntity catchErrorResult = ResultEntity.empty();
    catchErrorResult.result = false;

    catchErrorResult.statusCode = _httpError;
    
    if (kDebugMode) {
      log('Error: $error, Message: ${error.message}, Method: $endPoint');
    }

    return catchErrorResult;
  }
  
  ResultEntity resultTimeout() {
    ResultEntity timeoutResult = ResultEntity.empty();
    timeoutResult.result = false;

    timeoutResult.statusCode = _httpTimeOut;
    return timeoutResult;
  }
  
  // [Methods]

  // [Get]
  Future<ResultEntity> baseGET(String server, String endPoint) async {
    HttpClient httpClient = HttpClient();
    var client = ioclient.IOClient(httpClient);

    return await client.get(Uri.parse(server + endPoint),
                            headers: HttpRemoteUtil().getHeaders())
      .then((http.Response response) async {
        return await resultOK(response);
      }).catchError((error) {
        return resultError(error, endPoint);
      }).timeout(_httpTimeout, onTimeout: () {
        return resultTimeout();
      });
  }
}