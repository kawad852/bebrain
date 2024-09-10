import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:bebrain/alerts/loading/app_over_loader.dart';
import 'package:bebrain/network/api_url.dart';
import 'package:bebrain/utils/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

enum ApiType { get, post }

class ApiService<T> {
  static const String formatException = 'format-exception';
  static const String httpException = 'http-exception';
  static const String socketException = 'socket-exception';
  static const String timeoutException = 'timeout-exception';
  static const String generalException = 'general-exception';

  final kAuthorizedHeader = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ${MySharedPreferences.accessToken}',
    'x-localization': MySharedPreferences.language,
  };

  final kPublicHeader = {
    'Content-Type': 'application/json',
    'x-localization': MySharedPreferences.language,
  };

  Future<T> uploadFiles({
    required String url,
    required Function(Map<String, dynamic> value) builder,
    Function(T model)? onSuccess,
    required Function(http.MultipartRequest value) onRequest,
  }) async {
    final futureCallback = await _handleCall(() async {
      final uri = Uri.parse('${ApiUrl.mainUrl}$url');

      var request = http.MultipartRequest('POST', uri);

      onRequest(request);

      var response = await request.send();

      var responseBody = await http.Response.fromStream(response).then((response) => response.body);
       log("ApiRequest::URL:: $url\nSTATUSCODE:: ${response.statusCode}\nBODY:: $responseBody");

      Map<String, dynamic> json = jsonDecode(responseBody);
      if (onSuccess != null) {
        final model = builder(json) as T;
        onSuccess(model);
      }
      return builder(json);
    });
    return futureCallback;
  }

  Future<T> build({
    String? url,
    required bool isPublic,
    Map<String, String>? additionalHeaders,
    Map<String, dynamic>? queryParams,
    Function(T model)? onEnd,
    required ApiType apiType,
    required Function(Map<String, dynamic> value) builder,
    Map<String, String>? callHeaders,
    String? link,
  }) async {
    final futureCallback = await _handleCall(() async {
      late http.Response response;
      final uri = Uri.parse(link ?? '${ApiUrl.mainUrl}$url');
      Map<String, String> headers = callHeaders ?? (isPublic ? kPublicHeader : kAuthorizedHeader);
      if (additionalHeaders != null) {
        headers.addAll(additionalHeaders);
        log("ApiHeaders:: $headers");
      }
      late String body;
      if (apiType == ApiType.get) {
        response = await http.get(
          uri,
          headers: headers,
        );
      }
      if (apiType == ApiType.post) {
        if (queryParams == null) {
          throw 'Missing post-api body';
        }
        body = jsonEncode(queryParams);
        response = await http.post(
          uri,
          headers: headers,
          body: body,
        );
      }
       log("ApiRequest::\nURL:: ${link ?? uri}\nQueryParameters:: $queryParams\nSTATUSCODE:: ${response.statusCode}");
      if (onEnd != null) {
        Map<String, dynamic> json = jsonDecode(response.body);
        final model = builder(json) as T;
        await onEnd(model);
      }
      Map<String, dynamic> json = jsonDecode(response.body);
      return builder(json);
    }).timeout(
      const Duration(seconds: 20),
      onTimeout: () => throw Failure(type: timeoutException, code: ''),
    );

    return futureCallback;
  }

  _handleCall(dynamic Function() call) async {
    try {
      // throw HttpException('');
      // throw FormatException('');
      // throw TimeoutException('');
      // throw SocketException('');
      // throw Exception();

      return await call();
    } on HttpException catch (e) {
      log("Exception::\nType:: HttpException\nmsg:: ${e.message}");
      throw Failure(type: httpException, code: e.message);
    } on FormatException catch (e) {
      log("Exception::\nType:: FormatException\nmsg:: $e");
      throw Failure(type: formatException, code: e.message);
    } on SocketException catch (e) {
      log("Exception::\nType:: SocketException\nmsg:: $e");
      throw Failure(type: socketException, code: e.message);
    } on TimeoutException catch (e) {
      log("Exception::\nType:: TimeoutException\nmsg:: $e");
      throw Failure(type: timeoutException, code: e.message ?? '');
    } catch (e) {
      log("Exception::\nType:: GeneralException\nmsg:: $e");
      throw Failure(type: generalException, code: e.toString());
    }
  }
}

class ApiFutureBuilder<T> {
  Future fetch(
    BuildContext context, {
    Function(Failure failure)? onError,
    required Future<T> Function() future,
    Function(T snapshot)? onComplete,
    bool withOverlayLoader = true,
    Widget? indicator,
  }) async {
    if (withOverlayLoader) {
      AppOverlayLoader.show(indicator: indicator);
    }

    await future().whenComplete(() {
      if (withOverlayLoader) {
        AppOverlayLoader.hide();
      }
    }).then((value) {
      if (onComplete != null) {
        onComplete(value);
      }
    }, onError: (error) {
      if (error is Failure && onError != null) {
        onError(error);
      }
    });
  }
}

class BearFetcher<T> extends ApiFutureBuilder {
  void execute(
    BuildContext context, {
    required Future Function() futures,
  }) async {
    await futures();
  }
}

class Failure {
  final String type, code;

  Failure({
    required this.type,
    required this.code,
  });
}
