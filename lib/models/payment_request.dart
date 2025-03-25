class PaymentModel {
  late int amount;
  late String currency;
  late List<int> paymentMethods;
  late List<Items> items;
  late BillingData? billingData;
  late Extras? extras;
  late int expiration;
  late String notificationUrl;
  late String redirectionUrl;

  PaymentModel.fromJson(Map<String, dynamic> json) {
    amount = json["amount"];
    currency = json["currency"];
    paymentMethods = List<int>.from(json["payment_methods"]);
    items = [];
    json['items'].forEach((item) {
      items.add(Items.fromJson(item));
    });
    billingData = json['billing_data'] != null ? BillingData.fromJson(json['billing_data']) : null;
    extras = json['extras'] != null ? Extras.fromJson(json['extras']) : null;
    expiration = json["expiration"];
    notificationUrl = json["notification_url"];
    redirectionUrl = json["redirection_url"];
  }
}

class Items {
  late String? name;
  late int? amount;
  late String? description;
  late int? quantity;

  Items.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    amount = json["amount"];
    description = json["description"];
    quantity = json["quantity"];
  }
}

class BillingData {
  late String apartment;
  late String firstName;
  late String lastName;
  late String street;
  late String building;
  late String phoneNumber;
  late String city;
  late String country;
  late String email;
  late String floor;
  late String state;

  BillingData.fromJson(Map<String, dynamic> json) {
    apartment = json["apartment"];
    firstName = json["first_name"];
    lastName = json["last_name"];
    street = json["street"];
    building = json["building"];
    phoneNumber = json["phone_number"];
    city = json["city"];
    country = json["country"];
    email = json["email"];
    floor = json["floor"];
    state = json["state"];
  }
}

class Extras {
  late int ee;

  Extras.fromJson(Map<String, dynamic> json) {
    ee = json["ee"];
  }
}