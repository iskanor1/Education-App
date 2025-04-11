import 'package:ecommercey/screens/HomeScreen.dart';
import 'package:ecommercey/screens/MainScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../cubit/cubit.dart';
import '../cubit/states.dart';

class WebViewPaymentScreen extends StatelessWidget {
  WebViewPaymentScreen({
    required this.clientSecret,
    Key? key,
  }) : super(key: key);

  final String clientSecret;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
        listener: (context, state) {

        },
      builder: (context, state) {
        var c=AppCubit.get(context);
        return Scaffold(
          body: WebViewWidget(controller: WebViewController()
            ..setJavaScriptMode(JavaScriptMode.unrestricted)
            ..setNavigationDelegate(
              NavigationDelegate(
                onUrlChange: (change) async{
                  if(change.url!.startsWith('https://edu4u.my.canva.site/'))
                  {
                    await c.UserCoursesData().then((value) {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => Mainscreen()), // replace with your actual main screen
                            (route) => false,
                      );
                    },);
                  }
                },
                onProgress: (int progress) {
                  // Update loading bar.
                },
                onPageStarted: (String url) {
                },
                onPageFinished: (String url) {},
                onHttpError: (HttpResponseError error) {},
                onWebResourceError: (WebResourceError error) {},
                onNavigationRequest: (NavigationRequest request) {
                  if (request.url.startsWith('https://www.youtube.com/')) {
                    return NavigationDecision.prevent;
                  }
                  return NavigationDecision.navigate;
                },
              ),
            )..clearLocalStorage()
            ..clearCache()
            ..loadRequest(Uri.parse('https://accept.paymob.com/unifiedcheckout/?publicKey=egy_pk_test_6MVm7raxM60ZsljfDbzWeVlDtDpvBb19&clientSecret=$clientSecret'))),
        );
      },
    );
  }
}
