import 'package:ecommercey/Api/dio.dart';
import 'package:ecommercey/cubit/cubit.dart';
import 'package:ecommercey/screens/LoginScreen.dart';
import 'package:ecommercey/screens/billingscreen.dart';
import 'package:ecommercey/screens/pay_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components/const.dart';

void main() {
  DioHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          datePickerTheme: DatePickerThemeData(),
          progressIndicatorTheme: ProgressIndicatorThemeData(
            color: colors.Persiangreen.toColor(),
          ),

        ),
        home: BillingScreen(),
      ),
    );
  }
}
