import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:mister_jobby_jobber/screens/auth_screens/mandatory_steps/indicate_skills/sub_skills_screen.dart';
import 'package:provider/provider.dart';

import '../../../../providers/mandatory_steps_provider/indicate_skills_provider/indicate_skills_provider.dart';
import '../../../../providers/mandatory_steps_provider/jobber_check_skills_provider/jobber_check_skills_provider.dart';
import 'skills_selection_steps/layout_selection_step.dart';

class SkillsSelectionScreen extends StatelessWidget {
  const SkillsSelectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final getSkillsData =
        Provider.of<IndicateSkillsProvider>(context, listen: false);
    final extractedSkills = getSkillsData.skills;
    final checkSkillsData = Provider.of<JobberCheckSkillsProvider>(context,listen: false);
    final extractedCheckSkills = checkSkillsData.jobberCheckSkills;
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Skills",
                    style: Theme.of(context).textTheme.titleMedium,
                  ).tr(),
                  SizedBox(
                    height: MediaQuery.of(context).size.width / 30,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.check_box_outline_blank,
                          size: 25,
                          color: Colors.black45,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 40,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Text(
                            extractedSkills![0].title,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width / 30,
                  ),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: extractedSkills[0].subCategories.length,
                    itemBuilder: (ctx, index) => ListTile(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (ctx) => LayoutSkillSelectionStepScreen(
                              mainCategoryId: extractedSkills[0].id.toString(),
                                  subCategory:
                                      extractedSkills[0].subCategories[index],
                                )),
                      ),
                      dense: true,
                      leading: const Icon(
                        Icons.check_box_outline_blank,
                        size: 25,
                        color: Colors.black45,
                      ),
                      title: Text(
                        extractedSkills[0].subCategories[index].title,
                        style: Theme.of(context).textTheme.bodySmall,
                      ).tr(),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        size: 20,
                      ),
                    ),
                  ),
                  const Divider(),
                  SizedBox(
                    height: MediaQuery.of(context).size.width / 30,
                  ),
                  ListTile(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) =>
                            SubSkillsScreen(skills: extractedSkills[1]),
                      ),
                    ),
                    dense: true,
                    leading: const Icon(
                      Icons.check_box_outline_blank,
                      size: 25,
                      color: Colors.black45,
                    ),
                    title: Text(
                      extractedSkills[1].title,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width / 30,
                  ),
                  ListTile(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) =>
                            SubSkillsScreen(skills: extractedSkills[2]),
                      ),
                    ),
                    dense: true,
                    leading: const Icon(
                      Icons.check_box_outline_blank,
                      size: 25,
                      color: Colors.black45,
                    ),
                    title: Text(
                      extractedSkills[2].title,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width / 30,
                  ),
                  ListTile(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) =>
                            SubSkillsScreen(skills: extractedSkills[3]),
                      ),
                    ),
                    dense: true,
                    leading: const Icon(
                      Icons.check_box_outline_blank,
                      size: 25,
                      color: Colors.black45,
                    ),
                    title: Text(
                      extractedSkills[3].title,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width / 30,
                  ),
                  ListTile(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) =>
                            SubSkillsScreen(skills: extractedSkills[4]),
                      ),
                    ),
                    dense: true,
                    leading: const Icon(
                      Icons.check_box_outline_blank,
                      size: 25,
                      color: Colors.black45,
                    ),
                    title: Text(
                      extractedSkills[4].title,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width / 30,
                  ),
                  ListTile(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) =>
                            SubSkillsScreen(skills: extractedSkills[5]),
                      ),
                    ),
                    dense: true,
                    leading: const Icon(
                      Icons.check_box_outline_blank,
                      size: 25,
                      color: Colors.black45,
                    ),
                    title: Text(
                      extractedSkills[5].title,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width / 30,
                  ),
                  ListTile(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) =>
                            SubSkillsScreen(skills: extractedSkills[6]),
                      ),
                    ),
                    dense: true,
                    leading: const Icon(
                      Icons.check_box_outline_blank,
                      size: 25,
                      color: Colors.black45,
                    ),
                    title: Text(
                      extractedSkills[6].title,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width / 30,
                  ),
                  ListTile(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) =>
                            SubSkillsScreen(skills: extractedSkills[7]),
                      ),
                    ),
                    dense: true,
                    leading: const Icon(
                      Icons.check_box_outline_blank,
                      size: 25,
                      color: Colors.black45,
                    ),
                    title: Text(
                      extractedSkills[7].title,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width / 30,
                  ),
                  ListTile(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) =>
                            SubSkillsScreen(skills: extractedSkills[8]),
                      ),
                    ),
                    dense: true,
                    leading: const Icon(
                      Icons.check_box_outline_blank,
                      size: 25,
                      color: Colors.black45,
                    ),
                    title: Text(
                      extractedSkills[8].title,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width / 30,
                  ),
                  ListTile(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) =>
                            SubSkillsScreen(skills: extractedSkills[9]),
                      ),
                    ),
                    dense: true,
                    leading: const Icon(
                      Icons.check_box_outline_blank,
                      size: 25,
                      color: Colors.black45,
                    ),
                    title: Text(
                      extractedSkills[9].title,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width / 30,
                  ),
                  ListTile(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) =>
                            SubSkillsScreen(skills: extractedSkills[10]),
                      ),
                    ),
                    dense: true,
                    leading: const Icon(
                      Icons.check_box_outline_blank,
                      size: 25,
                      color: Colors.black45,
                    ),
                    title: Text(
                      extractedSkills[10].title,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width / 30,
                  ),
                  ListTile(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) =>
                            SubSkillsScreen(skills: extractedSkills[11]),
                      ),
                    ),
                    dense: true,
                    leading: const Icon(
                      Icons.check_box_outline_blank,
                      size: 25,
                      color: Colors.black45,
                    ),
                    title: Text(
                      extractedSkills[11].title,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width / 30,
                  ),
                  ListTile(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) =>
                            SubSkillsScreen(skills: extractedSkills[12]),
                      ),
                    ),
                    dense: true,
                    leading: const Icon(
                      Icons.check_box_outline_blank,
                      size: 25,
                      color: Colors.black45,
                    ),
                    title: Text(
                      extractedSkills[12].title,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width / 30,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
