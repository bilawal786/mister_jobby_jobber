import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../widgets/const_widgets/custom_button.dart';
import '../../../../models/mandatory_steps_model/indicate_skills_model/indicate_skills_model.dart';

class SubSkillsScreen extends StatefulWidget {
  final IndicateSkillsModel? skills;
  const SubSkillsScreen({Key? key, required this.skills,}) : super(key: key);

  @override
  State<SubSkillsScreen> createState() => _SubSkillsScreenState();
}

class _SubSkillsScreenState extends State<SubSkillsScreen> {
  bool value = false;
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
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Small",
                style: Theme.of(context).textTheme.labelMedium,
              ).tr(),
              SizedBox(
                height: MediaQuery.of(context).size.width / 40,
              ),
              Text(
                "What types of jobs do you want to do?",
                style: Theme.of(context).textTheme.titleMedium,
              ).tr(),
              SizedBox(
                height: MediaQuery.of(context).size.width / 40,
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.skills!.subCategories.length,
                itemBuilder: (ctx, index) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                      title: Text(
                        widget.skills!.subCategories[index].title,
                        style: Theme.of(context).textTheme.bodySmall,
                      ).tr(),
                      trailing: Checkbox(
                        value: this.value,
                        onChanged: (v) {
                          setState(() {
                            this.value = v!;
                          });
                        },
                      ),
                    ),
                    const Divider(),
                  ],
                ),
              ),
              CustomButton(onPress: (){}, buttonName: "Continue"),
            ],
          ),
        ),
      ),
    );
  }
}
