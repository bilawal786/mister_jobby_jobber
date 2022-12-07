import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mister_jobby_jobber/models/my_skills_model/my_skills_model.dart';
import 'package:provider/provider.dart';

import '../../../providers/my_skills_provider/my_skills_provider.dart';

class EditSelectedSkills extends StatefulWidget {
  final MySkillsModel stepSkills;
  final int index;
  const EditSelectedSkills({
    Key? key,
    required this.stepSkills,
    required this.index,
  }) : super(key: key);

  @override
  State<EditSelectedSkills> createState() => _EditSelectedSkillsState();
}

class _EditSelectedSkillsState extends State<EditSelectedSkills> {
  @override
  Widget build(BuildContext context) {
    final mySkillsData = Provider.of<MySkillsProvider>(context, listen: false);
    return Column(
      children: <Widget>[
        if (widget.stepSkills.mainCategoryId == 1) ...[
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.stepSkills.childCategories.length,
            itemBuilder: (ctx, index) => Column(children: <Widget>[
              ListTile(
                onTap: () {
                  mySkillsData.isAdded(
                      widget.stepSkills.childCategories[index].id.toString());
                  debugPrint(mySkillsData.temp.join(","));
                },
                contentPadding: EdgeInsets.zero,
                dense: true,
                title: Text(
                  widget.stepSkills.childCategories[index].title,
                  style: Theme.of(context).textTheme.bodySmall,
                ).tr(),
                trailing: Consumer<MySkillsProvider>(
                  builder: (_, getSkills, child) => Container(
                    width: 20,
                    height: 20,
                    padding: const EdgeInsets.all(0.2),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: getSkills.temp.contains(widget
                                .stepSkills.childCategories[index].id
                                .toString())
                            ? Theme.of(context).primaryColor
                            : Colors.black,
                      ),
                      color: getSkills.temp.contains(widget
                              .stepSkills.childCategories[index].id
                              .toString())
                          ? Theme.of(context).primaryColor
                          : Colors.white,
                    ),
                    child: const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 15,
                    ),
                  ),
                ),
              ),
              const Divider(),
            ]),
          ),
        ] else if (widget.stepSkills.mainCategoryId != 1) ...[
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.stepSkills.subCategories.length,
            itemBuilder: (ctx, index) => Column(
              children: <Widget>[
                ListTile(
                  onTap: () {
                    mySkillsData.isAdded(
                        widget.stepSkills.subCategories[index].id.toString());
                    debugPrint(mySkillsData.temp.join(","));
                  },
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                  title: Text(
                    widget.stepSkills.subCategories[index].title,
                    style: Theme.of(context).textTheme.bodySmall,
                  ).tr(),
                  trailing: Consumer<MySkillsProvider>(
                    builder: (_, getSkills, child) => Container(
                      width: 20,
                      height: 20,
                      padding: const EdgeInsets.all(0.2),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: getSkills.temp.contains(widget
                                  .stepSkills.subCategories[index].id
                                  .toString())
                              ? Theme.of(context).primaryColor
                              : Colors.black,
                        ),
                        color: getSkills.temp.contains(widget
                                .stepSkills.subCategories[index].id
                                .toString())
                            ? Theme.of(context).primaryColor
                            : Colors.white,
                      ),
                      child: const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 15,
                      ),
                    ),
                  ),
                ),
                const Divider(),
              ],
            ),
          ),
        ],
      ],
    );
  }
}
