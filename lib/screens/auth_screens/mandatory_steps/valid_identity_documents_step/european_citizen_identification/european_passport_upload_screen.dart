import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../providers/mandatory_steps_provider/european_identity_verification/european_identification.dart';
import '../../../../../widgets/const_widgets/custom_button.dart';

class EuropeanPassportUploadScreen extends StatelessWidget {
  const EuropeanPassportUploadScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final idVerificationData = Provider.of<EuropeanIdentificationProvider>(context);
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
                "European passport",
                style: Theme.of(context).textTheme.titleMedium,
              ).tr(),
              SizedBox(
                height: MediaQuery.of(context).size.width / 40,
              ),
              Text(
                "European passport",
                style: Theme.of(context).textTheme.labelMedium,
              ).tr(),
              SizedBox(
                height: MediaQuery.of(context).size.width / 40,
              ),
              Consumer<EuropeanIdentificationProvider>(
                builder: (_, idCardData, child) => SizedBox(
                  child: idCardData.singleSidePassportPick != null
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
                                    idCardData.singleSidePassportPick ?? "",
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
                                  idCardData.removePassport(1);
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
                            idCardData.showPickerFrontPassport(context, 0);
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
              SizedBox(
                height: MediaQuery.of(context).size.width / 1.8,
              ),
              const Divider(),
              if(idVerificationData.singleSidePassportPick != null)
              Consumer<EuropeanIdentificationProvider>(
                  builder: (_, passportVerification, child) =>
                      CustomButton(onPress: () {
                        passportVerification.confirmPassport(context);
                      }, buttonName: "Confirm")),
            ],
          ),
        ),
      ),
    );
  }
}
