import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:mister_jobby_jobber/providers/const_provider/const_provider.dart';
import 'package:provider/provider.dart';

import '../../../../widgets/const_widgets/custom_button.dart';
import '../../../../models/mandatory_steps_model/indicate_skills_model/indicate_skills_model.dart';

class ChildSkillsScreen extends StatefulWidget {
  final SubCategory skillSubCategory;
  const ChildSkillsScreen({Key? key, required this.skillSubCategory})
      : super(key: key);

  @override
  State<ChildSkillsScreen> createState() => _ChildSkillsScreenState();
}

class _ChildSkillsScreenState extends State<ChildSkillsScreen> {


  @override
  Widget build(BuildContext context) {
    var getList  = Provider.of<ConstProvider>(context);
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
                itemCount: widget.skillSubCategory.childCategories.length,
                itemBuilder: (ctx, index) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      onTap: (){
                        getList.isAdded(widget.skillSubCategory.childCategories[index].id.toString());

                        debugPrint(getList.temp.join(","));
                      },
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                      title: Text(
                        widget.skillSubCategory.childCategories[index].title,
                        style: Theme.of(context).textTheme.bodySmall,
                      ).tr(),
                      trailing: Text(getList.temp.contains(widget.skillSubCategory.childCategories[index].id.toString()) ? "Remove" :"Add"),
                    ),
                    const Divider(),
                  ],
                ),
              ),
              CustomButton(onPress: () {
              }, buttonName: "Continue"),
            ],
          ),
        ),
      ),
    );
  }
}
