import 'package:ecommercey/screens/WebViewPaymentScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../components/components.dart';
import '../components/const.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';
import 'MainScreen.dart';

class BillingScreen extends StatelessWidget {

  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var phoneController = TextEditingController();
  var countryController = TextEditingController();
  var cityController = TextEditingController();
  var stateController = TextEditingController();
  var streetController = TextEditingController();
  var buildingController = TextEditingController();
  var floorController = TextEditingController();
  var apartmentController = TextEditingController();


  final String courseId;
  final double price;
  BillingScreen({
    required this.courseId,
    required this.price,
    Key? key,
  }) : super(key: key);
  var _formKey =GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is BillingInformationSuccessfulState) {
          // Handle successful payment

        } else if (state is BillingInformationFailedState) {
          // Handle failed payment
        }
      },
      builder: (context, state) {
        var c=AppCubit.get(context);
        firstNameController.text=c.user!.record.first_name;
        lastNameController.text=c.user!.record.last_name;
        phoneController.text=c.user!.record.phone;
        countryController.text="Egypt";
        return Form(
          key: _formKey,
          child: Scaffold(
            appBar: AppBar(
              title: const Text(
                'Billing Information',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
              backgroundColor: Colors.white,
              elevation: 0,
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    sectionTitle("Personal Information"),
                    containerWrapper(
                      [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Etextfiled(hint: "First Name",icon: Icons.person,controller: firstNameController,keyboard: TextInputType.name,vaild: (value)
                        {
                          if(value!.isEmpty||value==null)
                          {
                            return 'Please enter a valid information';
                          }
                          return null;
                        },),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Etextfiled(hint: "Last Name",icon: Icons.person,controller:  lastNameController,keyboard: TextInputType.name,vaild: (value)
                        {
                          if(value!.isEmpty||value==null)
                          {
                            return 'Please enter a valid information';
                          }
                          return null;
                        },),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Etextfiled(hint: "Phone Number",icon: Icons.phone,controller:  phoneController,keyboard: TextInputType.phone,vaild: (value)
                        {
                          if(value!.isEmpty||value==null)
                          {
                            return 'Please enter a valid information';
                          }
                          return null;
                        },),
                      ),
                    ],),
                    sectionTitle("Shipping Address"),
                    containerWrapper([
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Etextfiled(hint: "Country",icon: Icons.public,controller:  countryController,keyboard: TextInputType.text,vaild: (value)
                        {
                          if(value!.isEmpty||value==null)
                          {
                            return 'Please enter a valid information';
                          }
                          return null;
                        },),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Etextfiled(hint: "City",icon: Icons.location_city,controller:  cityController,keyboard: TextInputType.text,vaild: (value)
                        {
                          if(value!.isEmpty||value==null)
                          {
                            return 'Please enter a valid information';
                          }
                          return null;
                        },),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Etextfiled(hint: "State/Region",icon: Icons.map,controller:  stateController,keyboard: TextInputType.text,vaild: (value)
                        {
                          if(value!.isEmpty||value==null)
                          {
                            return 'Please enter a valid information';
                          }
                          return null;
                        },),
                      ),
                      Row(
                        children: [
                          Expanded(child:Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Etextfiled(hint: "Street",icon: Icons.streetview,controller:  streetController,keyboard: TextInputType.text,vaild: (value)
                            {
                              if(value!.isEmpty||value==null)
                              {
                                return ' ';
                              }
                              return null;
                            },),
                          )),
                          const SizedBox(width: 10),
                          Expanded(child:Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Etextfiled(hint: "Building",icon: Icons.apartment,controller:  buildingController,keyboard: TextInputType.text,vaild: (value)
                            {
                              if(value!.isEmpty||value==null)
                              {
                                return ' ';
                              }
                              return null;
                            },),
                          )),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(child:Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Etextfiled(hint: "Floor",icon: Icons.stairs,controller:  floorController,keyboard: TextInputType.text,vaild: (value)
                            {
                              if(value!.isEmpty||value==null)
                              {
                                return ' ';
                              }
                              return null;
                            },),
                          )),
                          const SizedBox(width: 10),
                          Expanded(child:Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Etextfiled(hint: "Apartment",icon: Icons.home,controller:  apartmentController,keyboard: TextInputType.text,vaild: (value)
                            {
                              if(value!.isEmpty||value==null)
                              {
                                return ' ';
                              }
                              return null;
                            },),
                          )),
                        ],
                      ),
                    ]),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.black,
                            padding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 15),
                          ),
                          child:  Text("Cancel"),
                        ),
                        TextButton(
                          onPressed: () async{
                            if(_formKey.currentState!.validate()) {
                              await c.billingInformation(
                                fname: firstNameController.text,
                                lname: lastNameController.text,
                                phoneNumber: phoneController.text,

                                email: c.user!.record.email,
                                userId: c.user!.record.id,

                                courseId: courseId,
                                price: price,

                                country: countryController.text,
                                city: cityController.text,
                                state: stateController.text,
                                street: streetController.text,
                                Building: buildingController.text,
                                floor: floorController.text,
                                Apartment: apartmentController.text,
                              ).then((value) {
                                print(c.paymentModel!.clientSecret);
                                print(c.paymentModel!.id);
                                Navigator.push(context, MaterialPageRoute(builder: (context) => WebViewPaymentScreen(clientSecret: c.paymentModel!.clientSecret,),));
                              },);
                            }
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: colors.Persiangreen.toColor(),
                            padding:  EdgeInsets.symmetric(
                                horizontal: 30, vertical: 15),
                          ),
                          child: Text("Pay Now"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}