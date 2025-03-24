class OwnedCoursesModel
{
  late String id;
  late String collectionId;
  late String collectionName;
  late String created;
  late String updated;
  late String code;
  late String course;
  late String owner;
  OwnedCoursesModel.fromJson(Map<String,dynamic>json){
    id=json["id"];
    collectionId=json["collectionId"];
    collectionName=json["collectionName"];
    created=json["created"];
    updated=json["updated"];
    code=json["code"];
    course=json["course"];
    owner=json["owner"];
  }
}