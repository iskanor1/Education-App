import 'package:ecommercey/screens/LoginScreen.dart';
import 'package:ecommercey/screens/RegisterInfoScreen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../components/components.dart';
import '../components/const.dart';

class Registerscreem extends StatelessWidget {
  const Registerscreem({super.key});

  @override
  Widget build(BuildContext context) {
    var email=TextEditingController();
    var password=TextEditingController();
    var repeatpassword=TextEditingController();
    final _formKey=GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: colors.Snow.toColor(),
      appBar: AppBar(backgroundColor: colors.Snow.toColor(),leading: IconButton(onPressed: () => Navigator.pop(context), icon: Icon(Icons.arrow_back_ios,color: colors.Jet.toColor(),)),),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 40,),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Align(
                  alignment: AlignmentDirectional.topStart,
                  child: Text('''   Create your 
   Account''',style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold,color: colors.Jet.toColor()),),
                ),
              ),
              SizedBox(height: 40,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Etextfiled(icon: Icons.email,hint: 'Email',controller: email,keyboard: TextInputType.emailAddress,vaild: (value) {
                  if(value == null || value.isEmpty)
                  {
                    return 'Please enter a valid email';
                  }
                  return null;
                },),
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Etextfiled(icon: Icons.lock,hint: 'Password',controller: password,keyboard: TextInputType.visiblePassword,vaild: (value) {
                  if(value == null || value.isEmpty || value.length < 8)
                  {
                    return 'Please enter a password with at least 7 characters';
                  }
                  return null;
                },),
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Etextfiled(icon: Icons.lock_reset,hint: 'repeat password',controller: repeatpassword,keyboard: TextInputType.visiblePassword,vaild: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please re-enter your password';
                  } else if (value != password.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },),
              ),
              SizedBox(height: 40,),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Ebutton(text: 'Sign up',
                    isSecondColor:colors.darkMode,
                    edo:  (){
                  if(_formKey.currentState!.validate())
                  {
                    Navigator.push(context, DialogRoute(context: context, builder: (context) => Registerinfoscreen(
                      email: email.text,password: password.text,repeatpassword: repeatpassword.text,
                    ),));
                  }
                }),
              ),
              SizedBox(height: 30,),
              RichText(text: TextSpan(
                  children: [
                    TextSpan(text: 'Alrady have an account? ',
                      style: TextStyle(color: colors.Jet.withAlpha(0.6).toColor()),),
                    TextSpan(text: 'Sign in',
                        style: TextStyle(fontWeight: FontWeight.bold,color: colors.TiffanyBlue.toColor()),
                        recognizer: TapGestureRecognizer()..onTap=(){
                          Navigator.pop(context);
                        }
                    ),
                  ]
              )),
            ],
          ),
        ),
      ),
    );
  }
}
