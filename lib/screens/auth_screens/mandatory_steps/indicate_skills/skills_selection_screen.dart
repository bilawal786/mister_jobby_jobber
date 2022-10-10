import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';

import '../../../../providers/mandatory_steps_provider/indicate_skills_provider/indicate_skills_provider.dart';

class SkillsSelectionScreen extends StatelessWidget {
  const SkillsSelectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final getSkillsData = Provider.of<IndicateSkillsProvider>(context, listen: false);
    final extractedSkills = getSkillsData.skills;
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
                  Text("Skills", style: Theme.of(context).textTheme.titleMedium,).tr(),
                  SizedBox(
                    height: MediaQuery.of(context).size.width/ 30,
                  ),
                  Text(extractedSkills![0].title, style: Theme.of(context).textTheme.bodyLarge,),
                  SizedBox(
                    height: MediaQuery.of(context).size.width/ 30,
                  ),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: extractedSkills[0].subCategories.length,
                    itemBuilder: (ctx, index) => ListTile(
                      onTap: (){},
                      dense: true,
                      leading: const Icon(Icons.check_box_outline_blank, size: 25, color: Colors.black45,),
                      title: Text(extractedSkills[0].subCategories[index].title, style: Theme.of(context).textTheme.bodySmall,).tr(),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 20,),
                    ),),
                  SizedBox(
                    height: MediaQuery.of(context).size.width/ 30,
                  ),
                  Text(extractedSkills[1].title, style: Theme.of(context).textTheme.bodyLarge,),
                  SizedBox(
                    height: MediaQuery.of(context).size.width/ 30,
                  ),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: extractedSkills[1].subCategories.length,
                    itemBuilder: (ctx, index) => ListTile(
                      onTap: (){},
                      dense: true,
                      leading: const Icon(Icons.check_box_outline_blank, size: 25, color: Colors.black45,),
                      title: Text(extractedSkills[1].subCategories[index].title, style: Theme.of(context).textTheme.bodySmall,).tr(),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 20,),
                    ),),
                  SizedBox(
                    height: MediaQuery.of(context).size.width/ 30,
                  ),
                  Text(extractedSkills[2].title, style: Theme.of(context).textTheme.bodyMedium,),
                  SizedBox(
                    height: MediaQuery.of(context).size.width/ 30,
                  ),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: extractedSkills[2].subCategories.length,
                    itemBuilder: (ctx, index) => ListTile(
                      onTap: (){},
                      dense: true,
                      leading: const Icon(Icons.check_box_outline_blank, size: 25, color: Colors.black45,),
                      title: Text(extractedSkills[2].subCategories[index].title, style: Theme.of(context).textTheme.bodySmall,).tr(),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 20,),
                    ),),
                  SizedBox(
                    height: MediaQuery.of(context).size.width/ 30,
                  ),
                  Text(extractedSkills[3].title, style: Theme.of(context).textTheme.bodyMedium,),
                  SizedBox(
                    height: MediaQuery.of(context).size.width/ 30,
                  ),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: extractedSkills[3].subCategories.length,
                    itemBuilder: (ctx, index) => ListTile(
                      onTap: (){},
                      dense: true,
                      leading: const Icon(Icons.check_box_outline_blank, size: 25, color: Colors.black45,),
                      title: Text(extractedSkills[3].subCategories[index].title, style: Theme.of(context).textTheme.bodySmall,).tr(),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 20,),
                    ),),
                  SizedBox(
                    height: MediaQuery.of(context).size.width/ 30,
                  ),
                  Text(extractedSkills[4].title, style: Theme.of(context).textTheme.bodyMedium,),
                  SizedBox(
                    height: MediaQuery.of(context).size.width/ 30,
                  ),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: extractedSkills[4].subCategories.length,
                    itemBuilder: (ctx, index) => ListTile(
                      onTap: (){},
                      dense: true,
                      leading: const Icon(Icons.check_box_outline_blank, size: 25, color: Colors.black45,),
                      title: Text(extractedSkills[4].subCategories[index].title, style: Theme.of(context).textTheme.bodySmall,).tr(),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 20,),
                    ),),
                  SizedBox(
                    height: MediaQuery.of(context).size.width/ 30,
                  ),
                  Text(extractedSkills[5].title, style: Theme.of(context).textTheme.bodyMedium,),
                  SizedBox(
                    height: MediaQuery.of(context).size.width/ 30,
                  ),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: extractedSkills[5].subCategories.length,
                    itemBuilder: (ctx, index) => ListTile(
                      onTap: (){},
                      dense: true,
                      leading: const Icon(Icons.check_box_outline_blank, size: 25, color: Colors.black45,),
                      title: Text(extractedSkills[5].subCategories[index].title, style: Theme.of(context).textTheme.bodySmall,).tr(),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 20,),
                    ),),
                  SizedBox(
                    height: MediaQuery.of(context).size.width/ 30,
                  ),
                  Text(extractedSkills[6].title, style: Theme.of(context).textTheme.bodyMedium,),
                  SizedBox(
                    height: MediaQuery.of(context).size.width/ 30,
                  ),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: extractedSkills[6].subCategories.length,
                    itemBuilder: (ctx, index) => ListTile(
                      onTap: (){},
                      dense: true,
                      leading: const Icon(Icons.check_box_outline_blank, size: 25, color: Colors.black45,),
                      title: Text(extractedSkills[6].subCategories[index].title, style: Theme.of(context).textTheme.bodySmall,).tr(),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 20,),
                    ),),
                  SizedBox(
                    height: MediaQuery.of(context).size.width/ 30,
                  ),
                  Text(extractedSkills[7].title, style: Theme.of(context).textTheme.bodyMedium,),
                  SizedBox(
                    height: MediaQuery.of(context).size.width/ 30,
                  ),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: extractedSkills[7].subCategories.length,
                    itemBuilder: (ctx, index) => ListTile(
                      onTap: (){},
                      dense: true,
                      leading: const Icon(Icons.check_box_outline_blank, size: 25, color: Colors.black45,),
                      title: Text(extractedSkills[7].subCategories[index].title, style: Theme.of(context).textTheme.bodySmall,).tr(),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 20,),
                    ),),
                  SizedBox(
                    height: MediaQuery.of(context).size.width/ 30,
                  ),
                  Text(extractedSkills[8].title, style: Theme.of(context).textTheme.bodyMedium,),
                  SizedBox(
                    height: MediaQuery.of(context).size.width/ 30,
                  ),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: extractedSkills[8].subCategories.length,
                    itemBuilder: (ctx, index) => ListTile(
                      onTap: (){},
                      dense: true,
                      leading: const Icon(Icons.check_box_outline_blank, size: 25, color: Colors.black45,),
                      title: Text(extractedSkills[8].subCategories[index].title, style: Theme.of(context).textTheme.bodySmall,).tr(),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 20,),
                    ),),
                  SizedBox(
                    height: MediaQuery.of(context).size.width/ 30,
                  ),
                  Text(extractedSkills[9].title, style: Theme.of(context).textTheme.bodyMedium,),
                  SizedBox(
                    height: MediaQuery.of(context).size.width/ 30,
                  ),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: extractedSkills[9].subCategories.length,
                    itemBuilder: (ctx, index) => ListTile(
                      onTap: (){},
                      dense: true,
                      leading: const Icon(Icons.check_box_outline_blank, size: 25, color: Colors.black45,),
                      title: Text(extractedSkills[9].subCategories[index].title, style: Theme.of(context).textTheme.bodySmall,).tr(),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 20,),
                    ),),
                  SizedBox(
                    height: MediaQuery.of(context).size.width/ 30,
                  ),
                  Text(extractedSkills[10].title, style: Theme.of(context).textTheme.bodyMedium,),
                  SizedBox(
                    height: MediaQuery.of(context).size.width/ 30,
                  ),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: extractedSkills[10].subCategories.length,
                    itemBuilder: (ctx, index) => ListTile(
                      onTap: (){},
                      dense: true,
                      leading: const Icon(Icons.check_box_outline_blank, size: 25, color: Colors.black45,),
                      title: Text(extractedSkills[10].subCategories[index].title, style: Theme.of(context).textTheme.bodySmall,).tr(),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 20,),
                    ),),
                  SizedBox(
                    height: MediaQuery.of(context).size.width/ 30,
                  ),
                  Text(extractedSkills[11].title, style: Theme.of(context).textTheme.bodyMedium,),
                  SizedBox(
                    height: MediaQuery.of(context).size.width/ 30,
                  ),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: extractedSkills[11].subCategories.length,
                    itemBuilder: (ctx, index) => ListTile(
                      onTap: (){},
                      dense: true,
                      leading: const Icon(Icons.check_box_outline_blank, size: 25, color: Colors.black45,),
                      title: Text(extractedSkills[11].subCategories[index].title, style: Theme.of(context).textTheme.bodySmall,).tr(),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 20,),
                    ),),
                  SizedBox(
                    height: MediaQuery.of(context).size.width/ 30,
                  ),
                  Text(extractedSkills[12].title, style: Theme.of(context).textTheme.bodyMedium,),
                  SizedBox(
                    height: MediaQuery.of(context).size.width/ 30,
                  ),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: extractedSkills[12].subCategories.length,
                    itemBuilder: (ctx, index) => ListTile(
                      onTap: (){},
                      dense: true,
                      leading: const Icon(Icons.check_box_outline_blank, size: 25, color: Colors.black45,),
                      title: Text(extractedSkills[12].subCategories[index].title, style: Theme.of(context).textTheme.bodySmall,).tr(),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 20,),
                    ),),
                  SizedBox(
                    height: MediaQuery.of(context).size.width/ 30,
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
