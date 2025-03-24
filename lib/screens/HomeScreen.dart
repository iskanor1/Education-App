import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Api/const.dart';
import '../components/components.dart';
import '../components/const.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';
import 'CourseScreen.dart';

class Homescreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {

      },
      builder: (context, state) {

        var c=AppCubit.get(context);

        return  ConditionalBuilder(
          condition: state is! GetHomeDataFailedState && state is! GetHomeDataState && c.Courses!.totalItems>=0,
          builder:(context) => SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20,left: 10,right: 10),
                      child: Container(
                        decoration: BoxDecoration(
                            color: colors.Persiangreen.toColor(),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 7,horizontal: 13),
                          child: Text('TRENDING',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: colors.darkMode?colors.Jet.toColor():colors.Snow.toColor(),),maxLines: 1,overflow: TextOverflow.ellipsis),
                        ),
                      ),
                    ),
                  ],),
                CarouselSlider.builder(
                  itemCount: c.Courses!.totalItems,
                  itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
                      GestureDetector(
                        onTap: () => Navigator.push(context,DialogRoute(context: context, builder: (context) => CourseScreen(Coursesdata: c.Courses!.items[itemIndex],),)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: Color.fromRGBO(38, 38, 38, 1),
                            ),
                            clipBehavior: Clip.hardEdge,
                            child:Stack(
                              alignment: AlignmentDirectional.bottomStart,
                              children: [
                                CachedNetworkImage(
                                    imageUrl: (filepath+'${c.Courses!.items[itemIndex].collectionId}/${c.Courses!.items[itemIndex].id}/${c.Courses!.items[itemIndex].field}'),
                                    color: Color.fromRGBO(38, 38, 38, 1),
                                    imageBuilder: (context, imageProvider) {
                                      return Image(
                                        image: imageProvider,
                                        width: double.infinity,
                                        height: double.infinity,
                                        fit: BoxFit.cover,
                                      );
                                    },
                                  placeholder: (context, url) => Center(child:Loading(MainColor: colors.Persiangreen.toColor(),SecondColor: colors.TiffanyBlue.toColor(),),),
                                ),
                                Container(
                                  color: colors.Night.withAlpha(0.5).toColor(),
                                  width: double.infinity,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                                    child: Text(c.Courses!.items[itemIndex].name,style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),maxLines: 1,overflow: TextOverflow.ellipsis),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                  options: CarouselOptions(
                      enlargeCenterPage: true,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      autoPlay: true,
                      //height:  MediaQuery.of(context).size.width.toInt()<=560?:500,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20,left: 10,right: 10),
                      child: Container(
                        decoration: BoxDecoration(
                            color: colors.Persiangreen.toColor(),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 7,horizontal: 13),
                          child: Text('COURSES',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: colors.darkMode?colors.Jet.toColor():colors.Snow.toColor()),maxLines: 1,overflow: TextOverflow.ellipsis),
                        ),
                      ),
                    ),
                  ],),
                //rebuild this ....
                GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: MediaQuery.of(context).size.width.toInt()<=560?2:3,childAspectRatio: 1/1.13),
                  shrinkWrap: true,
                  itemCount: c.Courses!.totalItems,
                  scrollDirection: Axis.vertical,
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 10),

                  itemBuilder: (context, index) =>GestureDetector(
                    onTap: () => Navigator.push(context,DialogRoute(context: context, builder: (context) => CourseScreen(Coursesdata: c.Courses!.items[index],),)),
                    child: Card(
                      color: colors.Night.toColor(),
                      elevation: 15,
                      margin: EdgeInsets.all(10),
                      clipBehavior: Clip.hardEdge,
                      child:Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: CachedNetworkImage(
                              imageUrl: (filepath+'${c.Courses!.items[index].collectionId}/${c.Courses!.items[index].id}/${c.Courses!.items[index].field}'),
                              color: Color.fromRGBO(38, 38, 38, 1),
                              imageBuilder: (context, imageProvider) {
                                return Image(
                                  image: imageProvider,
                                  width: double.infinity,
                                  height: 100,
                                  fit: BoxFit.cover,
                                );
                              },
                              placeholder: (context, url) => Center(child: Loading(MainColor: colors.Persiangreen.toColor(),SecondColor: colors.TiffanyBlue.toColor(),),),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 3),
                            child: Text(c.Courses!.items[index].name,style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),maxLines: 1,overflow: TextOverflow.ellipsis),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 3),
                            child: Text(c.Courses!.items[index].price.toString()+'\$',style: TextStyle(color: Colors.white.withOpacity(1),fontSize: 12),maxLines: 1,overflow: TextOverflow.ellipsis),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 3),
                                child: Text('Made by: '+c.Courses!.items[index].author,style: TextStyle(color: Colors.white.withOpacity(0.7),fontSize: 10),maxLines: 1,overflow: TextOverflow.ellipsis),
                              ),

                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          fallback: (context) => Loading(MainColor: colors.Persiangreen.toColor(),SecondColor: colors.TiffanyBlue.toColor(),),
        );
      },
    );
  }
}
