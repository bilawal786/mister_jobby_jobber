import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';

import '../../../../providers/mandatory_steps_provider/insurance_provider/insurance_provider.dart';
import './insurance_first_step.dart';
import './insurance_second_step.dart';

class InsuranceStepScreen extends StatefulWidget {
  const InsuranceStepScreen({Key? key}) : super(key: key);

  @override
  State<InsuranceStepScreen> createState() => _InsuranceStepScreenState();
}

class _InsuranceStepScreenState extends State<InsuranceStepScreen> {
  int currentStep = 0;
  @override
  Widget build(BuildContext context) {
    final insuranceData = Provider.of<InsuranceProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black,
          size: 25,
        ),
      ),
      body: Stepper(
        elevation: 0,
        type: StepperType.horizontal,
        steps: getSteps(),
        currentStep: currentStep,
        onStepContinue: () {
          final isLastStep = currentStep == getSteps().length - 1;
          if (isLastStep) {
            print("Step completed");

            insuranceData.postInsurance(
              context,
              insuranceData.insuranceAnswer1,
              insuranceData.insuranceAnswer2,
              insuranceData.insuranceAnswer3,
              insuranceData.reservedJobsMisterJobby,
            );
          } else {
            setState(() => currentStep += 1);
          }
        },
        onStepCancel: () {
          currentStep == 0
              ? Navigator.of(context).pop()
              : setState(() => currentStep -= 1);
        },
        controlsBuilder: (context, ControlsDetails details) {
          return Container(
            margin: const EdgeInsets.only(top: 50),
            child: Row(
              children: <Widget>[
                ((currentStep < 1) &&
                        (insuranceData.insuranceQuestion1 != 0) &&
                        (insuranceData.insuranceQuestion2 != 0) &&
                        (insuranceData.insuranceQuestion3 != 0))
                    ? Expanded(
                        child: ElevatedButton(
                          onPressed: details.onStepContinue,
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(50.0), backgroundColor: Theme.of(context).primaryColor,
                            elevation: 5,
                          ),
                          child: Text(
                            currentStep > 1
                                ? "Process_Screen_Confirm_Button"
                                : "Process_Screen_Continue_Button",
                            style: const TextStyle(
                                fontSize: 20,
                                fontFamily: 'Cerebri Sans Regular',
                                fontWeight: FontWeight.normal,
                                color: Colors.white,
                                letterSpacing: 1),
                          ).tr(),
                        ),
                      )
                    : const SizedBox(),
                ((currentStep == 1) &&
                        (insuranceData.reservedJobsMisterJobby == true) &&
                        (insuranceData.mustPerformServices == true))
                    ? Expanded(
                        child: ElevatedButton(
                          onPressed: details.onStepContinue,
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(50.0), backgroundColor: Theme.of(context).primaryColor,
                            elevation: 5,
                          ),
                          child: Text(
                            currentStep > 0
                                ? "Process_Screen_Confirm_Button"
                                : "Process_Screen_Continue_Button",
                            style: const TextStyle(
                                fontSize: 20,
                                fontFamily: 'Cerebri Sans Regular',
                                fontWeight: FontWeight.normal,
                                color: Colors.white,
                                letterSpacing: 1),
                          ).tr(),
                        ),
                      )
                    : const SizedBox(),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 40,
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: details.onStepCancel,
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50.0), backgroundColor: Colors.black12,
                      elevation: 0,
                    ),
                    child: const Text(
                      "Process_Screen_Cancel_Button",
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Cerebri Sans Regular',
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                          letterSpacing: 1),
                    ).tr(),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  List<Step> getSteps() => [
        Step(
          isActive: currentStep >= 0,
          state: currentStep > 0 ? StepState.complete : StepState.indexed,
          title: const Text(""),
          content: const InsuranceFirstStep(),
        ),
        Step(
          isActive: currentStep >= 1,
          state: currentStep > 1 ? StepState.complete : StepState.indexed,
          title: const Text(""),
          content: const InsuranceSecondStep(),
        ),
      ];
}
