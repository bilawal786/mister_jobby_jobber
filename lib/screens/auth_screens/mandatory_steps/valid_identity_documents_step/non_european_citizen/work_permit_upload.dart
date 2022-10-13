import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../providers/mandatory_steps_provider/european_identity_verification/european_identification.dart';
import '../../../../../widgets/const_widgets/custom_button.dart';

class WorkPermitUpload extends StatelessWidget {
  const WorkPermitUpload({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                "Work permit or Residence permit with work authorization",
                style: Theme.of(context).textTheme.titleMedium,
              ),
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
                  "To be able to work on the territory the mention \"work\" must be written on your residence permit",
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width / 40,
              ),
              Text(
                "Work permit or residence permit front",
                style: Theme.of(context).textTheme.labelMedium,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width / 40,
              ),
              Consumer<EuropeanIdentificationProvider>(
                builder: (_, idCardData, child) => SizedBox(
                  child: idCardData.singleSideIdCardPick != null
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
                              idCardData.singleSideIdCardPick ?? "",
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
                            idCardData.removeIdCard(1);
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
                      idCardData.showPickerFrontIdCard(context, 0);
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
                "Work permit or residence permit on the back",
                style: Theme.of(context).textTheme.labelMedium,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width / 40,
              ),
              Consumer<EuropeanIdentificationProvider>(
                builder: (_, idCardData, child) => SizedBox(
                  child: idCardData.backIdCardPick != null
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
                              idCardData.backIdCardPick ?? "",
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
                            idCardData.removeBackIdCard(1);
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
                      idCardData.showPickerBackIdCard(context, 0);
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
                title: Text("We are unable to accept:",style: Theme.of(context).textTheme.bodySmall,),
                subtitle: Text(
                  " - Student residence permit \n "
                      " - Commercial residence permit \n ",
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width / 40,
              ),
              const Divider(),
              CustomButton(onPress: () {}, buttonName: "Confirm"),
            ],
          ),
        ),
      ),
    );
  }
}
