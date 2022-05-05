import 'package:dio/dio.dart';

class TrafficInterceptor extends Interceptor {
  final accessToken =
      'pk.eyJ1IjoiYWxhbmJhcnJlcmEiLCJhIjoiY2tlOHhuaGJpMjFhbzJ6cDhwYzJ4ZmFrcyJ9.Hnpdmd4_V-qtk4yHeP9AOQ';
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.queryParameters.addAll({
      'alternatives': true,
      'geometries': 'polyline6',
      'language': 'es',
      'overview': 'simplified',
      'steps': true,
      'access_token': accessToken
    });

    super.onRequest(options, handler);
  }
}
