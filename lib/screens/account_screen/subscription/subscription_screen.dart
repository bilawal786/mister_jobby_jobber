import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mister_jobby_jobber/providers/accounts_providers/subscription/subscription_provider.dart';

import 'package:provider/provider.dart';
import '../../../widgets/const_widgets/custom_button.dart';
import '../../web_view.dart';

class Subscription extends StatefulWidget {
  const Subscription({Key? key}) : super(key: key);

  @override
  State<Subscription> createState() => _SubscriptionState();
}

class _SubscriptionState extends State<Subscription> {
  var isInit = true;
  @override
  void didChangeDependencies() {
    if (isInit) {
      Provider.of<SubscriptionProvider>(context).getSubscriptionPlan(context);
      Provider.of<SubscriptionProvider>(context)
          .getRetrieveSubscription(context);
    }
    isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final subscriptionData =
        Provider.of<SubscriptionProvider>(context, listen: false);
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
          child: (extractSubscriptionData == null ||
                  subscriptionData.retrieveSubscription == null)
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                        child: Text(
                      'Subscription Plan',
                      style: Theme.of(context).textTheme.titleMedium,
                    ).tr(),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width / 40,
                    ),
                    Text(
                      'Chose a subscription plan to unlock all the functionality of application.',
                      style: Theme.of(context).textTheme.bodySmall,
                      textAlign: TextAlign.center,
                    ).tr(),
                    SizedBox(
                      height: MediaQuery.of(context).size.width / 40,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          'Offers:',
                          style: Theme.of(context).textTheme.bodySmall,
                          textAlign: TextAlign.center,
                        ).tr(),
                        SizedBox(
                          height: MediaQuery.of(context).size.width / 40,
                        ),
                        Text(
                          ' ${subscriptionData.retrieveSubscription!.remainingOffers} ',
                          style: Theme.of(context).textTheme.bodySmall,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width / 10,
                    ),
                    Consumer<SubscriptionProvider>(
                      builder: (context, value, child) => ListView.builder(
                        shrinkWrap: true,
                        itemCount: 3,
                        itemBuilder: (context, index) => GestureDetector(
                          onTap: () {
                            value.getPlanFunction(index, context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Container(
                              height: MediaQuery.of(context).size.width / 2.8,
                              padding:
                                  const EdgeInsets.only(left: 15, right: 15),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  // border: Border.all(color: (value.planValue == index) ? Colors.red: Colors.transparent),
                                  color: (index == 0)
                                      ? Colors.blue.shade300
                                      : (index == 1)
                                          ? Colors.deepPurple.shade300
                                          : Colors.green.shade300),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              (extractSubscriptionData[index]
                                                          .id ==
                                                      1)
                                                  ? extractSubscriptionData[
                                                          index]
                                                      .name
                                                  : (extractSubscriptionData[
                                                                  index]
                                                              .id ==
                                                          2)
                                                      ? extractSubscriptionData[
                                                              index]
                                                          .name
                                                      : extractSubscriptionData[
                                                              index]
                                                          .name,
                                              style: const TextStyle(
                                                fontSize: 22,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700,
                                                fontFamily: 'Cerebri Sans Bold',
                                              ),
                                            ),
                                            Text(
                                              (extractSubscriptionData[index]
                                                          .id ==
                                                      1)
                                                  ? "Offers you can get: 15"
                                                  : (extractSubscriptionData[
                                                                  index]
                                                              .id ==
                                                          2)
                                                      ? "You can get unlimited offers"
                                                      : "You can get unlimited offers",
                                              overflow: TextOverflow.visible,
                                              style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.white,
                                                fontFamily:
                                                    'Cerebri Sans reqular',
                                              ),
                                            ).tr(),
                                          ],
                                        ),
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
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
                                                    offset: const Offset(
                                                        0.0, -13.0),
                                                    child: const Text(
                                                      '€',
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontFamily:
                                                            'Cerebri Sans Bold',
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: (extractSubscriptionData[
                                                                  index]
                                                              .id ==
                                                          1)
                                                      ? extractSubscriptionData[
                                                              index]
                                                          .price
                                                      : (extractSubscriptionData[
                                                                      index]
                                                                  .id ==
                                                              2)
                                                          ? extractSubscriptionData[
                                                                  index]
                                                              .price
                                                          : extractSubscriptionData[
                                                                  index]
                                                              .price,
                                                ),
                                                WidgetSpan(
                                                  child: Transform.translate(
                                                    offset:
                                                        const Offset(-8.0, 5),
                                                    child: Text(
                                                      (extractSubscriptionData[
                                                                      index]
                                                                  .id ==
                                                              3)
                                                          ? 'yr'
                                                          : (extractSubscriptionData[
                                                                          index]
                                                                      .id ==
                                                                  2)
                                                              ? 'mo'
                                                              : "",
                                                      style: const TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontFamily:
                                                            'Cerebri Sans Bold',
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
                                  SizedBox(height: MediaQuery.of(context).size.width / 40,),
                                  if (int.parse(subscriptionData
                                          .retrieveSubscription!
                                          .activeSubscriptionId) ==
                                      extractSubscriptionData[index].id)
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0, vertical: 5.0),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        border: Border.all(
                                          color: Colors.white,
                                        ),
                                      ),
                                      child: Text(
                                        subscriptionData.retrieveSubscription!.subscriptionStatus,
                                        style: const TextStyle(
                                          fontSize: 22,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: 'Cerebri Sans Bold',
                                        ),
                                      ),
                                    )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width / 10,
                    ),
                    if (subscriptionData
                                .retrieveSubscription!.activeSubscriptionId ==
                            "2" ||
                        subscriptionData
                                .retrieveSubscription!.activeSubscriptionId ==
                            "3")
                      CustomButton(
                        onPress: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => WebView(
                                    url: subscriptionData.retrieveSubscription!
                                        .subscriptionPortal,
                                    title: subscriptionData
                                                .retrieveSubscription!
                                                .activeSubscriptionId ==
                                            "2"
                                        ? "Intermediate"
                                        : "Pro",
                                  )));
                        },
                        buttonName: 'View Subscription',
                      ),
                  ],
                ),
        ),
      ),
    );
  }
}
