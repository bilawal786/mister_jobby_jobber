import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../providers/const_provider/const_provider.dart';
import '../../../../../../widgets/const_widgets/outline_selected_button.dart';

class ExperienceDiplomaStep extends StatelessWidget {
  const ExperienceDiplomaStep({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Do you have a diploma related to the skill?",
            style: Theme.of(context).textTheme.titleMedium,
          ).tr(),
          SizedBox(
            height: MediaQuery.of(context).size.width / 40,
          ),
          Consumer<ConstProvider>(
            builder: (_, diploma, child) => SizedBox(
              height: 45,
              child: ListView.builder(
                itemCount: 2,
                itemExtent: MediaQuery.of(context).size.width / 2.5,
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) =>
                    OutlineSelectedButton(
                  onTap: () => diploma.diplomaCheck(index),
                  textTitle: index == 0 ? "Yes" : "No",
                  color: diploma.diploma - 1 == index
                      ? Colors.blue.shade50
                      : Colors.grey.shade300,
                  border: diploma.diploma - 1 == index ? true : false,
                ),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.width / 20,
          ),
          Consumer<ConstProvider>(
            builder: (_, checkDiploma, child) => (checkDiploma.haveDiploma ==
                    "Yes")
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "What is the name of the degree?",
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width / 20,
                      ),
                      TextFormField(
                        onChanged: (value) {
                          checkDiploma.diplomaName = value;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: "Diploma Name".tr(),
                          isDense: true,
                        ),
                        maxLength: 80,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  )
                : const SizedBox(),
          ),
          const Divider(),
          Text(
            "What is your experience as a provider?",
            style: Theme.of(context).textTheme.titleMedium,
          ).tr(),
          SizedBox(
            height: MediaQuery.of(context).size.width / 40,
          ),
          Consumer<ConstProvider>(
            builder: (_, checkExperience, child) => SizedBox(
              height: 50,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: 4,
                itemExtent: MediaQuery.of(context).size.width / 1.9,
                itemBuilder: (context, index) => OutlineSelectedButton(
                  onTap: () => checkExperience.experienceFunction(index),
                  textTitle: index == 0
                      ? "None"
                      : index == 1
                          ? "Less than a year"
                          : index == 2
                              ? "2 to 4 years old"
                              : index == 3
                                  ? "5 to 9 years old"
                                  : "+10 years",
                  color: checkExperience.experience - 1 == index
                      ? Colors.blue.shade50
                      : Colors.grey.shade300,
                  border:
                      checkExperience.experience - 1 == index ? true : false,
                ),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.width / 40,
          ),
          const Divider(),
          Text(
            "Would you like to tell more about your skills?",
            style: Theme.of(context).textTheme.titleMedium,
          ).tr(),
          SizedBox(
            height: MediaQuery.of(context).size.width / 40,
          ),
          Consumer<ConstProvider>(
            builder: (_, skills, child) => TextFormField(
              onChanged: (value) {
                skills.skillsDetail = value;
              },
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'Skill Detail'.tr(),
                hintText: 'Skill Detail'.tr(),
                isDense: true,
              ),
              style: Theme.of(context).textTheme.bodySmall,
              maxLines: 5,
            ),
          ),
        ],
      ),
    );
  }
}
