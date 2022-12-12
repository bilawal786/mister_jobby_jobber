import 'package:flutter/material.dart';
import 'package:mister_jobby_jobber/providers/accounts_providers/subscription/subscription_provider.dart';
import 'package:mister_jobby_jobber/providers/mandatory_steps_provider/personal_information_provider/personal_information_provider.dart';
import 'package:provider/provider.dart';

import '../../../widgets/const_widgets/custom_button.dart';

class SubscriptionDetails extends StatefulWidget {
  final String planId;
  final int subId;
  final String name;
  final String price;
  final String details;
  final String duration;

  const SubscriptionDetails({
    Key? key,
    required this.planId,
    required this.subId,
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
    final subscriptionData = Provider.of<SubscriptionProvider>(context,listen: false);
    final profileData = Provider.of<PersonalInformationProvider>(context, listen: false);
    final extractedProfile = profileData.profile;
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
                                '€',
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
                    height: MediaQuery.of(context).size.width / 0.8,
                  ),
                  CustomButton(onPress: (){
                    subscriptionData.bookSubscriptionPlan(context, widget.planId, extractedProfile!.jobberId, widget.subId, widget.name);
                  },
                      buttonName: 'Buy Now') ,
                ],
              ),
            ),
        ),
      ),
    );
  }
}
