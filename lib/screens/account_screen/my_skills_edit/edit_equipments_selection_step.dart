import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mister_jobby_jobber/models/my_skills_model/my_skills_model.dart';
import 'package:provider/provider.dart';

import '../../../providers/my_skills_provider/my_skills_provider.dart';

class EditEquipmentSelectionStep extends StatelessWidget {
  final MySkillsModel mySkillEquimpent;
  const EditEquipmentSelectionStep({
    Key? key,
    required this.mySkillEquimpent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mySkillsData = Provider.of<MySkillsProvider>(context, listen: true);

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Do you have equipment?",
            style: Theme.of(context).textTheme.titleMedium,
          ).tr(),
          SizedBox(
            height: MediaQuery.of(context).size.width / 40,
          ),
          if (mySkillEquimpent.mainCategoryId == 1) ...[
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: mySkillsData.equipmentList.length,
              itemBuilder: (ctx, index) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    onTap: () {
                      mySkillsData
                          .isAddedEquipments(mySkillsData.equipmentList[index]);
                      debugPrint(mySkillsData.tempEquipment.join(','));
                    },
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                    title: Text(
                      mySkillsData.equipmentList[index],
                      style: Theme.of(context).textTheme.bodySmall,
                    ).tr(),
                    trailing: Consumer<MySkillsProvider>(
                      builder: (_, equipmentData, child) => Container(
                        width: 20,
                        height: 20,
                        padding: const EdgeInsets.all(0.2),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: equipmentData.tempEquipment.contains(
                                    equipmentData.equipmentList[index])
                                ? Theme.of(context).primaryColor
                                : Colors.black,
                          ),
                          color: equipmentData.tempEquipment
                                  .contains(equipmentData.equipmentList[index])
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
          ] else if (mySkillEquimpent.mainCategoryId == 2) ...[
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: mySkillsData.jardinageEquipmentList.length,
              itemBuilder: (ctx, index) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    onTap: () {
                      mySkillsData.isAddedEquipments(
                          mySkillsData.jardinageEquipmentList[index]);
                      debugPrint(mySkillsData.tempEquipment.join(','));
                    },
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                    title: Text(
                      mySkillsData.jardinageEquipmentList[index],
                      style: Theme.of(context).textTheme.bodySmall,
                    ).tr(),
                    trailing: Consumer<MySkillsProvider>(
                      builder: (_, equipmentData, child) => Container(
                        width: 20,
                        height: 20,
                        padding: const EdgeInsets.all(0.2),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: equipmentData.tempEquipment.contains(
                                    equipmentData.jardinageEquipmentList[index])
                                ? Theme.of(context).primaryColor
                                : Colors.black,
                          ),
                          color: equipmentData.tempEquipment.contains(
                                  equipmentData.jardinageEquipmentList[index])
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
          ] else if (mySkillEquimpent.mainCategoryId == 3 ||
              mySkillEquimpent.mainCategoryId == 4 ||
              mySkillEquimpent.mainCategoryId == 8) ...[
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: mySkillsData.livraisonEquipmentList.length,
              itemBuilder: (ctx, index) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    onTap: () {
                      mySkillsData.isAddedEquipments(
                          mySkillsData.livraisonEquipmentList[index]);
                      debugPrint(mySkillsData.tempEquipment.join(','));
                    },
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                    title: Text(
                      mySkillsData.livraisonEquipmentList[index],
                      style: Theme.of(context).textTheme.bodySmall,
                    ).tr(),
                    trailing: Consumer<MySkillsProvider>(
                      builder: (_, equipmentData, child) => Container(
                        width: 20,
                        height: 20,
                        padding: const EdgeInsets.all(0.2),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: equipmentData.tempEquipment.contains(
                                    equipmentData.livraisonEquipmentList[index])
                                ? Theme.of(context).primaryColor
                                : Colors.black,
                          ),
                          color: equipmentData.tempEquipment.contains(
                                  equipmentData.livraisonEquipmentList[index])
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
          ] else if (mySkillEquimpent.mainCategoryId == 6) ...[
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: mySkillsData.animalEquipmentList.length,
              itemBuilder: (ctx, index) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    onTap: () {
                      mySkillsData.isAddedEquipments(
                          mySkillsData.animalEquipmentList[index]);
                      debugPrint(mySkillsData.tempEquipment.join(','));
                    },
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                    title: Text(
                      mySkillsData.animalEquipmentList[index],
                      style: Theme.of(context).textTheme.bodySmall,
                    ).tr(),
                    trailing: Consumer<MySkillsProvider>(
                      builder: (_, equipmentData, child) => Container(
                        width: 20,
                        height: 20,
                        padding: const EdgeInsets.all(0.2),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: equipmentData.tempEquipment.contains(
                                    equipmentData.animalEquipmentList[index])
                                ? Theme.of(context).primaryColor
                                : Colors.black,
                          ),
                          color: equipmentData.tempEquipment.contains(
                                  equipmentData.animalEquipmentList[index])
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
          ] else if (mySkillEquimpent.mainCategoryId == 7) ...[
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: mySkillsData.computerEquipmentList.length,
              itemBuilder: (ctx, index) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    onTap: () {
                      mySkillsData.isAddedEquipments(
                          mySkillsData.computerEquipmentList[index]);
                      debugPrint(mySkillsData.tempEquipment.join(','));
                    },
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                    title: Text(
                      mySkillsData.computerEquipmentList[index],
                      style: Theme.of(context).textTheme.bodySmall,
                    ).tr(),
                    trailing: Consumer<MySkillsProvider>(
                      builder: (_, equipmentData, child) => Container(
                        width: 20,
                        height: 20,
                        padding: const EdgeInsets.all(0.2),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: equipmentData.tempEquipment.contains(
                                    equipmentData.computerEquipmentList[index])
                                ? Theme.of(context).primaryColor
                                : Colors.black,
                          ),
                          color: equipmentData.tempEquipment.contains(
                                  equipmentData.computerEquipmentList[index])
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
          ] else ...[
            Text(
              "There is No Equipment list available",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ],
      ),
    );
  }
}
