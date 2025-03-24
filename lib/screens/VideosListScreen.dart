
import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:ecommercey/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Api/const.dart';
import '../components/components.dart';
import '../components/const.dart';
import '../cubit/states.dart';
import 'VideoPlayerScreen.dart';

class VideoListScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {
        if (state is GetVideoUrlSuccessfulState) {
          Navigator.push(
            context,
            DialogRoute(
                context: context,
                builder: (context) => Videoplayerscreen(url: state.videoUrl),
            )
          );
        }
      },
      builder: (context, state) {
        var c=AppCubit.get(context);
        return Scaffold(
          backgroundColor: colors.Snow.toColor(),
          appBar: AppBar(backgroundColor: colors.Snow.toColor(),leading: IconButton(onPressed: () => Navigator.pop(context), icon: Icon(Icons.arrow_back_ios,color: colors.Jet.toColor(),)),),
          body:  ConditionalBuilder(
              condition: c.Videos!=null && state is GetVideosDataSuccessfulState || state is GetVideoUrlSuccessfulState || state is GetVideoTokenSuccessfulState || state is GetVideoTokenState,
              builder: (context) => ListView.builder(
                itemCount: c.Videos!.totalItems,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(5),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Colors.black
                      ),
                      clipBehavior: Clip.antiAlias,
                      width: double.infinity,
                      child: Row(
                        children: [
                          CachedNetworkImage(
                            imageUrl: (filepath+'${c.Videos!.items[index].collectionId}/${c.Videos!.items[index].id}/${c.Videos!.items[index].image}'),
                            color: Color.fromRGBO(38, 38, 38, 1),
                            imageBuilder: (context, imageProvider) {
                              return Image(
                                height: 120,
                                image: imageProvider,
                                fit: BoxFit.cover,
                              );
                            },
                            placeholder: (context, url) => Loading(MainColor: colors.Persiangreen.toColor(),SecondColor: colors.TiffanyBlue.toColor(),),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10,right: 10,top: 5),
                                    child: Text("${c.Videos!.items[index].name}"
                                      ,maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 20),),
                                  ),
                                ),
                                Container(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Text("${c.Videos!.items[index].description}"
                                      ,maxLines: 3,overflow: TextOverflow.ellipsis,style: TextStyle(color: Colors.white, fontWeight: FontWeight.normal,fontSize: 14),),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              c.getVideoAndNavigate(context, c.Videos!.items[index].collectionId, c.Videos!.items[index].id, c.Videos!.items[index].video);
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 5),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(topRight: Radius.circular(16),bottomRight: Radius.circular(13)),
                                  color: Colors.white,
                                ),
                                height: 110,
                                width: 50,
                                child: Icon(Icons.play_arrow,color: Colors.black,),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
              fallback: (context) =>Loading(MainColor: colors.Persiangreen.toColor(),SecondColor: colors.TiffanyBlue.toColor(),),
          ),
        );
      },
    );
  }
}
