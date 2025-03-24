import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:ecommercey/cubit/cubit.dart';
import 'package:ecommercey/cubit/states.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../components/components.dart';
import '../components/const.dart';
import 'ForgotPassword.dart';
import 'MainScreen.dart';
import 'RegisterScreem.dart';

class Loginscreen extends StatelessWidget {
  const Loginscreen({super.key});
  @override
  Widget build(BuildContext context) {
    var email=TextEditingController();
    var password=TextEditingController();
    final _formKey=GlobalKey<FormState>();
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {
        print(state);
        if (state is LoginFailedState){
          EToast(context,textcolor: Colors.black,backgroundcolor: Colors.redAccent.shade100,text: 'Invalid Email or Password.');
        }
        if (state is LoginSuccessfulState){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Mainscreen(),));
        }
      },
      builder: (context, state) {
        var c=AppCubit.get(context);
        return  Scaffold(
          backgroundColor: colors.Snow.toColor(),
          appBar: state is! LoginState ?AppBar( backgroundColor: colors.Snow.toColor()):null,
          body: ConditionalBuilder(
              condition: state is! LoginState && state is! LoginSuccessfulState && state is! GetUserCoursesDataSuccessfulState && state is! GetHomeDataSuccessfulState && state is! GetUserCoursesDataState,
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
                          child: Text('''   Login to your
   Account''',style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold,color: colors.Jet.toColor()),),
                        ),
                      ),
                      SizedBox(height: 40,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: Etextfiled(icon: Icons.email,hint: 'Email',controller: email,keyboard: TextInputType.emailAddress,
                          vaild: (value) {
                            if(value!.isEmpty||value==null)
                            {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },),
                      ),
                      SizedBox(height: 20,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: Etextfiled(icon: Icons.lock,hint: 'Password',controller: password,obscure: true,keyboard: TextInputType.visiblePassword,vaild: (value) {
                          if(value!.isEmpty||value==null)
                          {
                            return 'Please enter a valid Password';
                          }
                          return null;
                        },),
                      ),
                      SizedBox(height: 40,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: Ebutton(text: 'Login',isSecondColor: colors.darkMode ,edo: (){
                          if(_formKey.currentState!.validate())
                          {
                            c.login(email.text.toString(), password.text.toString());
                          }
                        }),
                      ),
                      SizedBox(height: 20,),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Forgotpassword(),));
                          },
                          child: Text('Forgot the password?',style: TextStyle(fontWeight: FontWeight.bold,color: colors.Jet.withAlpha(0.6).toColor()),)
                      ),
                      SizedBox(height: 30,),
                      RichText(text: TextSpan(
                          children: [
                            TextSpan(text: 'Don\'t have an account? ',
                              style: TextStyle(color: colors.Jet.toColor()),
                            ),
                            TextSpan(text: 'Sign up',
                                style: TextStyle(fontWeight: FontWeight.bold,color: colors.TiffanyBlue.toColor()),
                                recognizer: TapGestureRecognizer()..onTap=(){
                                   Navigator.push(context, MaterialPageRoute(builder: (context) => Registerscreem(),));
                                }
                            ),
                          ]
                      )),
                    ],
                  ),
                ),
              ),
              fallback: (context) => Loading(MainColor: colors.Persiangreen.toColor(),SecondColor: colors.TiffanyBlue.toColor(),),
          ),
        );
      },
    );
  }
}
