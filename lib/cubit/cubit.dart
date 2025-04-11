import 'package:bloc/bloc.dart';
import 'package:ecommercey/Api/dio.dart';
import 'package:ecommercey/cubit/states.dart';
import 'package:ecommercey/models/courses_model.dart';
import 'package:ecommercey/models/token_model.dart';
import 'package:ecommercey/models/user_model.dart';
import 'package:ecommercey/models/videos_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Api/dio_pay.dart';
import '../components/const.dart';
import '../models/payment_request.dart';
import '../screens/HomeScreen.dart';
import '../screens/UserCoursesScreen.dart';
import '../screens/UserScreen.dart';

class AppCubit extends Cubit<AppStates>
{
  AppCubit():super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  UserModel? user;
  CoursesModel? Courses;
  CoursesModel? UserCourses;
  VideosModel? Videos;
  late TokenModel videotoken;
  var filter;

  //create billing information
  PaymentModel? paymentModel;

  Future<void> billingInformation({
    required  fname ,
    required  lname ,
    required  Apartment ,
    required  Building ,
    required  phoneNumber ,
    required  country ,
    required  city ,
    required floor,
    required state,
    required street,
    required email,
    required price,
    required courseId,
    required userId,

}) async {
    emit(BillingInformationState());
    await DioPay.postBillingData(url: "v1/intention/", requestData: {
      'amount':price*100,
      'currency':'EGP',
      'payment_methods':[
        4941494
      ],
       'billing_data':{
         'apartment':Apartment,
         'first_name':fname,
         'last_name':lname,
         'street':street,
         'building':Building,
         'phone_number':phoneNumber,
         'city':city,
         'country':country,
         'email':email,
         'floor':floor,
         'state':state,

       },
      'extras':{
        'courseId':courseId,
        'userId':userId,
      },
      "expiration": 3600,
      "notification_url": "https://hook.eu2.make.com/hkxsijulms0j6n0hfkmjkcjvfbgofk4k",
      "redirection_url": "https://edu4u.my.canva.site/"


    } ).then((value)async {
      print('value print ${value.data.toString()}');
      paymentModel = await PaymentModel.fromJson(value.data);
      print('-----------------');
      print(paymentModel);
      print('------------------');
      emit(BillingInformationSuccessfulState(value.data));
    }).catchError((e) {
      print(e.toString());

      emit(BillingInformationFailedState());
    });
  }


  void  login(String email,String password){
    emit(LoginState());
  //login logic
    DioHelper.postLogin(url: 'api/collections/users/auth-with-password', query: {
      'identity':email,
      'password':password,
    }).then((value) async {
       print(value.data);
       user = await UserModel.fromJson(value.data);
       if(user!.record.courses.isNotEmpty)
         {
          filter =await "${"id~\'"+user!.record.courses.join("\' \|\| \ id~'")}'";
          print(filter);
          await UserCoursesData();
         }
       emit(LoginSuccessfulState());
    },).catchError(
        (e){
          print(e.toString());
          emit(LoginFailedState());
        }
    );

  }

  void register({required fname,required lname,required email,required password, required passwordConfirm,required phone,required dob}){
    emit(RegisterState());

    DioHelper.postRegister(url: 'api/collections/users/records', query: {
      'first_name':fname,
      'last_name':lname,
      'email':email,
      'password':password,
      'passwordConfirm':passwordConfirm,
      'phone':phone,
      'date_of_birth':dob,
    }).then((value) {

      DioHelper.postVerification(url:'api/collections/users/request-verification',query:{
        'email':email,
      });
      print(value.data.toString());
      emit(RegisterSuccessfulState());
    },).catchError((e){
      print(e.toString());
      emit(RegisterFailedState());
    });
  }
  
  void homeData(){
    emit(GetHomeDataState());
    DioHelper.getData(url: 'api/collections/courses/records', query:
    {

    }).then((value) async{
      print(value.toString());
        Courses =await CoursesModel.fromJson(value.data);
       print('--------------------------');
        print(Courses!.page);
      print(Courses!.items[0].name);
        emit(GetHomeDataSuccessfulState());
    },).catchError((e){
      print(e.toString());
        emit(GetHomeDataFailedState());
    });
  }

  Future<void> UserCoursesData()async {
    emit(GetUserCoursesDataState());
    await DioHelper.getData(url: 'api/collections/courses/records', query:
    {
      'filter': filter,
    }).then((value) async{
      print(value.toString());
      UserCourses =await CoursesModel.fromJson(value.data);
      print("\n------User courses-------\n");
      print(UserCourses);
      emit(GetUserCoursesDataSuccessfulState());
    },).catchError((e){
      print(e.toString());
      emit(GetUserCoursesDataFailedState());
    });
  }

  void clearTheApp(){
    user=null;
    Courses=null;
    UserCourses=null;
    filter=null;
    index=0;
  }
  // navigation
  int index=0;
  void changeScreen(Newindex){

    index=Newindex;
    emit(ChangeScreenState());
  }
  List<Widget> screens=[Homescreen(),Usercoursesscreen(),Userscreen(),];


  //video

  Future<void> GetVideoToken()async {
    emit(GetVideoTokenState());
    await DioHelper.postData(url: 'api/files/token',token: user!.token, query:
    {
    }).then((value) async{
      print(value.toString());
      videotoken=TokenModel.fromJson(value.data);
      emit(GetVideoTokenSuccessfulState());
    },).catchError((e){
      print(e.toString());
      emit(GetVideoTokenFailedState());
    });
  }
  void getVideoAndNavigate(BuildContext context, String collectionId, String videoId, String videoName) async {
    await GetVideoToken();
    final videoUrl = 'https://drawn-us.pockethost.io/api/files/$collectionId/$videoId/$videoName?token=${videotoken.token}';
    emit(GetVideoUrlSuccessfulState(videoUrl)); // Pass the URL with the state
  }

  void videoExit(){
    emit(VideoExitSuccessfulState());
  }
  Future<void> VideosData(String id)async{
    emit(GetVideosDataState());
    DioHelper.getData(url: 'api/collections/video/records',token: user!.token, query:
    {
      'filter': 'course~\'${id}\'',
    }).then((value) async{
      print(value.toString());
      Videos = await VideosModel.fromJson(value.data);
      print('\n-----------VideosModel--------------\n');
      print(Videos!.page);
      print(Videos!.items[0].name);
      emit(GetVideosDataSuccessfulState());
    },).catchError((e){
      print(e.toString());
      emit(GetVideosDataFailedState());
    });
  }


  //colors
  void DarkMode()
  {
    colors.changeMode();
    emit(ChangeColorState());
  }
}