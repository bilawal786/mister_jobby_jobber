import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/mandatory_steps_provider/social_security/social_security_provider.dart';
import '../../../../widgets/const_widgets/custom_button.dart';

class SocialSecurityCertificateUpload extends StatelessWidget {
  const SocialSecurityCertificateUpload({Key? key}) : super(key: key);

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
                "Social security certificate",
                style: Theme.of(context).textTheme.titleMedium,
              ).tr(),
              SizedBox(
                height: MediaQuery.of(context).size.width / 40,
              ),
              Text(
                "Social security certificate",
                style: Theme.of(context).textTheme.labelMedium,
              ).tr(),
              SizedBox(
                height: MediaQuery.of(context).size.width / 40,
              ),
              Consumer<SocialSecurityProvider>(
                builder: (_, idCardData, child) => SizedBox(
                  child: idCardData.socialSecurityCardPick != null
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
                                    idCardData.socialSecurityCardPick ?? "",
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
                                  idCardData.removeSecurityCard(1);
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
                            idCardData.showPickerSecurityCard(context, 0);
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
              ).tr(),
              SizedBox(
                height: MediaQuery.of(context).size.width / 40,
              ),
              Consumer<SocialSecurityProvider>(
                builder:(_,security,child) => Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(7.0),
                  ),
                  child: TextFormField(
                    initialValue: security.securityCardNumber,
                    onChanged: (value){
                      security.securityCardNumber = value;
                    },
                    decoration: const InputDecoration(
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
                ).tr(),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: (securityData.socialSecurityCardPick != null && securityData.securityCardNumber != null) ?BottomAppBar(elevation: 20,
      child: Padding(padding: const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
      child: CustomButton(onPress: () {
        securityData.confirmSecurityCard(context);
      }, buttonName: "Confirm"),
      ),
      ) : const SizedBox(),
    );
  }
}
