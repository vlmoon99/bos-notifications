import 'dart:convert';
import 'dart:typed_data';

import '../../flutter_flow/flutter_flow_util.dart';
import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

class GetNotificationsByUserIdCall {
  static Future<ApiCallResponse> call({
    String? action = 'notify',
    String? accountId = 'vlmoon.near',
    int? limit = 10,
    String? order = 'desc',
    int? from = 98202726,
  }) {
    final ffApiRequestBody = '''
{
  "action": "${action}",
  "key": "${accountId}",
  "options": {
    "limit": ${limit},
    "order": "${order}",
    "subscribe": true,
    "from": ${from}
  }
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'getNotificationsByUserId',
      apiUrl: 'https://api.near.social/index',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }

  static dynamic notificationsRawData(dynamic response) => getJsonField(
        response,
        r'''$[:]''',
        true,
      );
}

class GetNotificationsByUserIdWithoutFromValueCall {
  static Future<ApiCallResponse> call({
    String? action = 'notify',
    String? accountId = 'vlmoon.near',
    int? limit = 10,
    String? order = 'desc',
  }) {
    final ffApiRequestBody = '''
{
  "action": "${action}",
  "key": "${accountId}",
  "options": {
    "limit": ${limit},
    "order": "${order}",
    "subscribe": true
  }
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'getNotificationsByUserIdWithoutFromValue',
      apiUrl: 'https://api.near.social/index',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }

  static dynamic notificationsRawData(dynamic response) => getJsonField(
        response,
        r'''$[:]''',
        true,
      );
}

class GetMainNetLatestBlockHeightCall {
  static Future<ApiCallResponse> call() {
    final ffApiRequestBody = '''
{
  "jsonrpc": "2.0",
  "id": "dontcare",
  "method": "status",
  "params": []
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'getMainNetLatestBlockHeight',
      apiUrl: 'https://rpc.mainnet.near.org',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }

  static dynamic latestBlockHeight(dynamic response) => getJsonField(
        response,
        r'''$.result.sync_info.latest_block_height''',
      );
}

class GetNearSocialInformationCall {
  static Future<ApiCallResponse> call({
    String? accountId = 'vlmoon.near',
  }) {
    final ffApiRequestBody = '''
{
  "keys": [
    "${accountId}/profile/**"
  ]
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'getNearSocialInformation',
      apiUrl: 'https://api.near.social/get',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }

  static dynamic all(dynamic response) => getJsonField(
        response,
        r'''$''',
      );
}

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list);
  } catch (_) {
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar);
  } catch (_) {
    return isList ? '[]' : '{}';
  }
}
