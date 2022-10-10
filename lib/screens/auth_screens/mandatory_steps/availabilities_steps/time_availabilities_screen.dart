import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/const_provider/const_provider.dart';
import '../../../../widgets/const_widgets/group_radio_tile.dart';
import '../../../../widgets/const_widgets/custom_button.dart';

class TimeAvailabilitiesScreen extends StatelessWidget {
  const TimeAvailabilitiesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black,
          size: 25,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              Text(
                "When are you available ?",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width / 20,
              ),
              Consumer<ConstProvider>(
                builder: (_, selectedTime, child) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    GroupRadioTile(
                      title: "All Day",
                      subTitle: "07:00 - 21:00",
                      value: 1,
                      groupValue: selectedTime.groupValue,
                      onClick: selectedTime.checkGroupValue,
                    ),
                    GroupRadioTile(
                      title: "Morning only",
                      subTitle: "07:00 - 13:00",
                      value: 2,
                      groupValue: selectedTime.groupValue,
                      onClick: selectedTime.checkGroupValue,
                    ),
                    GroupRadioTile(
                      title: "Afternoon only",
                      subTitle: "13:00 - 18:00",
                      value: 3,
                      groupValue: selectedTime.groupValue,
                      onClick: selectedTime.checkGroupValue,
                    ),
                    GroupRadioTile(
                      title: "In the evening only",
                      subTitle: "18:00 - 21:00",
                      value: 4,
                      groupValue: selectedTime.groupValue,
                      onClick: selectedTime.checkGroupValue,
                    ),
                    GroupRadioTile(
                      title: "I am not available",
                      value: 5,
                      groupValue: selectedTime.groupValue,
                      onClick: selectedTime.checkGroupValue,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width / 1.8,
              ),
              const Divider(),
              Consumer<ConstProvider>(
                builder: (_, selectTime, child) => (selectTime.groupValue > 0)
                    ? CustomButton(onPress: () {}, buttonName: "To validate")
                    : const SizedBox(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
