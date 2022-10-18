import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ConstProvider with ChangeNotifier {
  int mondayValue = 0;
  int tuesdayValue = 0;
  int wednesdayValue = 0;
  int thursdayValue = 0;
  int fridayValue = 0;
  int saturdayValue = 0;
  int sundayValue = 0;

  void checkMondayValue(int? value, BuildContext context) {
    mondayValue = value!;
    Navigator.pop(context);
    notifyListeners();
  }

  void checkTuesdayValue(int? value, BuildContext context) {
    tuesdayValue = value!;
    Navigator.pop(context);
    notifyListeners();
  }

  void checkWednesdayValue(int? value, BuildContext context) {
    wednesdayValue = value!;
    Navigator.pop(context);
    notifyListeners();
  }
  void checkThursdayValue(int? value, BuildContext context) {
    thursdayValue = value!;
    Navigator.pop(context);
    notifyListeners();
  }

  void checkFridayValue(int? value, BuildContext context) {
    fridayValue = value!;
    Navigator.pop(context);
    notifyListeners();
  }
  void checkSaturdayValue(int? value, BuildContext context) {
    saturdayValue = value!;
    Navigator.pop(context);
    notifyListeners();
  }
  void checkSundayValue(int? value, BuildContext context) {
    sundayValue = value!;
    Navigator.pop(context);
    notifyListeners();
  }

  int questionOneValue = 0;
  int questionTwoValue = 0;
  int questionThreeValue = 0;

  void checkQuestionOneGroupValue(int? value) {
    questionOneValue = value!;
    notifyListeners();
  }

  void checkQuestionTwoGroupValue(int? value) {
    questionTwoValue = value!;
    notifyListeners();
  }

  void checkQuestionThreeGroupValue(int? value) {
    questionThreeValue = value!;
    notifyListeners();
  }

  bool trustMisterJobby = false;
  bool cashNotRequired = false;

  void checkStatusTrust(value) {
    trustMisterJobby = value;
    notifyListeners();
  }

  void checkCashRequiredStatus(value) {
    cashNotRequired = value;
    notifyListeners();
  }

  final picker = ImagePicker();
  String? profilePick;
  CroppedFile? getImage;

  void showPicker(context, int index) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Container(
            height: MediaQuery
                .of(context)
                .size
                .height / 5,
            margin: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Pick_Image_Title",
                  style: Theme
                      .of(context)
                      .textTheme
                      .titleSmall,
                ).tr(),
                const Divider(),
                InkWell(
                  onTap: () {
                    imgFromCameraJob(index);
                    Navigator.of(context).pop();
                  },
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 15,
                      ),
                      const Icon(
                        Icons.camera_alt,
                        color: Colors.black,
                        size: 25,
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Text(
                        "Pick_Image_From_Camera_Title",
                        style: Theme
                            .of(context)
                            .textTheme
                            .bodySmall,
                      ).tr(),
                    ],
                  ),
                ),
                const Divider(),
                InkWell(
                  onTap: () {
                    imgFromGalleryJob(index);
                    Navigator.of(context).pop();
                  },
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 15,
                      ),
                      const Icon(
                        Icons.file_copy,
                        color: Colors.black,
                        size: 25,
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Text(
                        "Pick_Image_From_Gallery_Title",
                        style: Theme
                            .of(context)
                            .textTheme
                            .bodySmall,
                      ).tr(),
                    ],
                  ),
                ),
                const Divider(),
              ],
            ),
          ),
        );
      },
    );
  }

  imgFromCameraJob(int index) async {
    XFile? pickedFile =
    await picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    getImage =
    await ImageCropper().cropImage(sourcePath: pickedFile?.path ?? "");
    profilePick = getImage!.path;
    notifyListeners();
  }

  imgFromGalleryJob(int index) async {
    XFile? pickedFile =
    await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    getImage =
    await ImageCropper().cropImage(sourcePath: pickedFile?.path ?? "");
    profilePick = getImage!.path;
    notifyListeners();
  }

  void removeImage(index) {
    profilePick = null;
    notifyListeners();
  }

  int europeanCitizen = 0;
  String isEuropeanCitizen = "";

  void europeanCitizenFunction(int index) {
    europeanCitizen = index + 1;
    if (europeanCitizen == 1) {
      isEuropeanCitizen = "Yes".tr();
    } else {
      isEuropeanCitizen = "No".tr();
    }
    notifyListeners();
  }



  String completeAddress = "";
  double longitude = 0;
  double latitude = 0;

  void getAddress(address, long, lat) {
    completeAddress = address;
    longitude = long;
    latitude = lat;
    notifyListeners();
  }



  List? skillsId;
  @override
  void notifyListeners() {
    skillsId;
    super.notifyListeners();
  }

}