import 'package:flutter/material.dart';
import 'package:mister_jobby_jobber/providers/accounts_providers/subscription/subscription_provider.dart';
import 'package:provider/provider.dart';

import '../../../widgets/const_widgets/custom_button.dart';

class SubscriptionDetails extends StatelessWidget {
  final name;
  final price;
  final details;
  final fee;
  final createDate;
  final updateDate;
  final duration;

  const SubscriptionDetails({
    Key? key,
    this.name,
    this.price,
    this.details, this.fee, this.createDate, this.updateDate, this.duration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final subData = Provider.of<SubscriptionProvider>(context).subscriptionModel;

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
                              child: Text(
                                duration,
                                style:const TextStyle(
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
                  // Text(
                  //   "Fee ${fee}",
                  //   overflow: TextOverflow.visible,
                  //   style: const TextStyle(
                  //     fontSize: 18,
                  //     color: Colors.black,
                  //     fontFamily: 'Cerebri Sans Bold',
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: MediaQuery.of(context).size.width / 10,
                  // ),
                  // Column(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     Text(
                  //       "Create Date",
                  //       overflow: TextOverflow.visible,
                  //       style: const TextStyle(
                  //         fontSize: 18,
                  //         color: Colors.black,
                  //         fontFamily: 'Cerebri Sans Bold',
                  //       ),
                  //     ),
                  //     Text(
                  //       createDate,
                  //       overflow: TextOverflow.visible,
                  //       style: const TextStyle(
                  //         fontSize: 18,
                  //         color: Colors.black,
                  //         fontFamily: 'Cerebri Sans Bold',
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // SizedBox(
                  //   height: MediaQuery.of(context).size.width / 10,
                  // ),
                  // Column(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     const Text(
                  //       "Update Date",
                  //       overflow: TextOverflow.visible,
                  //       style: TextStyle(
                  //         fontSize: 18,
                  //         color: Colors.black,
                  //         fontFamily: 'Cerebri Sans Bold',
                  //       ),
                  //     ),
                  //     Text(
                  //       updateDate,
                  //       overflow: TextOverflow.visible,
                  //       style: const TextStyle(
                  //         fontSize: 18,
                  //         color: Colors.black,
                  //         fontFamily: 'Cerebri Sans Bold',
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // SizedBox(
                  //   height: MediaQuery.of(context).size.width / 10,
                  // ),
                  //
                  SizedBox(
                    height: MediaQuery.of(context).size.width / 1.2,
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
