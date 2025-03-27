import 'package:dio/dio.dart';

class DioHelper
{
  // https://drawn-us.pockethost.io/
  // api/collections/users/auth-with-password
   static late Dio dio;

   static init()
   {
     dio=Dio(
       BaseOptions(
         baseUrl:"https://drawn-us.pockethost.io/" ,
         receiveDataWhenStatusError: true
       ),

     );

   }

   static Future<Response> getData({required String url, required Map<String,dynamic> query,token})async
   {
     return await dio.get(
       url,
       queryParameters: query,
         options: Options(
             headers: {'Authorization': 'Bearer $token'}
         )
     );
   }


   static Future<Response> postData({required String url, required Map<String,dynamic> query,var token})async
   {
     return await dio.post(
         url,
         data: query,
         options: Options(
             headers: {'Authorization': 'Bearer $token'}
         ));
   }

   static Future<Response> postLogin({required String url, required Map<String,dynamic> query})async
   {
     return await dio.post(url,data: query);
   }

   static Future<Response> postVerification({required String url, required Map<String,dynamic> query})async
   {
     return await dio.post(url,data: query);
   }

   static Future<Response> postRegister({required String url, required Map<String,dynamic> query,})async
   {
     return await dio.post(url,data: query);
   }

}