import 'package:flutter/material.dart';

import '../../../widgets/const_widgets/custom_button.dart';

class SubscriptionDetails extends StatelessWidget {
  final name;
  final price;
  final details;
  const SubscriptionDetails({
    Key? key,
    this.name,
    this.price,
    this.details,
  }) : super(key: key);

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
          child: Card(
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
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
                            text: price,
                          ),
                          WidgetSpan(
                            child: Transform.translate(
                              offset: const Offset(-8.0, 5),
                              child: const Text(
                                'mo',
                                style: TextStyle(
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
                    name,
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
                    details,
                    overflow: TextOverflow.visible,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontFamily: 'Cerebri Sans Bold',
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width / 40,
                  ),

                  SizedBox(
                    height: MediaQuery.of(context).size.width / 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    Icon(Icons.check, color: Colors.black,),
                    SizedBox(width: MediaQuery.of(context).size.width / 40),
                    Text('Unlimited Jobs', style: Theme.of(context).textTheme.bodyMedium,),
                  ],),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    Icon(Icons.check, color: Colors.black,),
                    SizedBox(width: MediaQuery.of(context).size.width / 40),
                    Text('Groth Oriented', style: Theme.of(context).textTheme.bodyMedium,),
                  ],),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,children: [
                    Icon(Icons.check, color: Colors.black,),
                    SizedBox(width: MediaQuery.of(context).size.width / 40),
                    Text('Email Support', style: Theme.of(context).textTheme.bodyMedium,),
                  ],),
                  SizedBox(
                    height: MediaQuery.of(context).size.width / 2,
                  ),
                  CustomButton(onPress: () {}, buttonName: 'Buy Now'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
