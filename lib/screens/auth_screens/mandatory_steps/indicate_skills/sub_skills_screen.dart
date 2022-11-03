import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';

import '../../../../models/mandatory_steps_model/indicate_skills_model/indicate_skills_model.dart';
import '../../../../providers/const_provider/const_provider.dart';

class SubSkillsScreen extends StatefulWidget {
  final IndicateSkillsModel? skills;
  const SubSkillsScreen({
    Key? key,
    required this.skills,
  }) : super(key: key);

  @override
  State<SubSkillsScreen> createState() => _SubSkillsScreenState();
}

class _SubSkillsScreenState extends State<SubSkillsScreen> {
  bool value = false;
  @override
  Widget build(BuildContext context) {
    var getList = Provider.of<ConstProvider>(context, listen: false);
    return  Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              widget.skills!.title,
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
                    onTap: () {
                      getList.isAddedSubCategories(widget
                          .skills!.subCategories[index].id
                          .toString());

                      debugPrint(getList.tempSubCategory.join(","));
                    },
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                    title: Text(
                      widget.skills!.subCategories[index].title,
                      style: Theme.of(context).textTheme.bodySmall,
                    ).tr(),
                    trailing: Container(
                      width: 20,
                      height: 20,
                      padding: const EdgeInsets.all(0.2),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: getList.tempSubCategory.contains(widget
                              .skills!.subCategories[index].id
                              .toString())
                              ? Theme.of(context).primaryColor
                              : Colors.black,
                        ),
                        color: getList.tempSubCategory.contains(widget
                            .skills!.subCategories[index].id
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
                  const Divider(),
                ],
              ),
            ),

          ],
        ),
    );
  }
}
