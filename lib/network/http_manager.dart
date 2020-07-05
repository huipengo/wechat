import 'package:dio/dio.dart';
import 'package:wechat/network/app_configure.dart';
import 'package:wechat/network/code.dart';
import 'package:wechat/network/response.dart' as HttpResponse;

export 'code.dart';
export 'response.dart';

class HttpManager {
  static final Dio _dio = Dio();

  static Future request(String url,
      {String method = 'GET',
      Map<String, dynamic> queryParameters,
      int receiveTimeout = AppConfigure.CONNECT_TIMEOUT}) {
    final options = Options(method: method, receiveTimeout: receiveTimeout);
    return _dio.request(url,
        queryParameters: queryParameters, options: options);
  }
}

Future<HttpResponse.Response> get(
  String path, {
  Map<String, dynamic> queryParameters,
  int receiveTimeout,
}) async {
  HttpResponse.Response response;
  try {
    Response dioResponse = await HttpManager.request(
      path,
      method: 'GET',
      queryParameters: queryParameters,
      receiveTimeout: receiveTimeout,
    ) as Response;
    response = HttpResponse.Response(
        data: dioResponse.data['data'],
        statusCode: Code.SUCCESS,
        message: dioResponse.statusMessage);
  } on DioError catch (e) {
    response =
        HttpResponse.Response(statusCode: Code.FAILED, message: e.message);
  }
  return response;
}
