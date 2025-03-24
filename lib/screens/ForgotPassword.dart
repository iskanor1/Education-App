import 'package:ecommercey/screens/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';
import '../Api/dio.dart';
import '../components/components.dart';
import '../components/const.dart';

class Forgotpassword extends StatelessWidget {
  const Forgotpassword({super.key});

  @override
  Widget build(BuildContext context) {
    final pb = PocketBase('https://mood-higher.pockethost.io');
    var email=TextEditingController();
    final _formKey=GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: colors.Snow.toColor(),
      appBar: AppBar(backgroundColor: colors.Snow.toColor(),leading: IconButton(onPressed: () => Navigator.pop(context), icon: Icon(Icons.arrow_back_ios,color: colors.Jet.toColor(),)),),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 100,),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Align(
                  alignment: AlignmentDirectional.topStart,
                  child: Text('''   Forgot your
   password?''',style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold,color: colors.Jet.toColor()),),
                ),
              ),
              SizedBox(height: 40,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Etextfiled(icon: Icons.email,hint: 'Email',controller: email,keyboard: TextInputType.emailAddress,vaild: (value) {
                  if(value!.isEmpty)
                  {
                    return 'Please enter a valid email';
                  }
                  return null;
                },),
              ),
              SizedBox(height: 40,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Ebutton(text: 'Next',isSecondColor: colors.darkMode,edo: ()async{
                  if(_formKey.currentState!.validate())
                    {
                      try{
                        await pb.collection('users').requestPasswordReset('${email.text}');
                        EToast(context,textcolor: Colors.black,backgroundcolor: Colors.green.shade100,text: 'Password Reset Email Has Been Sent.');
                        Navigator.pop(context);
                      }catch(e){
                        EToast(context,textcolor: Colors.black,backgroundcolor: Colors.red.shade100,text: 'there was an error!');
                        print(e);
                      }
                    }
                }),
              ),
              SizedBox(height: 20,),
              GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text('Never mind i remember now!',style: TextStyle(fontWeight: FontWeight.bold,color:  colors.Jet.withAlpha(0.6).toColor()),)
              ),
              SizedBox(height: 30,),
            ],
          ),
        ),
      ),
    );
  }
}
