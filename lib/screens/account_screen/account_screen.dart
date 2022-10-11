import 'package:flutter/material.dart';

import '../../helper/routes.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: mediaQuery.size.width / 10,
              ),
              Row(
                children: [
                  SizedBox(
                    width: mediaQuery.size.width / 7,
                  ),
                  SizedBox(
                    width: mediaQuery.size.width / 1.4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width / 3.5,
                          height: MediaQuery.of(context).size.width / 3.5,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.black38,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(200),
                            child: Image.network(
                              "https://burst.shopify.com/photos/person-holds-a-book-over-a-stack-and-turns-the-page/download",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: mediaQuery.size.width / 8,
                    height: mediaQuery.size.width / 3.5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () => Navigator.of(context).pushNamed(MyRoutes.SETTINGSCREENROUTE),
                          child: Container(
                            width: MediaQuery.of(context).size.width / 8.5,
                            height: MediaQuery.of(context).size.width / 8.5,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.black38,
                              ),
                            ),
                            child: const Icon(
                              Icons.settings,
                              size: 30,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: mediaQuery.size.width / 40,
              ),
              Text(
                "User Name",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(
                height: mediaQuery.size.width / 40,
              ),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    for (int i = 0; i < 5; i++)
                      const Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 14,
                      ),
                    SizedBox(
                      width: mediaQuery.size.width / 40,
                    ),
                    Text(
                      "5",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: mediaQuery.size.width / 40,
              ),
              Text(
                "0 notice",
                style: Theme.of(context).textTheme.labelSmall,
              ),
              SizedBox(
                height: mediaQuery.size.width / 20,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: mediaQuery.size.width / 2.2,
                      padding: const EdgeInsets.all(15.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.grey.shade50,
                      ),
                      child: Row(
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Icon(
                                Icons.account_balance_wallet_outlined,
                                size: 20,
                                color: Theme.of(context).primaryColor,
                              ),
                              SizedBox(
                                height: mediaQuery.size.width / 80,
                              ),
                              Text(
                                "0",
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              SizedBox(
                                height: mediaQuery.size.width / 80,
                              ),
                              Text(
                                "Wallet",
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                            ],
                          ),
                          const Spacer(),
                          const Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                            color: Colors.black,
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: mediaQuery.size.width / 2.2,
                      padding: const EdgeInsets.all(15.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.amber.shade50,
                      ),
                      child: Row(
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const Icon(
                                Icons.thumb_up_alt,
                                size: 20,
                                color: Colors.amber,
                              ),
                              SizedBox(
                                height: mediaQuery.size.width / 80,
                              ),
                              Text(
                                "0",
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              SizedBox(
                                height: mediaQuery.size.width / 80,
                              ),
                              Text(
                                "Reliability score",
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                            ],
                          ),
                          const Spacer(),
                          const Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                            color: Colors.black,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: mediaQuery.size.width / 20,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          "Action Required (1)",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.amber.shade100,
                          ),
                          child: const Icon(
                            Icons.circle_notifications,
                            color: Colors.amber,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: mediaQuery.size.width / 40,
                    ),
                    ListTile(
                      contentPadding: const EdgeInsets.all(10.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      dense: true,
                      tileColor: Colors.amber.shade100,
                      leading: const Icon(
                        Icons.circle_notifications,
                        color: Colors.black,
                      ),
                      title: Text(
                        "Incomplete profile",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      subtitle: Text(
                        "Please complete your profile to start offering your services.",
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.black,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}