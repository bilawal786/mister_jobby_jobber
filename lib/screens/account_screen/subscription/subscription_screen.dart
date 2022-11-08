import 'package:flutter/material.dart';
import 'package:mister_jobby_jobber/providers/accounts_providers/subscription/subscription_provider.dart';
import 'package:mister_jobby_jobber/widgets/const_widgets/custom_button.dart';
import 'package:provider/provider.dart';

import '../../../models/subscription/subscription_model.dart';
import 'subscription_details_screen.dart';

class Subscription extends StatelessWidget {
  const Subscription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final subscriptionData = Provider.of<SubscriptionProvider>(context);
    final extractSubscriptionData = subscriptionData.subscriptionModel;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                  child: Text(
                'Subscription Plan',
                style: Theme.of(context).textTheme.titleMedium,
              )),
              SizedBox(
                height: MediaQuery.of(context).size.width / 40,
              ),
              Text(
                'Chose a subscription plan to unlock all the functionality of application.',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width / 10,
              ),
              Consumer<SubscriptionProvider>(builder: (context, value, child) => ListView.builder(
                shrinkWrap: true,
                itemCount: 3,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: (){
                    value.getPlanFunction(index, context);
                                      },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Container(
                      height: MediaQuery.of(context).size.width /2.8,
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          // border: Border.all(color: (value.planValue == index) ? Colors.red: Colors.transparent),
                          color: (index == 0) ? Colors.blue.shade300 : (index == 1) ? Colors.deepPurple.shade300 : Colors.green.shade300),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:  <Widget>[
                                Text(
                                    (extractSubscriptionData?[index].id == 1) ?
                                    extractSubscriptionData![index].name
                                        : (extractSubscriptionData?[index].id == 2) ?
                                    extractSubscriptionData![index].name :
                                    extractSubscriptionData![index].name
                                    ,
                                  style: const TextStyle(
                                    fontSize: 22,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Cerebri Sans Bold',
                                  ),
                                ),
                                Text(
                                  (extractSubscriptionData[index].id == 1) ?
                                  "Offers you can get: ${extractSubscriptionData[index].offers}"
                                      : (extractSubscriptionData[index].id == 2) ?
                                  "You can get ${extractSubscriptionData[index].offers} offers" :
                                  "You can get ${extractSubscriptionData[index].offers} offers"
                                  ,
                                  overflow: TextOverflow.visible,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.white,
                                    fontFamily: 'Cerebri Sans reqular',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              RichText(
                                text: TextSpan(
                                  style: const TextStyle(
                                    fontSize: 22,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Cerebri Sans Bold',
                                  ),
                                  children: [
                                    WidgetSpan(
                                      child: Transform.translate(
                                        offset: const Offset(0.0, -13.0),
                                        child: const Text(
                                          '\€',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                            fontFamily: 'Cerebri Sans Bold',
                                          ),
                                        ),
                                      ),
                                    ),
                                     TextSpan(
                                      text: (extractSubscriptionData[index].id == 1) ?
                                      extractSubscriptionData[index].price
                                            : (extractSubscriptionData[index].id == 2) ?
                                      extractSubscriptionData[index].price :
                                      extractSubscriptionData[index].price
                                            ,),
                                    WidgetSpan(
                                      child: Transform.translate(
                                        offset: const Offset(-8.0, 5),
                                        child: Text(
                                          (extractSubscriptionData[index].id == 3) ?
                                              'yr' :
                                          (extractSubscriptionData[index].id == 2) ? 'mo' :
                                           "",

                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                            fontFamily: 'Cerebri Sans Bold',
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              ),
              // SizedBox(
              //   height: MediaQuery.of(context).size.width / 40,
              // ),
              // InkWell(
              //   child: Container(
              //     height: MediaQuery.of(context).size.width /2.8,
              //     padding: const EdgeInsets.only(left: 15, right: 15),
              //     decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(5),
              //         color: Colors.deepPurple),
              //     child: Row(
              //       crossAxisAlignment: CrossAxisAlignment.center,
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Flexible(
              //           child: Column(
              //             crossAxisAlignment: CrossAxisAlignment.start,
              //             mainAxisAlignment: MainAxisAlignment.center,
              //             children: const <Widget>[
              //               Text(
              //                 'Yearly',
              //                 style: TextStyle(
              //                   fontSize: 22,
              //                   color: Colors.white,
              //                   fontWeight: FontWeight.w700,
              //                   fontFamily: 'Cerebri Sans Bold',
              //                 ),
              //               ),
              //               Text(
              //                 'You can pay in installment',
              //                 overflow: TextOverflow.visible,
              //                 style: TextStyle(
              //                   fontSize: 18,
              //                   color: Colors.white,
              //                   fontFamily: 'Cerebri Sans Bold',
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ),
              //         Column(
              //           mainAxisAlignment: MainAxisAlignment.center,
              //           crossAxisAlignment: CrossAxisAlignment.center,
              //           children: [
              //             RichText(
              //               text: TextSpan(
              //                 style: const TextStyle(
              //                   fontSize: 22,
              //                   color: Colors.white,
              //                   fontWeight: FontWeight.w700,
              //                   fontFamily: 'Cerebri Sans Bold',
              //                 ),
              //                 children: [
              //                   WidgetSpan(
              //                     child: Transform.translate(
              //                       offset: const Offset(0.0, -13.0),
              //                       child: const Text(
              //                         '\$',
              //                         style: TextStyle(
              //                           fontSize: 16,
              //                           color: Colors.white,
              //                           fontWeight: FontWeight.w700,
              //                           fontFamily: 'Cerebri Sans Bold',
              //                         ),
              //                       ),
              //                     ),
              //                   ),
              //                   const TextSpan(
              //                     text: '10.99 ',
              //                   ),
              //                   WidgetSpan(
              //                     child: Transform.translate(
              //                       offset: const Offset(-8.0, 5),
              //                       child: const Text(
              //                         'mo',
              //                         style: TextStyle(
              //                           fontSize: 12,
              //                           color: Colors.white,
              //                           fontWeight: FontWeight.w700,
              //                           fontFamily: 'Cerebri Sans Bold',
              //                         ),
              //                       ),
              //                     ),
              //                   ),
              //                 ],
              //               ),
              //             ),
              //           ],
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   height: MediaQuery.of(context).size.width / 40,
              // ),
              // InkWell(
              //   child: Container(
              //     height: MediaQuery.of(context).size.width /2.8,
              //     padding: const EdgeInsets.only(left: 15, right: 15),
              //     decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(5),
              //         color: Colors.green.shade400),
              //     child: Row(
              //       crossAxisAlignment: CrossAxisAlignment.center,
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Flexible(
              //           child: Column(
              //             crossAxisAlignment: CrossAxisAlignment.start,
              //             mainAxisAlignment: MainAxisAlignment.center,
              //             children: const <Widget>[
              //               Text(
              //                 'Monthly',
              //                 style: TextStyle(
              //                   fontSize: 22,
              //                   color: Colors.white,
              //                   fontWeight: FontWeight.w700,
              //                   fontFamily: 'Cerebri Sans Bold',
              //                 ),
              //               ),
              //               Text(
              //                 'You can pay in installment',
              //                 overflow: TextOverflow.visible,
              //                 style: TextStyle(
              //                   fontSize: 18,
              //                   color: Colors.white,
              //                   fontFamily: 'Cerebri Sans Bold',
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ),
              //         Column(
              //           mainAxisAlignment: MainAxisAlignment.center,
              //           crossAxisAlignment: CrossAxisAlignment.center,
              //           children: [
              //             RichText(
              //               text: TextSpan(
              //                 style: const TextStyle(
              //                   fontSize: 22,
              //                   color: Colors.white,
              //                   fontWeight: FontWeight.w700,
              //                   fontFamily: 'Cerebri Sans Bold',
              //                 ),
              //                 children: [
              //                   WidgetSpan(
              //                     child: Transform.translate(
              //                       offset: const Offset(0.0, -13.0),
              //                       child: const Text(
              //                         '\$',
              //                         style: TextStyle(
              //                           fontSize: 16,
              //                           color: Colors.white,
              //                           fontWeight: FontWeight.w700,
              //                           fontFamily: 'Cerebri Sans Bold',
              //                         ),
              //                       ),
              //                     ),
              //                   ),
              //                   const TextSpan(
              //                     text: '5.99 ',
              //                   ),
              //                   WidgetSpan(
              //                     child: Transform.translate(
              //                       offset: const Offset(-8.0, 5),
              //                       child: const Text(
              //                         'mo',
              //                         style: TextStyle(
              //                           fontSize: 12,
              //                           color: Colors.white,
              //                           fontWeight: FontWeight.w700,
              //                           fontFamily: 'Cerebri Sans Bold',
              //                         ),
              //                       ),
              //                     ),
              //                   ),
              //                 ],
              //               ),
              //             ),
              //           ],
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   height: MediaQuery.of(context).size.width / 40,
              // ),

            ],
          ),
        ),
      ),
    );
  }
}
