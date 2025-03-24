import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import '../components/components.dart';
import '../components/const.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';


class Mainscreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var keycontroller=TextEditingController();
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {
        print(state);
      },
      builder: (context, state) {
        var c=AppCubit.get(context);
        if(state is LoginSuccessfulState)
          {
            c.homeData();
          }
        return Scaffold(
          backgroundColor: colors.Snow.toColor(),
            appBar: c.index==1||c.index==0?(
                c.index==1? AppBar(
                  backgroundColor: colors.darkMode?colors.Night.toColor():colors.Snow.toColor(),
              title: Text('My Courses',style: TextStyle(fontWeight: FontWeight.bold,color: colors.darkMode?colors.Jet.toColor():colors.Night.toColor()),),
              centerTitle: true,
              actions: [
                IconButton(onPressed: () {
                    showDialog(
                        context: context,
                        builder:(context) => AlertDialog(
                          backgroundColor: colors.Night.toColor(),
                          elevation: 20,
                          title: Text('Enter You\'r Course Code',style: TextStyle(color:colors.darkMode?colors.Jet.toColor():colors.Snow.toColor()),),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Etextfiled(hint: 'aKbc15s************',keyboard: TextInputType.text,icon: Icons.key,controller: keycontroller,
                                  vaild: (value) {
                                    if(value!.isEmpty||value==null)
                                    {
                                      return 'Please enter a valid email';
                                    }
                                    return null;
                                  }
                              ),
                              SizedBox(height: 20,),
                              Ebutton(text: 'confirm',isSecondColor: colors.darkMode,edo: (){

                                Navigator.pop(context);

                              }),
                            ],
                          ),
                          titleTextStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,),
                        )
                    );
                },
                    icon: Icon(Icons.add_circle_outline_sharp,color: colors.darkMode?colors.Jet.toColor():colors.Night.toColor(),),
                )
              ],
            ):AppBar(

                  backgroundColor: colors.Night.toColor(),
                  leading: IconButton(onPressed: () {
                    showSearch(
                        context: context,
                        delegate: MySearchDelegate()
                    );
                  }, icon: Icon(Icons.search,color: colors.darkMode?colors.Jet.toColor():colors.Snow.toColor(),)),
                  actions: [
                    IconButton(onPressed: (){
                      c.DarkMode();
                    }, icon: Icon(Icons.dark_mode,color: colors.darkMode?colors.Jet.toColor():colors.Snow.toColor(),))
                  ],
                )
            ):null,

            body: ConditionalBuilder(
              condition: state is! GetHomeDataState && state is! AppInitialState  ,
              builder: (context) => c.screens[c.index],
              fallback: (context) => Center(child: CircularProgressIndicator(color: Colors.black,backgroundColor: Colors.grey,),),),
            bottomNavigationBar:GNav(
                selectedIndex: c.index,
                onTabChange: (value) {
                  c.changeScreen(value);
                },
                backgroundColor: colors.darkMode?colors.Night.toColor(): colors.Jet.toColor(),
                tabBackgroundColor:colors.darkMode?colors.Snow.toColor():colors.Night.toColor(),
                padding: EdgeInsets.symmetric( vertical: 10,horizontal: 20),
                tabMargin: EdgeInsets.all(12),
                color: Colors.red,
                gap: 8,
                tabs: [
                  GButton(icon: Icons.home_filled,text:"Home",iconColor:colors.darkMode?colors.Jet.toColor():colors.Snow.toColor(),textColor: colors.darkMode?colors.Jet.toColor():colors.Snow.toColor(),iconActiveColor:colors.darkMode?colors.Jet.toColor():colors.Snow.toColor() ,),
                  GButton(icon: Icons.book,text: "My Courses",iconColor: colors.darkMode?colors.Jet.toColor():colors.Snow.toColor(),textColor: colors.darkMode?colors.Jet.toColor():colors.Snow.toColor(),iconActiveColor:colors.darkMode?colors.Jet.toColor():colors.Snow.toColor() ,),
                  GButton(icon: Icons.person,text: "Profile",iconColor: colors.darkMode?colors.Jet.toColor():colors.Snow.toColor(),textColor: colors.darkMode?colors.Jet.toColor():colors.Snow.toColor(),iconActiveColor:colors.darkMode?colors.Jet.toColor():colors.Snow.toColor() ,),
                ])
        );
      },
    );
  }
}
