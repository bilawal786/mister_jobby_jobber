import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mister_jobby_jobber/providers/my_skills_provider/my_skills_provider.dart';
import 'package:provider/provider.dart';

import '../../../models/my_skills_model/my_skills_model.dart';
import 'edit_engagements_selection_step.dart';
import 'edit_equipments_selection_step.dart';
import 'edit_selected_skills.dart';

class EditMySkillsScreen extends StatefulWidget {
  final MySkillsModel myskillsModel;
  final int index;
  const EditMySkillsScreen({Key? key, required this.myskillsModel, required this.index,}) : super(key: key);

  @override
  State<EditMySkillsScreen> createState() => _EditMySkillsScreenState();
}

class _EditMySkillsScreenState extends State<EditMySkillsScreen> {
  var isInit = true;
  @override
  void didChangeDependencies() {
    if(isInit) {
      Provider.of<MySkillsProvider>(context,listen: false).addTempData(widget.index);
      Provider.of<MySkillsProvider>(context,listen: false).addTempEquipmentData(widget.index);
      Provider.of<MySkillsProvider>(context,listen: false).addTempEngagementData(widget.index);
    }
    isInit = false;
    super.didChangeDependencies();
  }
  int currentStep = 0;
  @override
  Widget build(BuildContext context) {
    final editSkillsData = Provider.of<MySkillsProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.myskillsModel.subCategory != "" ? widget.myskillsModel.subCategory : widget.myskillsModel.mainCategory, style: Theme.of(context).textTheme.bodyLarge,),
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

            print(editSkillsData.temp.join(','));
            print(editSkillsData.tempEquipment.join(','));
            print(editSkillsData.tempEngagement.join(','));


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
      content: EditSelectedSkills(stepSkills: widget.myskillsModel, index: widget.index,),
    ),
    Step(
      isActive: currentStep >= 1,
      state: currentStep > 1 ? StepState.complete : StepState.indexed,
      title: const Text(""),
      content: EditEquipmentSelectionStep(mySkillEquimpent: widget.myskillsModel),
    ),
    Step(
      isActive: currentStep >= 2,
      state: currentStep > 2 ? StepState.complete : StepState.indexed,
      title: const Text(""),
      content: Container(),
    ),
    Step(
      isActive: currentStep >= 3,
      state: currentStep > 3 ? StepState.complete : StepState.indexed,
      title: const Text(""),
      content: const EditEngagementSelectionStep(),
    ),
  ];
}
