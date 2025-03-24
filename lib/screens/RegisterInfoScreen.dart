import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:ecommercey/cubit/cubit.dart';
import 'package:ecommercey/cubit/states.dart';
import 'package:ecommercey/screens/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocketbase/pocketbase.dart';
import '../components/components.dart';
import '../components/const.dart';

class Registerinfoscreen extends StatefulWidget {
  final String email;
  final String password;
  final String repeatpassword;

  Registerinfoscreen({required this.email, required this.password, required this.repeatpassword,});

  @override
  State<Registerinfoscreen> createState() => _RegisterinfoscreenState();
}

class _RegisterinfoscreenState extends State<Registerinfoscreen> {
  var firstname=TextEditingController();
  var lastname=TextEditingController();
  var phone=TextEditingController();
  late var gender;
  var dob=TextEditingController();
  final _formKey=GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) => AppCubit(),
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context, state) {
          if (state is RegisterFailedState){
            EToast(context,textcolor: Colors.black,backgroundcolor: Colors.redAccent.shade100,text: 'There was an error!!');
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Loginscreen(),), (route) => false,);
          }
          if (state is RegisterSuccessfulState){
            EToast(context,textcolor: Colors.black,backgroundcolor: Colors.green.shade100,text: 'Please check your email for verification',icon: Icons.mark_email_read_outlined);
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Loginscreen(),), (route) => false,);
          }
        },
        builder: (context, state) {
          var c=AppCubit.get(context);
          return Scaffold(
            backgroundColor: colors.Snow.toColor(),
            appBar: state is! RegisterState ?AppBar(backgroundColor: colors.Snow.toColor(),leading: IconButton(onPressed: () => Navigator.pop(context), icon: Icon(Icons.arrow_back_ios,color: colors.Jet.toColor(),)),):null,
              body:ConditionalBuilder(
                condition: state is! RegisterState && state is! RegisterSuccessfulState,
                builder: (context) => SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(height: 40,),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Align(
                          alignment: AlignmentDirectional.topStart,
                          child: Text('''   Please enter your
   information''',style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold,color: colors.Jet.toColor()),),
                        ),
                      ),
                      SizedBox(height: 40,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: Etextfiled(icon: Icons.perm_identity,hint: 'First Name',controller: firstname,keyboard: TextInputType.name,vaild: (value) {
                          if(value == null || value.isEmpty||value.length>12)
                          {
                            return 'Please enter a valid name.';
                          }
                          return null;
                        },),
                      ),
                      SizedBox(height: 20,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: Etextfiled(icon: Icons.person,hint: 'Last Name',controller: lastname,keyboard: TextInputType.name,vaild: (value) {
                          if(value == null || value.isEmpty||value.length>12)
                          {
                            return 'Please enter a valid name.';
                          }
                          return null;
                        },),
                      ),
                      SizedBox(height: 20,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: Etextfiled(icon: Icons.phone,hint: 'Phone',controller: phone,keyboard: TextInputType.phone,vaild: (value) {
                          if (value == null || value.isEmpty||value.length>11) {
                            return 'phone length should be under 12 number';
                          }
                          return null;
                        },),
                      ),
                      SizedBox(height: 20,),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50),
                          child: TextFormField(
                            validator:(value) {
                              if(value == null || value.isEmpty)
                              {
                                return 'Please enter a valid date';
                              }
                            },
                            keyboardType: TextInputType.datetime,
                            style: TextStyle(color: Colors.black),
                            cursorColor: Colors.black,
                            controller: dob,
                            readOnly: true,
                            onTap: () async {
                              // Call selectDate and await the result
                              DateTime? selectedDate = await selectDate(context);

                              // Check if the user picked a date
                              if (selectedDate != null) {
                                // Format the date as a string and set it to the dob controller
                                dob.text = await selectedDate.toLocal().toString().split(" ")[0]; // Format as YYYY-MM-DD
                                print('${dob.text} --------------------------------------------');
                                // If using a StatefulWidget, you may call setState() here if necessary
                              }
                            },

                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.calendar_month),
                                filled: true,
                                fillColor: Colors.grey.shade300,
                                focusColor: Colors.grey.shade300,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(color: Colors.grey,width: 0),
                                ),
                                hintText: 'Date',
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(color: Colors.grey,width: 0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(color: Colors.grey,width: 0),
                                )
                            ),

                          )
                      ),
                      SizedBox(height: 40,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: Ebutton(text: 'Next',isSecondColor: colors.darkMode,edo:  ()async{

                          if(_formKey.currentState!.validate())
                          {
                            c.register(
                                fname: firstname.text,
                                lname: lastname.text,
                                email: widget.email,
                                password: widget.password,
                                passwordConfirm: widget.repeatpassword,
                                phone: phone.text,
                                dob: dob.text
                            );
                          }
                        }),
                      ),
                    ],
                  ),
                ),
              ),
                fallback: (context) => Loading(MainColor: colors.Persiangreen.toColor(),SecondColor: colors.TiffanyBlue.toColor(),)),
          );
        },
      ),
    );
  }
}
