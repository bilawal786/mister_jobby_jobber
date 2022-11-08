import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:mister_jobby_jobber/providers/accounts_providers/subscription/subscription_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../../widgets/const_widgets/custom_button.dart';

class SubscriptionDetails extends StatefulWidget {
  final String name;
  final String price;
  final String details;
  final String duration;

  const SubscriptionDetails({
    Key? key,
    required this.name,
    required this.price,
    required this.details,
    required this.duration,
  }) : super(key: key);

  @override
  State<SubscriptionDetails> createState() => _SubscriptionDetailsState();
}

class _SubscriptionDetailsState extends State<SubscriptionDetails> {

  Map<String, dynamic>? paymentIntentData;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child:
           Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          fontSize: 36,
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Cerebri Sans Bold',
                        ),
                        children: [
                          WidgetSpan(
                            child: Transform.translate(
                              offset: const Offset(0.0, -15.0),
                              child: const Text(
                                '\€',
                                style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Cerebri Sans Bold',
                                ),
                              ),
                            ),
                          ),
                          TextSpan(
                            text: widget.price.toString(),
                          ),
                          WidgetSpan(
                            child: Transform.translate(
                              offset: const Offset(-8.0, 5),
                              child: Text(
                                widget.duration,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Cerebri Sans Bold',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width / 10,
                  ),
                  Text(
                    widget.name,
                    style: const TextStyle(
                      fontSize: 22,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Cerebri Sans Bold',
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width / 40,
                  ),
                  Text(
                    widget.details,
                    overflow: TextOverflow.visible,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontFamily: 'Cerebri Sans Bold',
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width / 1.2,
                  ),
                  CustomButton(onPress: () async{
                    (double.parse(widget.price) < 1) ?
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("paid successfully"))):await makePayment();}, buttonName: 'Buy Now'),
                ],
              ),
            ),
        ),
      ),
    );
  }

  Future<void> makePayment() async {
  var amount = double.parse(widget.price);
    try {
      paymentIntentData =
      await createPaymentIntent(amount, 'eur');
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: paymentIntentData!['client_secret'],
              merchantDisplayName: 'Jobber')).then((value){
      });

    displayPaymentSheet();
    } catch (e, s) {
      print('exception:$e$s');
    }
  }

  displayPaymentSheet() async {

    try {
      await Stripe.instance.presentPaymentSheet(
          parameters: PresentPaymentSheetParameters(
            clientSecret: paymentIntentData!['client_secret'],
            confirmPayment: true,
          )).then((newValue){

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("paid successfully")));

        paymentIntentData = null;

      }).onError((error, stackTrace){
        print('Exception/DISPLAYPAYMENTSHEET==> $error $stackTrace');
      });

    } on StripeException catch (e) {
      print('Exception/DISPLAYPAYMENTSHEET==> $e');
      // showDialog(
      //     context: context,
      //     builder: (_) => AlertDialog(
      //       content: Text("Cancelled "),
      //     ));
    } catch (e) {
      print('$e');
    }
  }

  createPaymentIntent(double amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card'
      };
      print(body);
      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization':
            'Bearer sk_test_51LRubcLtkEa5U40QApwIt13tNTcs9x2v95PKmJjoZ57xvfMf1PaPH0hYB556mGLJyhFDniqtEBRQbbDAY4wtmFE500xuKSA0Qb',
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      print('Create Intent reponse ===> ${response.body.toString()}');
      return jsonDecode(response.body);
    } catch (err) {
      print('err charging user: ${err.toString()}');
    }
  }

  calculateAmount(double amount) {
    final a = (amount * 100).toInt() ;
    return a.toString();
  }
}
