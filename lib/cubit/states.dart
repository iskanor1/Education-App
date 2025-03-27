abstract class AppStates{}

class AppInitialState extends AppStates{}

class LoginState extends AppStates{}

class LoginSuccessfulState extends AppStates{

}

class LoginFailedState extends AppStates{}

class RegisterState extends AppStates{}

class RegisterSuccessfulState extends AppStates{}

class RegisterFailedState extends AppStates{}

class ChangeScreenState extends AppStates{}

class GetHomeDataState extends AppStates{}

class GetHomeDataSuccessfulState extends AppStates{}

class GetHomeDataFailedState extends AppStates{}

class GetUserCoursesDataState extends AppStates{}

class GetUserCoursesDataSuccessfulState extends AppStates{}

class GetUserCoursesDataFailedState extends AppStates{}

class LoadVideoState extends AppStates{}

class LoadVideoSuccessfulState extends AppStates{}

class LoadVideoFailedState extends AppStates{}

class GetVideoTokenState extends AppStates{}

class GetVideoTokenSuccessfulState extends AppStates{}

class GetVideoTokenFailedState extends AppStates{}

class GetVideoUrlSuccessfulState extends AppStates{
  final String videoUrl;
  GetVideoUrlSuccessfulState(this.videoUrl);
}
class VideoExitSuccessfulState extends AppStates{}

class GetVideosDataState extends AppStates{}

class GetVideosDataSuccessfulState extends AppStates{}

class GetVideosDataFailedState extends AppStates{}

class ChangeColorState extends AppStates{}

class BillingInformationState extends AppStates {}

class BillingInformationSuccessfulState extends AppStates {
  BillingInformationSuccessfulState(data);
}

class BillingInformationFailedState extends AppStates {}