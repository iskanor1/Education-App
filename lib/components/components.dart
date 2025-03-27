import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

import 'const.dart';

Widget Etextfiled({required hint,required icon,required controller,required TextInputType keyboard,obscure=false, required String? Function(String?) vaild,})=>Theme(
  data: ThemeData(
      textSelectionTheme: TextSelectionThemeData(
          selectionColor: Colors.grey.shade500
      )
  ),
  child: TextFormField(
    obscureText: obscure,
    validator:vaild,
    keyboardType: keyboard,
    style: TextStyle(color: Colors.black),
    cursorColor: Colors.black,
    controller: controller,
    decoration: InputDecoration(
        prefixIcon: Icon(icon),
        filled: true,
        fillColor: Colors.grey.shade300,
        focusColor: Colors.grey.shade300,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Colors.grey,width: 0),
        ),
        hintText: '$hint',
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Colors.grey,width: 0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Colors.grey,width: 0),
        )
    ),

  ),
);

Widget Ebutton({required text,required edo,required isSecondColor,fontsize=20.0})=>Container(
  height: 50,
  width: double.infinity,
  child: TextButton(
    onPressed: () {
      edo();
    },
    child: Text('$text',style: TextStyle(color: Colors.white,fontSize:fontsize ),),
    style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(colors.Persiangreen.toColor())),
  ),
);

EToast(context,{required textcolor,backgroundcolor=Colors.white,required text,var icon=Icons.mail_lock})=>toastification.show(
  context: context, // optional if you use ToastificationWrapper
  backgroundColor: backgroundcolor,
  title: Text(text,style: TextStyle(color: textcolor),),
  icon: Icon(icon,color: Colors.black.withAlpha(200),),
  autoCloseDuration: const Duration(seconds: 5),
);

Widget VideoCard(context,String image)=>Card(
  color: Colors.black.withOpacity(0.7),
  elevation: 15,
  margin: EdgeInsets.all(10),
  clipBehavior: Clip.hardEdge,
  child:  Container(
    height: 290,
    width: 290,
    child: Image.network(image,
      fit: BoxFit.cover, // Makes the image cover the entire container
      height: double.infinity, // Ensures the image fills the height of the container
      width: double.infinity, // Ensures the image fills the width of the container
    ),
  )
);

Future<DateTime?> selectDate(BuildContext context) async {
  DateTime? _picked = await showDatePicker(
    context: context,
    firstDate: DateTime(1900),
    lastDate: DateTime.now(),
    initialDate: DateTime.now(),
  );

  return _picked; // No need to await here
}


class MySearchDelegate extends SearchDelegate{

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.black, // Set the background color of the app bar
        elevation: 1, // Add or remove the shadow
        iconTheme: IconThemeData(
          color: Colors.white, // Set the color for app bar icons
        ),
        titleTextStyle: TextStyle(
          color: Colors.white, // Set the color for the title
          fontSize: 18, // Set the font size for the title
        ),

      ),
      textTheme: TextTheme(
        bodyLarge: TextStyle(color: Colors.white)
      ),
      textSelectionTheme: TextSelectionThemeData(
        selectionColor: Colors.grey,
        cursorColor: Colors.white,
        selectionHandleColor: Colors.grey,
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: InputBorder.none, // Customize the search field's border
        hintStyle: TextStyle(
          color: Colors.grey, // Set the hint text color
          fontSize: 16,
        ),
      ),
    );
  }

  @override
  Widget? buildLeading(BuildContext context)=>IconButton(
      onPressed: () => close(context,null),
      icon: Icon(Icons.arrow_back_ios_new,color: Colors.white,));

  @override
  List<Widget>? buildActions(BuildContext context)=>[
  IconButton(
  onPressed: () {
  query='';
  },
  icon: Icon(Icons.clear,color: Colors.white,)
  )
  ];

  @override
  Widget buildResults(BuildContext context) =>Container(
    child: Text(
      query,style: TextStyle(color: Colors.black),
    ),
  );

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestions=[
      'C++',
      'Flutter',
      'Python',
      'C#',
      "Art"
    ];
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index){
        final suggestion=suggestions[index];
        return ListTile(
          title: Text(suggestion),
          onTap: () {
            query=suggestion;
            showResults(context);
          },
        );
      },
    );
  }

}

Widget Loading({MainColor=Colors.black,SecondColor=Colors.grey}) {
  return Center(child: CircularProgressIndicator(color: MainColor,backgroundColor: SecondColor,),);
}

Widget sectionTitle(String title) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Text(
      title,
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    ),
  );
}

Widget containerWrapper(List<Widget> children) {
  return Container(
    padding: EdgeInsets.all(10),
    margin: EdgeInsets.symmetric(vertical: 8),
    decoration: BoxDecoration(
      color: Colors.purple.shade50,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(children: children),
  );
}

TextField customTextField(String label, IconData icon, {required TextEditingController controller}) {
  return TextField(
    controller: controller,
    decoration: InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon),
      border: OutlineInputBorder(),
    ),
  );
}
