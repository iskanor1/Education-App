import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../components/components.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart' show AppStates, BillingInformationFailedState, BillingInformationState, BillingInformationSuccessfulState;
import 'MainScreen.dart';

class BillingScreen extends StatelessWidget {

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController streetController = TextEditingController();
  final TextEditingController buildingController = TextEditingController();
  final TextEditingController floorController = TextEditingController();
  final TextEditingController apartmentController = TextEditingController();


  final String courseId;
  final double price;
  final String userId;
  final String userEmail;

  BillingScreen({
    required this.courseId,
    required this.price,
    required this.userId,
    required this.userEmail,
    Key? key,
  }) : super(key: key);

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
        return Scaffold(
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
                  containerWrapper([
                    customTextField("First Name", Icons.person, controller: firstNameController),
                    customTextField("Last Name", Icons.person, controller: lastNameController),
                    customTextField("Phone Number", Icons.phone, controller: phoneController),
                  ]),
                  sectionTitle("Shipping Address"),
                  containerWrapper([
                    customTextField("Country", Icons.public, controller: countryController),
                    customTextField("City", Icons.location_city, controller: cityController),
                    customTextField("State/Region", Icons.map, controller: stateController),
                    Row(
                      children: [
                        Expanded(child: customTextField("Street", Icons.streetview, controller: streetController)),
                        const SizedBox(width: 10),
                        Expanded(child: customTextField("Building", Icons.apartment, controller: buildingController)),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(child: customTextField("Floor", Icons.stairs, controller: floorController)),
                        const SizedBox(width: 10),
                        Expanded(child: customTextField("Apartment", Icons.home, controller: apartmentController)),
                      ],
                    ),
                  ]),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context, MaterialPageRoute(builder: (context) => Mainscreen()));
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.black,
                          padding: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 15),
                        ),
                        child:  Text("Cancel"),
                      ),
                      TextButton(
                        onPressed: () {

                        },
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.purple,
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
        );
      },
    );
  }
}