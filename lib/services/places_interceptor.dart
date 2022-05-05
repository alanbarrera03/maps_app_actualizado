import 'package:dio/dio.dart';

class PlacesInterceptor extends Interceptor {
  final accessToken =
      'pk.eyJ1IjoiYWxhbmJhcnJlcmEiLCJhIjoiY2tlOHhuaGJpMjFhbzJ6cDhwYzJ4ZmFrcyJ9.Hnpdmd4_V-qtk4yHeP9AOQ';
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.queryParameters
        .addAll({'access_token': accessToken, 'language': 'es'});

    super.onRequest(options, handler);
  }
}
