import 'package:chewie/chewie.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:ecommercey/cubit/cubit.dart';
import 'package:ecommercey/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

import '../components/components.dart';
import '../components/const.dart';

class Videoplayerscreen extends StatefulWidget {

  @override
  State<Videoplayerscreen> createState() => _VideoplayerscreenState();
  late String url;

  Videoplayerscreen({required this.url});
}

class _VideoplayerscreenState extends State<Videoplayerscreen> {

  late VideoPlayerController videoPlayerController;
  ChewieController? chewieController;
  bool _isInitialized = false;

  Future<void> initPlayer(String url) async {
    videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(url));
    await videoPlayerController.initialize();
    setState(() {
      chewieController = ChewieController(

        showOptions: false,
        materialProgressColors: ChewieProgressColors(
          handleColor: colors.Persiangreen.toColor(),
          playedColor: colors.TiffanyBlue.toColor(),
          bufferedColor: colors.Persiangreen.withLightness(0.85).toColor()
        ),
        cupertinoProgressColors: ChewieProgressColors(
            handleColor: colors.Persiangreen.toColor(),
            playedColor: colors.TiffanyBlue.toColor(),
            bufferedColor: colors.Persiangreen.withLightness(0.85).toColor()
        ),
        videoPlayerController: videoPlayerController,
        autoPlay: false,
        looping: false,
      );
      _isInitialized = true; // Mark initialization as complete
    });
  }

  @override
  void initState(){
    initPlayer(widget.url);
    super.initState();
  }
  @override
 void dispose(){
   videoPlayerController.dispose();
   chewieController?.dispose();
   super.dispose();
 }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
         listener: (context, state) {

         },
          builder: (context, state) {

            var c=AppCubit.get(context);
            return Scaffold(
              backgroundColor: colors.Snow.toColor(),
              body: ConditionalBuilder(
                  condition: _isInitialized && chewieController != null,
                  builder: (context) => Container(
                    color: colors.Snow.toColor(),
                    child: Chewie(
                      controller: chewieController!,
                    ),
                  ),
                  fallback: (context) => Loading(MainColor: colors.Persiangreen.toColor(),SecondColor: colors.TiffanyBlue.toColor(),)),
            );
          },
    );
  }
}
