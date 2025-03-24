import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Api/const.dart';
import '../components/components.dart';
import '../components/const.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';
import 'VideosListScreen.dart';

class Usercoursesscreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        var c=AppCubit.get(context);
        return ConditionalBuilder(
          condition: c.user!.record.courses.isNotEmpty && c.user !=null && c.UserCourses != null,
          builder: (context) => GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 1/1.13),
            shrinkWrap: true,
            itemCount: c.UserCourses!.totalItems,
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.symmetric(horizontal: 10),
            itemBuilder: (context, index) =>GestureDetector(
              onTap: () async{
                await c.VideosData(c.UserCourses!.items[index].id);
                Navigator.push(context,MaterialPageRoute(builder: (context) => VideoListScreen(),));
              },
              child: Card(
                color: colors.Night.toColor(),
                elevation: 15,
                margin: EdgeInsets.all(10),
                clipBehavior: Clip.hardEdge,
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child:CachedNetworkImage(
                        imageUrl: (filepath+'${c.UserCourses!.items[index].collectionId}/${c.UserCourses!.items[index].id}/${c.UserCourses!.items[index].field}'),
                        color: Color.fromRGBO(38, 38, 38, 1),
                        imageBuilder: (context, imageProvider) {
                          return Image(
                            image: imageProvider,
                            width: double.infinity,
                            height: 115,
                            fit: BoxFit.cover,
                          );
                        },
                        placeholder: (context, url) => Center(child: Loading(MainColor: colors.Persiangreen.toColor(),SecondColor: colors.TiffanyBlue.toColor(),)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                      child: Text(c.UserCourses!.items[index].name,style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.bold),maxLines: 1,overflow: TextOverflow.ellipsis),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 3),
                            child: Text('Made by: '+c.UserCourses!.items[index].author,style: TextStyle(color: Colors.white.withOpacity(0.7),fontSize: 10),maxLines: 1,overflow: TextOverflow.ellipsis),
                          ),
                          Expanded(child: Center(child: Text('-'+'/'+'-',style: TextStyle(color: Colors.white.withOpacity(0.7),fontSize: 10),maxLines: 1,overflow: TextOverflow.ellipsis))),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          fallback: (context) => Center(child: Text('You don\'t have any courses at the moment.',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Color.fromRGBO(38, 38, 38, 0.7),),),),
        );
      },
    );
  }
}
