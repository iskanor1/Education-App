class UserModel
{
   late String token;
   late UserRecord record;

   UserModel.fromJson(Map<String,dynamic>json){
     token=json["token"];
     record=UserRecord.fromJson(json['record']);
   }
}

class UserRecord
{
  late String id;
  late String collectionId;
  late String collectionName;
  late String username;
  late bool verified;
  late bool emailVisibility;
  late String email;
  late String created;
  late String updated;
  late String first_name;
  late String last_name;
  late String avatar;
  late String phone;
  late String date_of_birth;
  late List<String> courses=[];
  UserRecord.fromJson(Map<String,dynamic>json){
    id=json['id'];
    collectionId=json['collectionId'];
    collectionName=json['collectionName'];
    username=json['username'];
    verified=json['verified'];
    emailVisibility=json['emailVisibility'];
    email=json['email'];
    created=json['created'];
    updated=json['updated'];
    first_name=json['first_name'];
    last_name=json['last_name'];
    avatar=json['avatar'];
    phone=json['phone'];
    date_of_birth=json['date_of_birth'];
    json['courses'].forEach((course){
      courses.add(course);
    });
  }
}