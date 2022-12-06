import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../models/my_skills_model/my_skills_model.dart';
import '../auth_screens/mandatory_steps/indicate_skills/skills_selection_steps/layout_skill_selection_steps/child_skills_screen.dart';
import '../auth_screens/mandatory_steps/indicate_skills/skills_selection_steps/layout_skill_selection_steps/engagements_selection_step.dart';
import '../auth_screens/mandatory_steps/indicate_skills/skills_selection_steps/layout_skill_selection_steps/equipments_selection_step.dart';
import '../auth_screens/mandatory_steps/indicate_skills/skills_selection_steps/layout_skill_selection_steps/experience_diploma_step.dart';

class EditMySkillsScreen extends StatefulWidget {
  final MySkillsModel myskillsModel;
  const EditMySkillsScreen({Key? key, required this.myskillsModel}) : super(key: key);

  @override
  State<EditMySkillsScreen> createState() => _EditMySkillsScreenState();
}

class _EditMySkillsScreenState extends State<EditMySkillsScreen> {
  int currentStep = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.myskillsModel.subCategory} Edit", style: Theme.of(context).textTheme.bodyLarge,),
        centerTitle: false,
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
            debugPrint("Step completed");



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
                ((currentStep < 1)  )
                    ? Expanded(
                  child: ElevatedButton(
                    onPressed: details.onStepContinue,
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50.0),
                      backgroundColor: Theme.of(context).primaryColor,
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
                ((currentStep == 1) )
                    ? Expanded(
                  child: ElevatedButton(
                    onPressed: details.onStepContinue,
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50.0),
                      backgroundColor: Theme.of(context).primaryColor,
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
                ((currentStep == 2) )
                    ? Expanded(
                  child: ElevatedButton(
                    onPressed: details.onStepContinue,
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50.0),
                      backgroundColor: Theme.of(context).primaryColor,
                      elevation: 5,
                    ),
                    child: Text(
                      currentStep > 2
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
                ((currentStep == 3) )
                    ? Expanded(
                  child: ElevatedButton(
                    onPressed: details.onStepContinue,
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50.0),
                      backgroundColor: Theme.of(context).primaryColor,
                      elevation: 5,
                    ),
                    child: Text(
                      currentStep >= 3
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
                ((currentStep == 4) )
                    ? Expanded(
                  child: ElevatedButton(
                    onPressed: details.onStepContinue,
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50.0),
                      backgroundColor: Theme.of(context).primaryColor,
                      elevation: 5,
                    ),
                    child: Text(
                      currentStep > 4
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
                      backgroundColor: Colors.black12,
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
      content: Container(),
    ),
    Step(
      isActive: currentStep >= 1,
      state: currentStep > 1 ? StepState.complete : StepState.indexed,
      title: const Text(""),
      content: const EquipmentSelectionStep(),
    ),
    Step(
      isActive: currentStep >= 2,
      state: currentStep > 2 ? StepState.complete : StepState.indexed,
      title: const Text(""),
      content: const ExperienceDiplomaStep(),
    ),
    Step(
      isActive: currentStep >= 3,
      state: currentStep > 3 ? StepState.complete : StepState.indexed,
      title: const Text(""),
      content: const EngagementSelectionStep(),
    ),
  ];
}
