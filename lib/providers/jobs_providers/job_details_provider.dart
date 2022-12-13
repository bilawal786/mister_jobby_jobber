import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:mister_jobby_jobber/screens/home_screens/home_tab_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../helper/routes.dart';

import '../../widgets/const_widgets/custom_button.dart';
import '../../widgets/const_widgets/progress_indicator.dart';
import 'available_jobs_provider/available_jobs_provider.dart';

class JobsDetailProvider with ChangeNotifier {
  int? postId;
  int fixedRate = 0;
  double fixedHours = 0;
  int? hourlyRate;
  double? hours;

  void decreaseHours() {
    if (hours! > fixedHours) {
      hours = hours! - 0.5;
    }
    notifyListeners();
  }

  void increaseHours() {
    hours = hours! + 0.5;
    notifyListeners();
  }

  void decreaseHourlyRate() {
    if (hourlyRate! > fixedRate) {
      hourlyRate = hourlyRate! - 1;
    }
    notifyListeners();
  }

  void increaseHourlyRate() {
    hourlyRate = hourlyRate! + 1;
    notifyListeners();
  }

  showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: .7,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(5),
                        width: MediaQuery.of(context).size.width / 1.5,
                        child: Text(
                          "Send Your Proposal",
                          style: Theme.of(context).textTheme.titleSmall,
                        ).tr(),
                      ),
                      const Spacer(),
                      GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: const Icon(
                            Icons.cancel,
                            size: 25,
                            color: Colors.black,
                          )),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width / 40,
                  ),
                  const Divider(),
                  SizedBox(
                    height: MediaQuery.of(context).size.width / 20,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text("Adjust your hourly rate",style: Theme.of(context).textTheme.bodyLarge),
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          decreaseHourlyRate();
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.black12,
                            ),
                            color: Colors.white,
                          ),
                          child: const Icon(
                            Icons.remove,
                            color: Colors.black,
                            size: 20,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 80,
                      ),
                      Consumer<JobsDetailProvider>(
                        builder: (_, modalSheet, child) => SizedBox(
                          width: MediaQuery.of(context).size.width / 10,
                          child: Text(
                            "${modalSheet.hourlyRate}",
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 80,
                      ),
                      InkWell(
                        onTap: () {
                          increaseHourlyRate();
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.black12,
                            ),
                            color: Colors.black,
                          ),
                          child: const Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width / 20,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text("Adjust your hours", style: Theme.of(context).textTheme.bodyLarge,),
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          decreaseHours();
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.black12,
                            ),
                            color: Colors.white,
                          ),
                          child: const Icon(
                            Icons.remove,
                            color: Colors.black,
                            size: 20,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 80,
                      ),
                      Consumer<JobsDetailProvider>(
                        builder: (_, modalSheet, child) => SizedBox(
                          width: MediaQuery.of(context).size.width / 10,
                          child: Text(
                            "${modalSheet.hours}",
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 80,
                      ),
                      InkWell(
                        onTap: () {
                          increaseHours();
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.black12,
                            ),
                            color: Colors.black,
                          ),
                          child: const Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width / 40,
                  ),
                  const Divider(),
                  SizedBox(
                    height: MediaQuery.of(context).size.width / 20,
                  ),
                  Text(
                    "Initial Duration",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ).tr(),
                  SizedBox(
                    height: MediaQuery.of(context).size.width / 40,
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        "Additional hours may be added.",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const Spacer(),
                      Consumer<JobsDetailProvider>(
                        builder:(_,modalSheet,child) => Text(
                          "${modalSheet.hours!} hours",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width / 40,
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        "Total Compensation",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ).tr(),
                      const Spacer(),
                      Consumer<JobsDetailProvider>(
                        builder: (_, modalSheet, child) => Text(
                          "${modalSheet.hourlyRate! * modalSheet.hours!} €",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width / 80,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Consumer<JobsDetailProvider>(
                          builder: (_, modalSheet, child) => Text(
                            "${modalSheet.hours}h * ${modalSheet.hourlyRate}€",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  SizedBox(
                    height: MediaQuery.of(context).size.width / 40,
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        "Price of the requested service",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ).tr(),
                      const Spacer(),
                      Text(
                        "50€",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width / 40,
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        "Total",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ).tr(),
                      const Spacer(),
                      Consumer<JobsDetailProvider>(
                        builder: (_, modalSheet, child) => Text(
                          "${modalSheet.hourlyRate! * modalSheet.hours!}€",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width / 40,
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        "Pay the 10% tax",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ).tr(),
                      const Spacer(),
                      Consumer<JobsDetailProvider>(
                        builder: (_, modalSheet, child) => Text(
                          "${(modalSheet.hourlyRate! * modalSheet.hours!) * 10 / 100}€",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width / 20,
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        "General subtotal",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ).tr(),
                      const Spacer(),
                      Consumer<JobsDetailProvider>(
                        builder: (_, modalSheet, child) => Text(
                          "${(modalSheet.hourlyRate! * modalSheet.hours! - ((modalSheet.hourlyRate! * modalSheet.hours!) * 10 / 100))} €",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width / 20,
                  ),
                  Consumer<JobsDetailProvider>(
                    builder: (_, modalSheet, child) => CustomButton(
                        onPress: () {
                          postProposal(
                              context,
                              postId,
                              "${modalSheet.hourlyRate! * modalSheet.hours!}",
                              hourlyRate,
                              hours,
                              "${(modalSheet.hourlyRate! * modalSheet.hours!) * 10 / 100}");
                        },
                        buttonName: "To post"),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> postProposal(context, id, price, hours, duration, tax) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return const LoginProgressIndicator();
        });
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    String? userToken = sharedPrefs.getString("token");
    var response = await http.post(
      Uri.parse('${MyRoutes.BASEURL}/jobber/proposal/submit'),
      headers: <String, String>{
        'Accept': "application/json",
        'Content-Type': "application/json",
        'Authorization': 'Bearer $userToken',
      },
      body: jsonEncode(<String, String>{
        'id': id.toString(),
        'price': price.toString(),
        'hours': hours.toString(),
        'duration': duration.toString(),
        'tax': tax.toString(),
      }),
    );
    if (response.statusCode == 200) {
      debugPrint("submit Proposal api working");
      debugPrint("$postId");
      Navigator.pop(context);
      Provider.of<AvailableJobsProvider>(context, listen: false).getAvailableJobs(context);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (ctx) => HomeTabScreen(
              pageIndex: 1,
            ),
          ),
          (route) => false);
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          padding :const EdgeInsets.all(20.0),
          backgroundColor: const Color(0xFFebf9fe),
          content: Text(
            'Proposal submit Successfully',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          duration: const Duration(
            seconds: 2,
          ),
        ),
      );
      notifyListeners();
    } else if(response.statusCode == 401){
      debugPrint('error: 401');
      Navigator.of(context).pushNamedAndRemoveUntil(MyRoutes.LOGINSCREENROUTE, (route) => false);
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          padding :const EdgeInsets.all(20.0),
          backgroundColor: const Color(0xFFebf9fe),
          content:  Text(
            'Session Expired...  Please Log-In',
            style: Theme.of(context).textTheme.bodyMedium,
          ).tr(),
          duration: const Duration(
            seconds: 2,
          ),
        ),
      );
    }  else {
      Navigator.pop(context);
      debugPrint("Proposal submit api not working");
    }
  }
}
