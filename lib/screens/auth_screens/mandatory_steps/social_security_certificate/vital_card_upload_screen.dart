import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/mandatory_steps_provider/social_security/social_security_provider.dart';
import '../../../../widgets/const_widgets/custom_button.dart';

class VitalCardUpload extends StatelessWidget {
  const VitalCardUpload({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final securityData = Provider.of<SocialSecurityProvider>(context);
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
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Vital Card",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width / 40,
              ),
              Text(
                "Vital Card",
                style: Theme.of(context).textTheme.labelMedium,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width / 40,
              ),
              Consumer<SocialSecurityProvider>(
                builder: (_, idCardData, child) => SizedBox(
                  child: idCardData.vitalCardPick != null
                      ? Stack(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.width / 2,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.file(
                                  File(
                                    idCardData.vitalCardPick ?? "",
                                  ).absolute,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              right: 6,
                              top: 8,
                              child: InkWell(
                                onTap: () {
                                  idCardData.removeVitalCard(1);
                                },
                                child: Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade400,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.clear,
                                    size: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      : InkWell(
                          onTap: () {
                            idCardData.showPickerVitalCard(context, 0);
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.width / 2,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(7),
                              border: Border.all(
                                color: Colors.grey,
                                width: 1,
                              ),
                            ),
                            child: const Icon(Icons.camera_alt),
                          ),
                        ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width / 20,
              ),
              Text(
                "Social Security number",
                style: Theme.of(context).textTheme.labelMedium,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width / 40,
              ),
              Consumer<SocialSecurityProvider>(

                builder: (_,security,child) => Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(7.0),
                  ),
                  child: TextFormField(
                    initialValue: security.vitalCardNumber,
                    onChanged: (value) {
                      security.vitalCardNumber = value;
                    },
                    decoration:const InputDecoration(
                      focusedBorder: InputBorder.none,
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      contentPadding: EdgeInsets.all(10.0),
                    ),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ),
              const Divider(),
              SizedBox(
                height: MediaQuery.of(context).size.width / 40,
              ),
              ListTile(
                contentPadding: const EdgeInsets.all(10.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                dense: true,
                tileColor: Colors.amber.shade100,
                leading: const Icon(
                  Icons.circle_notifications,
                  color: Colors.black,
                ),
                subtitle: Text(
                  "These documents are necessary to validate your identity, your age, and your eligibility to work in the territory. They will never be made public.",
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width / 2.5,
              ),
              const Divider(),
              if(securityData.vitalCardNumber != null)
              CustomButton(onPress: () {
                securityData.confirmVitalCard(context);
              }, buttonName: "Confirm"),
            ],
          ),
        ),
      ),
    );
  }
}
