class VideosModel
{
  late int page;
  late int perPage;
  late int totalPages;
  late int totalItems;
  late List<VideosModelItems> items=[];
  VideosModel.fromJson(Map<String,dynamic>json){
    page=json["page"];
    perPage=json["perPage"];
    totalPages=json["totalPages"];
    totalItems=json["totalItems"];
    json['items'].forEach((item){
      items.add(VideosModelItems.fromJson(item));
    });
  }
}

class VideosModelItems
{
  late String id;
  late String collectionId;
  late String collectionName;
  late String created;
  late String updated;
  late List<String> course=[];
  late String name;
  late String description;
  late String video;
  late String image;

  VideosModelItems.fromJson(Map<String,dynamic>json){
    id=json["id"];
    collectionId=json["collectionId"];
    collectionName=json["collectionName"];
    created=json["created"];
    updated=json["updated"];
    json['course'].forEach((item){
      course.add(item);
    });
    name=json["name"];
    description=json["description"];
    video=json['video'];
    image=json['image'];

  }
}