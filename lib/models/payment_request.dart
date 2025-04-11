class PaymentModel {
  late List<PaymentKey> paymentKeys=[];
  late String redirectionUrl;
  late int intentionOrderId;
  late String id;
  late IntentionDetail intentionDetail;
  late String clientSecret;
  late List<PaymentMethod> paymentMethods=[];
  late dynamic specialReference;
  late Extras extras;
  late bool confirmed;
  late String status;
  late DateTime created;
  late dynamic cardDetail;
  late List<dynamic> cardTokens=[];
  late String object;

   PaymentModel.fromJson(Map<String, dynamic> json) {
     json['payment_keys'].forEach((item){
       paymentKeys.add(PaymentKey.fromJson(item));
     });
      redirectionUrl= json['redirection_url'];
      intentionOrderId= json['intention_order_id'];
      id= json['id'];
      intentionDetail= IntentionDetail.fromJson(json['intention_detail']);
      clientSecret= json['client_secret'];
      paymentMethods= (json['payment_methods'] as List).map((e) => PaymentMethod.fromJson(e)).toList();
      specialReference= json['special_reference'];
      extras= Extras.fromJson(json['extras']);
      confirmed= json['confirmed'];
      status= json['status'];
      created= DateTime.parse(json['created']);
      cardDetail= json['card_detail'];
      cardTokens= json['card_tokens'];
      object= json['object'];
  }
}


class Extras {
  late CreationExtras creationExtras;
  late dynamic confirmationExtras;

   Extras.fromJson(Map<String, dynamic> json) {
      creationExtras = CreationExtras.fromJson(json['creation_extras']);
      confirmationExtras= json['confirmation_extras'];
  }
}

class CreationExtras {
  late String courseId;
  late String userId;
  late dynamic merchantOrderId;

  CreationExtras.fromJson(Map<String, dynamic> json) {
      courseId= json['courseId'];
      userId= json['userId'];
      merchantOrderId= json['merchant_order_id'];
  }
}

class IntentionDetail {
  late int amount;
  late List<dynamic> items=[];
  late String currency;
  late BillingData billingData;

   IntentionDetail.fromJson(Map<String, dynamic> json) {
      amount= json['amount'];
      items= json['items'];
      currency= json['currency'];
      billingData= BillingData.fromJson(json['billing_data']);
  }
}

class BillingData {
  late String apartment;
  late String floor;
  late String firstName;
  late String lastName;
  late String street;
  late String building;
  late String phoneNumber;
  late String shippingMethod;
  late String city;
  late String country;
  late String state;
  late String email;
  late String postalCode;

   BillingData.fromJson(Map<String, dynamic> json) {
      apartment= json['apartment'];
      floor= json['floor'];
      firstName= json['first_name'];
      lastName= json['last_name'];
      street= json['street'];
      building= json['building'];
      phoneNumber= json['phone_number'];
      shippingMethod= json['shipping_method'];
      city= json['city'];
      country= json['country'];
      state= json['state'];
      email= json['email'];
      postalCode= json['postal_code'];
  }
}

class PaymentKey {
  late int integration;
  late String key;
  late String gatewayType;
  late dynamic iframeId;
  late int orderId;
  late String redirectionUrl;
  late bool saveCard;


   PaymentKey.fromJson(Map<String, dynamic> json) {
      integration= json['integration'];
      key= json['key'];
      gatewayType= json['gateway_type'];
      iframeId=json['iframe_id'];
      orderId= json['order_id'];
      redirectionUrl= json['redirection_url'];
      saveCard= json['save_card'];
  }
}

class PaymentMethod {
  late int integrationId;
  late dynamic alias;
  late String name;
  late String methodType;
  late String currency;
  late bool live;
  late bool useCvcWithMoto;

   PaymentMethod.fromJson(Map<String, dynamic> json) {
      integrationId= json['integration_id'];
      alias= json['alias'];
      name= json['name'];
      methodType= json['method_type'];
      currency= json['currency'];
      live= json['live'];
      useCvcWithMoto= json['use_cvc_with_moto'];
  }
}

