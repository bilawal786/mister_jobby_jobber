import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class SocialSecurityProvider with ChangeNotifier {
  final picker = ImagePicker();
  String? vitalCardPick;
  String? socialSecurityCardPick;
  CroppedFile? getVitalCard;
  CroppedFile? getSecurityCard;

  void showPickerVitalCard(context, int index) {
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
                    vitalCardFromCamera(index);
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
                    vitalCardFromGallery(index);
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

  vitalCardFromCamera(int index) async {
    XFile? pickedFile =
    await picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    getVitalCard =
    await ImageCropper().cropImage(sourcePath: pickedFile?.path ?? "");
    vitalCardPick = getVitalCard!.path;
    notifyListeners();
  }

  vitalCardFromGallery(int index) async {
    XFile? pickedFile =
    await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    getVitalCard =
    await ImageCropper().cropImage(sourcePath: pickedFile?.path ?? "");
    vitalCardPick = getVitalCard!.path;
    notifyListeners();
  }

  void removeVitalCard(index) {
    vitalCardPick = null;
    notifyListeners();
  }

  void showPickerSecurityCard(context, int index) {
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
                    securityCardFromCamera(index);
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
                    securityCardFromGallery(index);
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

  securityCardFromCamera(int index) async {
    XFile? pickedFile =
    await picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    getSecurityCard =
    await ImageCropper().cropImage(sourcePath: pickedFile?.path ?? "");
    socialSecurityCardPick = getSecurityCard!.path;
    notifyListeners();
  }

  securityCardFromGallery(int index) async {
    XFile? pickedFile =
    await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    getSecurityCard =
    await ImageCropper().cropImage(sourcePath: pickedFile?.path ?? "");
    socialSecurityCardPick = getSecurityCard!.path;
    notifyListeners();
  }

  void removeSecurityCard(index) {
    socialSecurityCardPick = null;
    notifyListeners();
  }

}