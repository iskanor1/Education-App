import 'package:dio/dio.dart';

class DioPay {
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: "https://accept.paymob.com/",
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> postBillingData({
    required Map<String, dynamic> requestData,
    required url,
  }) async {
    return await dio.post(
     url,
      data: requestData,
      options: Options(
        headers: {
          'Authorization': 'Token egy_sk_test_6646401282088981031384d64604d882bf57c81c2547f74e2a5f150b42ccfa9b',
          'Content-Type': 'application/json',
        },
      ),
    );
  }
}
