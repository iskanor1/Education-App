class TokenModel
{
  late String token;

  TokenModel.fromJson(Map<String,dynamic>json){
    token=json["token"];
  }
}