import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/my_skills_model/my_skills_model.dart';
import '../../../providers/my_skills_provider/my_skills_provider.dart';

class EditMySkillDescription extends StatefulWidget {
  final MySkillsModel mySkillDescription;
  const EditMySkillDescription({Key? key, required this.mySkillDescription}) : super(key: key);

  @override
  State<EditMySkillDescription> createState() => _EditMySkillDescriptionState();
}

class _EditMySkillDescriptionState extends State<EditMySkillDescription> {
  @override
  Widget build(BuildContext context) {
    final mySkillsData = Provider.of<MySkillsProvider>(context, listen: false);
    mySkillsData.skillsDetail = widget.mySkillDescription.description;
    return Column(
      children: <Widget>[
        Text(
          "Would you like to tell more about your skills?",
          style: Theme.of(context).textTheme.titleMedium,
        ).tr(),
        SizedBox(
          height: MediaQuery.of(context).size.width / 40,
        ),
        Consumer<MySkillsProvider>(
          builder: (_, skills, child) => TextFormField(
            initialValue: widget.mySkillDescription.description,
            onChanged: (value) {
              skills.getDescription(value);
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
    );
  }
}
