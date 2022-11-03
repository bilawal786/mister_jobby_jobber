import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mister_jobby_jobber/models/mandatory_steps_model/indicate_skills_model/indicate_skills_model.dart';
import 'package:provider/provider.dart';

import '../../../../../providers/const_provider/const_provider.dart';
import '../skills_selection_steps/layout_skill_selection_steps/engagements_selection_step.dart';
import '../skills_selection_steps/layout_skill_selection_steps/experience_diploma_step.dart';
import '../sub_skills_screen.dart';
import 'livraison_equipment_step.dart';

class LivraisonSkillsSelectionStepScreen extends StatefulWidget {
  final String mainCategoryId;
  final IndicateSkillsModel mainCategory;
  const LivraisonSkillsSelectionStepScreen({
    Key? key,
    required this.mainCategoryId,
    required this.mainCategory,
  }) : super(key: key);

  @override
  State<LivraisonSkillsSelectionStepScreen> createState() =>
      _LivraisonSkillsSelectionStepScreenState();
}

class _LivraisonSkillsSelectionStepScreenState
    extends State<LivraisonSkillsSelectionStepScreen> {
  int currentStep = 0;
  @override
  Widget build(BuildContext context) {
    final getList = Provider.of<ConstProvider>(context);
    return WillPopScope(
      onWillPop: ()async{
        getList.clearData();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: SizedBox(
            width: MediaQuery.of(context).size.width / 2.5,
            child: Text(
              widget.mainCategory.title,
              style: Theme.of(context).textTheme.titleMedium,
              overflow: TextOverflow.ellipsis,
            ).tr(),
          ),
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
              debugPrint(widget.mainCategoryId);
              debugPrint(getList.tempSubCategory.join(","));
              debugPrint(getList.tempEquipment.join(","));
              debugPrint(getList.haveDiploma);
              debugPrint(getList.diplomaName);
              debugPrint(getList.experienceTitle);
              debugPrint(getList.skillsDetail);
              debugPrint(getList.tempEngagement.join(","));

              getList.postJobberSkills(
                context,
                widget.mainCategoryId,
                "",
                getList.tempSubCategory.join(","),
                getList.haveDiploma,
                getList.diplomaName,
                getList.experienceTitle,
                getList.skillsDetail,
                getList.tempEquipment.join(","),
                getList.tempEngagement.join(","),
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
                  ((currentStep < 1) && (getList.tempSubCategory.isNotEmpty))
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
                  ((currentStep == 1) && (getList.tempEquipment.isNotEmpty))
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
                  ((currentStep == 2) &&
                      (getList.haveDiploma == "No" ||
                          (getList.haveDiploma == "Yes" &&
                              getList.diplomaName.isNotEmpty)) &&
                      (getList.experienceTitle.isNotEmpty))
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
                  ((currentStep == 3) && (getList.tempEngagement.isNotEmpty))
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
                  ((currentStep == 4) && (getList.tempEngagement.isNotEmpty))
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
      ),
    );
  }

  List<Step> getSteps() => [
    Step(
      isActive: currentStep >= 0,
      state: currentStep > 0 ? StepState.complete : StepState.indexed,
      title: const Text(""),
      content: SubSkillsScreen(skills: widget.mainCategory),
    ),
    Step(
      isActive: currentStep >= 1,
      state: currentStep > 1 ? StepState.complete : StepState.indexed,
      title: const Text(""),
      content: const LivraisonEquipmentSelectionStep(),
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
