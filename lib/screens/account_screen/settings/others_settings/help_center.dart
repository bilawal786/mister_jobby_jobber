import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class HelpCenter extends StatefulWidget {
  const HelpCenter({Key? key}) : super(key: key);

  @override
  State<HelpCenter> createState() => _HelpCenterState();
}

class _HelpCenterState extends State<HelpCenter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Help_Center",
                style: Theme.of(context).textTheme.titleLarge,
              ).tr(),
              SizedBox(
                height: MediaQuery.of(context).size.width / 40,
              ),
              Text(
                "Help_Problem_Request",
                style: Theme.of(context).textTheme.titleSmall,
              ).tr(),
              SizedBox(
                height: MediaQuery.of(context).size.width / 40,
              ),
              ListTile(
                contentPadding: const EdgeInsets.only(
                    left: 0.0, bottom: 10.0, top: 10.0, right: 0.0),
                leading: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    // color: Colors.green,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image.asset(
                      'assets/images/appLogo.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                title: Text(
                  'Help_IKEA_Furniture',
                  style: Theme.of(context).textTheme.bodyMedium,
                ).tr(),
                subtitle: Text(
                  'Help_Day_Date',
                  style: Theme.of(context).textTheme.labelMedium,
                ).tr(),
                trailing: const Icon(
                  Icons.arrow_forward_ios_outlined,
                  size: 20,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width / 20,
              ),
              Text("Help_More_Request",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.blue,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Cerebri Sans Bold',
                  )).tr(),
              SizedBox(
                height: MediaQuery.of(context).size.width / 10,
              ),
              Text(
                "Help_Popular_Questions",
                style: Theme.of(context).textTheme.titleSmall,
              ).tr(),
              SizedBox(
                height: MediaQuery.of(context).size.width / 40,
              ),
              ListTile(
                title: Text(
                  "Help_Recurrent_Services",
                  style: Theme.of(context).textTheme.labelMedium,
                ).tr(),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                ),
              ),
              const Divider(),
              ListTile(
                title: Text(
                  "Help_Services_Request",
                  style: Theme.of(context).textTheme.labelMedium,
                ).tr(),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                ),
              ),
              const Divider(),
              ListTile(
                title: Text(
                  "Help_Chat_Jobber",
                  style: Theme.of(context).textTheme.labelMedium,
                ).tr(),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width / 40,
              ),
              Text(
                "Help_All_Topics",
                style: Theme.of(context).textTheme.titleSmall,
              ).tr(),
              ListTile(
                leading: Icon(
                  Icons.book_outlined,
                  size: 20,
                  color: Theme.of(context).primaryColor,
                ),
                title: Text(
                  "Help_Jobber_Live",
                  style: Theme.of(context).textTheme.labelMedium,
                ).tr(),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                ),
              ),
              const Divider(),
              ListTile(
                leading: Icon(
                  Icons.person_outline_outlined,
                  size: 20,
                  color: Theme.of(context).primaryColor,
                ),
                title: Text(
                  "Help_Your_Account",
                  style: Theme.of(context).textTheme.labelMedium,
                ).tr(),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                ),
              ),
              const Divider(),
              ListTile(
                leading: Icon(
                  Icons.request_quote_rounded,
                  size: 20,
                  color: Theme.of(context).primaryColor,
                ),
                title: Text(
                  "Help_Service_Request",
                  style: Theme.of(context).textTheme.labelMedium,
                ).tr(),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                ),
              ),
              const Divider(),
              ListTile(
                leading: Icon(
                  Icons.wallet,
                  size: 20,
                  color: Theme.of(context).primaryColor,
                ),
                title: Text(
                  "Help_Payment_Invoicing",
                  style: Theme.of(context).textTheme.labelMedium,
                ).tr(),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                ),
              ),
              const Divider(),
              ListTile(
                leading: Icon(
                  Icons.security_outlined,
                  size: 20,
                  color: Theme.of(context).primaryColor,
                ),
                title: Text(
                  "Help_Insurance_guarantees",
                  style: Theme.of(context).textTheme.labelMedium,
                ).tr(),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                ),
              ),
              const Divider(),
              ListTile(
                leading: Icon(
                  Icons.check_circle_outline,
                  size: 20,
                  color: Theme.of(context).primaryColor,
                ),
                title: Text(
                  "Help_Show_Cancellations",
                  style: Theme.of(context).textTheme.labelMedium,
                ).tr(),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width / 40,
              ),
              Text(
                "Help_Contact_Us",
                style: Theme.of(context).textTheme.titleMedium,
              ).tr(),
              SizedBox(
                height: MediaQuery.of(context).size.width / 40,
              ),
              ListTile(
                leading: Icon(
                  Icons.mail_outline,
                  size: 20,
                  color: Theme.of(context).primaryColor,
                ),
                title: Text(
                  "Help_Support_Requset",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.blue,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Cerebri Sans Bold',
                  ),
                ).tr(),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width / 40,
              ),
              Text(
                "Help_View_Support_Requset",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.blue,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'Cerebri Sans Bold',
                ),
              ).tr(),
            ],
          ),
        ),
      ),
    );
  }
}
