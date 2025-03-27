import 'package:flutter/material.dart';

import '../components/components.dart';

class BillingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Billing Information', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,

      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              sectionTitle("Personal Information"),
              containerWrapper([
                customTextField("First Name", Icons.person),
                customTextField("Last Name", Icons.person),
                customTextField("Phone Number", Icons.phone),
              ]),
              sectionTitle("Shipping Address"),
              containerWrapper([
                customTextField("Country", Icons.public),
                customTextField("City", Icons.location_city),
                customTextField("State/Region", Icons.map),
                Row(
                  children: [
                    Expanded(child: customTextField("Street", Icons.streetview)),
                    SizedBox(width: 10),
                    Expanded(child: customTextField("Building", Icons.apartment)),
                  ],
                ),
                Row(
                  children: [
                    Expanded(child: customTextField("Floor", Icons.stairs)),
                    SizedBox(width: 10),
                    Expanded(child: customTextField("Apartment", Icons.home)),
                  ],
                ),
              ]),
/////a
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                  onPressed: () {

                  },
              style: TextButton.styleFrom(
            foregroundColor: Colors.black,
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          ),
          child: Text("Cancel"),
        ),
         TextButton(
          onPressed: () {},
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.purple,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),),
                 child: Text("Pay Now"),
                 ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}