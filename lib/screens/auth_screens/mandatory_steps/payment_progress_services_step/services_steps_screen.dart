import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';

import '../../../../providers/const_provider/const_provider.dart';
import '../../../../providers/mandatory_steps_provider/service_provider/services_provider.dart';
import '../../../../screens/auth_screens/mandatory_steps/payment_progress_services_step/services_first_step.dart';
import '../../../../screens/auth_screens/mandatory_steps/payment_progress_services_step/services_second_step.dart';

class ServicesStepsScreen extends StatefulWidget {
  const ServicesStepsScreen({Key? key}) : super(key: key);

  @override
  State<ServicesStepsScreen> createState() => _ServicesStepsScreenState();
}

class _ServicesStepsScreenState extends State<ServicesStepsScreen> {
  int currentStep = 0;
  @override
  Widget build(BuildContext context) {
    final servicesData = Provider.of<ConstProvider>(context, listen: true);
    final progressServiceApi =
        Provider.of<ServicesProvider>(context, listen: false);
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
            print("services Q1 value:  ${servicesData.questionOneValue}");
            print("services Q2 value:  ${servicesData.questionTwoValue}");
            print("services Q3 value:  ${servicesData.questionThreeValue}");
            print("services Q4 value:  ${servicesData.trustMisterJobby}");
            print("services Q5 value:  ${servicesData.cashNotRequired}");

            progressServiceApi.postProgressServices(
              servicesData.questionOneValue,
              servicesData.questionTwoValue,
              servicesData.questionThreeValue,
              servicesData.trustMisterJobby,
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
                        (servicesData.questionOneValue != 0) &&
                        (servicesData.questionTwoValue != 0) &&
                        (servicesData.questionThreeValue != 0))
                    ? Expanded(
                        child: ElevatedButton(
                          onPressed: details.onStepContinue,
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(50.0),
                            primary: Theme.of(context).primaryColor,
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
                        (servicesData.trustMisterJobby == true) &&
                        (servicesData.cashNotRequired == true))
                    ? Expanded(
                        child: ElevatedButton(
                          onPressed: details.onStepContinue,
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(50.0),
                            primary: Theme.of(context).primaryColor,
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
                      minimumSize: const Size.fromHeight(50.0),
                      primary: Colors.black12,
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
          content: const ServicesFirstStep(),
        ),
        Step(
          isActive: currentStep >= 1,
          state: currentStep > 1 ? StepState.complete : StepState.indexed,
          title: const Text(""),
          content: const ServicesSecondStep(),
        ),
      ];
}
