import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommercey/models/courses_model.dart';
import 'package:flutter/material.dart';
import '../Api/const.dart';
import '../components/components.dart';
import '../components/const.dart';
import 'billingscreen.dart';

class CourseScreen extends StatelessWidget {

  final CoursesItems  Coursesdata;
  CourseScreen({
    Key? key,
    required this.Coursesdata
  }):super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.Snow.toColor(),
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(onPressed: ()
        {
          Navigator.pop(context);
        },
            icon: Icon(Icons.arrow_back_ios_new,color: Colors.white,)
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           Container(
             width: double.infinity,
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.only(
                     bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10)
                 ),
                 boxShadow: [
                   BoxShadow(color: Colors.black,spreadRadius:1,blurRadius:10),
                 ]
               ),
               clipBehavior: Clip.hardEdge,
               child:CachedNetworkImage(
                 imageUrl: (filepath+'${Coursesdata.collectionId}/${Coursesdata.id}/${Coursesdata.field}'),
                 color: Color.fromRGBO(38, 38, 38, 1),
                 imageBuilder: (context, imageProvider) {
                   return Image(
                     image: imageProvider,
                     fit: BoxFit.cover,
                   );
                 },
                 placeholder: (context, url) => Center(child:Loading(MainColor: colors.Persiangreen.toColor(),SecondColor: colors.TiffanyBlue.toColor(),),),
               ),
          //     child: Image(image: NetworkImage(filepath+'${Coursesdata.collectionId}/${Coursesdata.id}/${Coursesdata.field}'))
           ),
           Padding(
             padding: const EdgeInsets.only(top: 30,right: 20,left: 20),
             child: Text(Coursesdata.name,maxLines:1,overflow: TextOverflow.ellipsis,style: TextStyle(color: colors.darkMode?colors.Jet.toColor():colors.Night.toColor(), fontWeight: FontWeight.bold,fontSize: 20),),
           ),
           Padding(
             padding: const EdgeInsets.only(top: 3,right: 20,left: 20),
             child: Text("Created by : "+Coursesdata.author,maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(color:colors.darkMode? Colors.grey.shade400:Colors.grey.shade600,fontSize: 10)),
           ),
           Container(
             height: 300,
             child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Text(Coursesdata.description,maxLines: 12,overflow: TextOverflow.ellipsis,style: TextStyle(color:colors.darkMode?colors.Jet.toColor():colors.Night.toColor(), fontWeight: FontWeight.normal,fontSize: 13),),
                          ),
           ),
           Container(
             height: 200,
             child: Column(
               mainAxisAlignment: MainAxisAlignment.end,
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
             Padding(
               padding: const EdgeInsets.only(left: 30,bottom: 5,right: 30,top: 10),
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   Text("Course Price",maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(color: colors.darkMode?colors.Jet.toColor():colors.Night.toColor(), fontWeight: FontWeight.bold,fontSize: 25)),
                   Text(Coursesdata.price.toString()+"\$",maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(color: colors.darkMode?colors.Jet.toColor().withAlpha(90):colors.Night.toColor(), fontWeight: FontWeight.bold,fontSize: 25)),
                 ],
               ),
             ),
             Padding(
               padding: const EdgeInsets.all(8.0),
               child: Container(
                 color: Colors.grey.shade400,
                 width: double.infinity,
                 height: 1,
               ),
             ),
             Padding(
             padding: const EdgeInsets.only(top: 10,right: 20,bottom: 5,left: 20),
             child: Ebutton(
                 text: "Buy",
                 isSecondColor: colors.darkMode,
                 edo: (){
                   Navigator.push(context, MaterialPageRoute(builder: (context) => BillingScreen()));
                   
                 }
             ),
                            ),
             Padding(
               padding: const EdgeInsets.only(top: 5,right: 20,bottom: 10,left: 20),
               child: Ebutton(
                   text: "See Content",
                   isSecondColor: colors.darkMode,
                   edo: (){}
               ),
             ),
                            ],
                          ),
           ),
         ],
        ),
      ),
    );
  }
}
