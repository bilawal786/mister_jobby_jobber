import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mister_jobby_jobber/providers/const_provider/const_provider.dart';
import 'package:provider/provider.dart';

class EquipmentSelectionStep extends StatelessWidget {
  const EquipmentSelectionStep({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final equipmentData = Provider.of<ConstProvider>(context, listen: false);
    final extractEquipments = equipmentData.equipmentList;
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
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: extractEquipments.length,
            itemBuilder: (ctx, index) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  onTap: () {
                    equipmentData.isAddedEquipments(extractEquipments[index]);
                  },
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                  title: Text(
                    extractEquipments[index],
                    style: Theme.of(context).textTheme.bodySmall,
                  ).tr(),
                  trailing: Consumer<ConstProvider>(
                    builder: (_, equipmentData, child) => Container(
                      width: 20,
                      height: 20,
                      padding: const EdgeInsets.all(0.2),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: equipmentData.tempEquipment
                                  .contains(extractEquipments[index])
                              ? Theme.of(context).primaryColor
                              : Colors.black,
                        ),
                        color: equipmentData.tempEquipment
                                .contains(extractEquipments[index])
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
      ),
    );
  }
}
