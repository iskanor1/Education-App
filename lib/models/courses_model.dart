class CoursesModel
{
  late int page;
  late int perPage;
  late int totalPages;
  late int totalItems;
  late List<CoursesItems> items=[];
  CoursesModel.fromJson(Map<String,dynamic>json){
    page=json["page"];
    perPage=json["perPage"];
    totalPages=json["totalPages"];
    totalItems=json["totalItems"];
    json['items'].forEach((item){
      items.add(CoursesItems.fromJson(item));
    });
  }
}

class CoursesItems
{
  late String id;
  late String collectionId;
  late String collectionName;
  late String created;
  late String updated;
  late String name;
  late String description;
  late String author;
  late String field;
  late int price;

  CoursesItems.fromJson(Map<String,dynamic>json){
    id=json["id"];
    collectionId=json["collectionId"];
    collectionName=json["collectionName"];
    created=json["created"];
    updated=json["updated"];
    name=json["name"];
    description=json["description"];
    author=json["author"];
    field=json["field"];
    price=json["price"];

  }
}