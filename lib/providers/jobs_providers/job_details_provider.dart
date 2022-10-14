import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mister_jobby_jobber/widgets/const_widgets/custom_button.dart';
import 'package:provider/provider.dart';

class JobsDetailProvider with ChangeNotifier {
  int hourlyRate = 13;
  int hours = 2;



  void decreaseHourlyRate() {
    if (hourlyRate > 13) {
        hourlyRate -= 1;
    }
    notifyListeners();
  }
  void increaseHourlyRate() {
      hourlyRate += 1;
    notifyListeners();
  }

  showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: .6,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: Text(
                    "Adjust your hourly rate",
                    style: Theme.of(context).textTheme.titleMedium,
                  ).tr(),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width / 20,
                ),
                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      InkWell(
                        onTap: () { decreaseHourlyRate();},
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
                        width: MediaQuery.of(context).size.width / 40,
                      ),
                      Consumer<JobsDetailProvider>(
                        builder: (_, modalSheet, child) => Text(
                          modalSheet.hourlyRate.toString(),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 40,
                      ),
                      InkWell(
                        onTap: (){
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
                ),
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
                    Text(
                      "$hours hours",
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
                      "Total Compensation",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ).tr(),
                    const Spacer(),
                    Consumer<JobsDetailProvider>(
                      builder:(_,modalSheet,child) => Text(
                        "${modalSheet.hourlyRate * modalSheet.hours} €",
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

                        builder:(_,modalSheet,child)=> Text(
                          "2h * ${modalSheet.hourlyRate}€",
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
                      builder:(_,modalSheet, child) => Text(
                        "${modalSheet.hourlyRate * modalSheet.hours}€",
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
                      builder:(_,modalSheet,child) => Text(
                        "${(modalSheet.hourlyRate * modalSheet.hours) *10 / 100 }€",
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
                      builder: (_,modalSheet,child) => Text(
                        "${(modalSheet.hourlyRate * modalSheet.hours + ((modalSheet.hourlyRate * modalSheet.hours) *10 / 100)) } €",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width / 20,
                ),
                CustomButton(onPress: () {}, buttonName: "To post"),
              ],
            ),
          ),
        );
      },
    );
  }
}
