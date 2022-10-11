import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:easy_localization/easy_localization.dart';

class EuropeanIdentificationProvider with ChangeNotifier {

  final picker = ImagePicker();
  String? singleSideIdCardPick;
  String? backIdCardPick;
  CroppedFile? getIdCard;
  CroppedFile? getBackIdCard;

  void showPickerFrontIdCard(context, int index) {
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
                    idCardFromCamera(index);
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
                    idCardFromGallery(index);
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

  idCardFromCamera(int index) async {
    XFile? pickedFile =
    await picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    getIdCard =
    await ImageCropper().cropImage(sourcePath: pickedFile?.path ?? "");
    singleSideIdCardPick = getIdCard!.path;
    notifyListeners();
  }

  idCardFromGallery(int index) async {
    XFile? pickedFile =
    await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    getIdCard =
    await ImageCropper().cropImage(sourcePath: pickedFile?.path ?? "");
    singleSideIdCardPick = getIdCard!.path;
    notifyListeners();
  }

  void removeIdCard(index) {
    singleSideIdCardPick = null;
    notifyListeners();
  }

  void showPickerBackIdCard(context, int index) {
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
                    backIdCardFromCamera(index);
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
                    backIdCardFromGallery(index);
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

  backIdCardFromCamera(int index) async {
    XFile? pickedFile =
    await picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    getBackIdCard =
    await ImageCropper().cropImage(sourcePath: pickedFile?.path ?? "");
    backIdCardPick = getBackIdCard!.path;
    notifyListeners();
  }

  backIdCardFromGallery(int index) async {
    XFile? pickedFile =
    await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    getBackIdCard =
    await ImageCropper().cropImage(sourcePath: pickedFile?.path ?? "");
    backIdCardPick = getBackIdCard!.path;
    notifyListeners();
  }

  void removeBackIdCard(index) {
    backIdCardPick = null;
    notifyListeners();
  }
}