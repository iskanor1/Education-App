import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:ecommercey/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Api/const.dart';
import '../components/components.dart';
import '../components/const.dart';
import '../cubit/states.dart';
import 'LoginScreen.dart';

class Userscreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {

    },
      builder: (context, state) {
        var c=AppCubit.get(context);
        return ConditionalBuilder(
            condition: AppCubit.get(context).user !=null ,
            builder:  (context) => Padding(
              padding: EdgeInsets.only(top: 0),
              child: Column(
                children: [
                  Stack(
                    clipBehavior: Clip.none, // Allow overflow for the CircleAvatar
                    alignment: Alignment.center, // Center the Stack alignment
                    children: [
                      // Material container with elevation
                      Material(
                        elevation: 10,
                        child: Container(
                            height: 200,
                            width: double.infinity,
                            alignment: Alignment.topCenter,
                            child: Stack(
                              children: [
                                CachedNetworkImage(
                                  imageUrl: ('https://dfstudio-d420.kxcdn.com/wordpress/wp-content/uploads/2019/06/digital_camera_photo-1080x675.jpg'),
                                  color: Color.fromRGBO(38, 38, 38, 1),
                                  imageBuilder: (context, imageProvider) {
                                    return Image(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                    );
                                  },
                                  placeholder: (context, url) => Center(child: Loading(MainColor: colors.Persiangreen.toColor(),SecondColor: colors.TiffanyBlue.toColor(),)),
                                ),
                                Align(
                                  alignment: Alignment.topCenter,
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 30),
                                  ),
                                ),
                              ],
                            )
                        ),
                      ),
                      // CircleAvatar positioned on top of the Material container
                      Positioned(
                        bottom: -75, // Adjust to overlap the bottom
                        child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3), // Shadow color
                                  blurRadius: 10, // Spread of the shadow
                                  spreadRadius: 1,
                                  offset: Offset(0, 5), // Horizontal and vertical offset
                                ),
                              ],
                            ),
                            child: ClipOval(child:
                            ConditionalBuilder(
                              condition: c.user?.record.avatar==null || c.user!.record.avatar==''||c.user!.record.avatar.isEmpty,
                              builder: (context) =>Image(image:
                                AssetImage('360_f_65772719_a1_uv5k_li5n_cewi0_bnlli_fa_bpek_ubv5_fv_VlO1Aq7yFI.jpg',),
                                fit: BoxFit.cover,
                                width: 140, // Diameter of CircleAvatar (2 * radius)
                                height: 140,),
                              fallback: (context) =>CachedNetworkImage(
                                imageUrl: (filepath+'${c.user!.record.collectionId}/${c.user!.record.id}/${c.user!.record.avatar}'),
                                color: Color.fromRGBO(38, 38, 38, 1),
                                imageBuilder: (context, imageProvider) {
                                  return Image(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                    width: 140, // Diameter of CircleAvatar (2 * radius)
                                    height: 140,
                                  );
                                },
                                placeholder: (context, url) => Center(child: Loading(MainColor: colors.Persiangreen.toColor(),SecondColor: colors.Persiangreen.toColor(),),),
                              ) )
                            )
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 80,),
                  Text(
                    '${c.user!.record.first_name+" "+c.user!.record.last_name}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: colors.darkMode?colors.Jet.toColor():colors.Night.toColor(),
                    ),
                  ),
                  SizedBox(height: 100,),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: 200,
                      child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll(colors.Persiangreen.toColor())
                          ),
                          onPressed: () {
                            c.clearTheApp();
                            Navigator.pushReplacement(context, DialogRoute(context: context, builder: (context) => Loginscreen(),));
                          }, child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text("Logout",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18,color: Colors.white),),
                          )),
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
