import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../helper/routes.dart';
import '../../../widgets/const_widgets/progress_indicator.dart';
import '../../check_profile_completion_provider/check_profile_completion_provider.dart';
import '../personal_information_provider/personal_information_provider.dart';

class EuropeanIdentificationProvider with ChangeNotifier {
  final picker = ImagePicker();
  String? singleSideIdCardPick;
  String? backIdCardPick;
  CroppedFile? getIdCard;
  CroppedFile? getBackIdCard;
  bool idCardPicked = false;

  void confirm(context) {
    if (singleSideIdCardPick != 'null' && backIdCardPick != 'null') {
      idCardPicked = true;
      notifyListeners();
      debugPrint('idCardPicked $idCardPicked');
      debugPrint('idCardFront $singleSideIdCardPick');
      debugPrint('idCardBack $backIdCardPick');
      Navigator.of(context).pop();
    }
  }

  void showPickerFrontIdCard(context, int index) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height / 5,
            margin: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Pick_Image_Title",
                  style: Theme.of(context).textTheme.titleSmall,
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
                        style: Theme.of(context).textTheme.bodySmall,
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
                        style: Theme.of(context).textTheme.bodySmall,
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
            height: MediaQuery.of(context).size.height / 5,
            margin: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Pick_Image_Title",
                  style: Theme.of(context).textTheme.titleSmall,
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
                        style: Theme.of(context).textTheme.bodySmall,
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
                        style: Theme.of(context).textTheme.bodySmall,
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

  // passport

  String? singleSidePassportPick;
  CroppedFile? getPassport;
  CroppedFile? getBackPassport;
  bool passportPicked = false;

  void confirmPassport(context) {
    if (singleSidePassportPick != 'null') {
      passportPicked = true;
      notifyListeners();
      debugPrint('passportPicked $passportPicked');
      debugPrint('passport $singleSidePassportPick');
      Navigator.of(context).pop();
    }
  }

  void showPickerFrontPassport(context, int index) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height / 5,
            margin: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Pick_Image_Title",
                  style: Theme.of(context).textTheme.titleSmall,
                ).tr(),
                const Divider(),
                InkWell(
                  onTap: () {
                    passportFromCamera(index);
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
                        style: Theme.of(context).textTheme.bodySmall,
                      ).tr(),
                    ],
                  ),
                ),
                const Divider(),
                InkWell(
                  onTap: () {
                    passportFromGallery(index);
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
                        style: Theme.of(context).textTheme.bodySmall,
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

  passportFromCamera(int index) async {
    XFile? pickedFile =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    getPassport =
        await ImageCropper().cropImage(sourcePath: pickedFile?.path ?? "");
    singleSidePassportPick = getPassport!.path;
    notifyListeners();
  }

  passportFromGallery(int index) async {
    XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    getPassport =
        await ImageCropper().cropImage(sourcePath: pickedFile?.path ?? "");
    singleSidePassportPick = getPassport!.path;
    notifyListeners();
  }

  void removePassport(index) {
    singleSidePassportPick = null;
    notifyListeners();
  }

  // Driving License

  String? singleSideLicensePick;
  String? backLicensePick;
  CroppedFile? getLicense;
  CroppedFile? getBackLicense;
  bool licensePicked = false;

  void confirmLicense(context) {
    if (singleSideLicensePick != 'null' && backLicensePick != 'null') {
      licensePicked = true;
      notifyListeners();
      debugPrint('licensePicked $licensePicked');
      debugPrint('licenseFront $singleSideLicensePick');
      debugPrint('licenseBack $backLicensePick');
      Navigator.of(context).pop();
    }
  }

  void showPickerFrontLicense(context, int index) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height / 5,
            margin: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Pick_Image_Title",
                  style: Theme.of(context).textTheme.titleSmall,
                ).tr(),
                const Divider(),
                InkWell(
                  onTap: () {
                    licenseFromCamera(index);
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
                        style: Theme.of(context).textTheme.bodySmall,
                      ).tr(),
                    ],
                  ),
                ),
                const Divider(),
                InkWell(
                  onTap: () {
                    licenseFromGallery(index);
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
                        style: Theme.of(context).textTheme.bodySmall,
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

  licenseFromCamera(int index) async {
    XFile? pickedFile =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    getLicense =
        await ImageCropper().cropImage(sourcePath: pickedFile?.path ?? "");
    singleSideLicensePick = getLicense!.path;
    notifyListeners();
  }

  licenseFromGallery(int index) async {
    XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    getLicense =
        await ImageCropper().cropImage(sourcePath: pickedFile?.path ?? "");
    singleSideLicensePick = getLicense!.path;
    notifyListeners();
  }

  void removeLicense(index) {
    singleSideLicensePick = null;
    notifyListeners();
  }

  void showPickerBackLicense(context, int index) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height / 5,
            margin: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Pick_Image_Title",
                  style: Theme.of(context).textTheme.titleSmall,
                ).tr(),
                const Divider(),
                InkWell(
                  onTap: () {
                    backLicenseFromCamera(index);
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
                        style: Theme.of(context).textTheme.bodySmall,
                      ).tr(),
                    ],
                  ),
                ),
                const Divider(),
                InkWell(
                  onTap: () {
                    backLicenseFromGallery(index);
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
                        style: Theme.of(context).textTheme.bodySmall,
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

  backLicenseFromCamera(int index) async {
    XFile? pickedFile =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    getBackLicense =
        await ImageCropper().cropImage(sourcePath: pickedFile?.path ?? "");
    backLicensePick = getBackLicense!.path;
    notifyListeners();
  }

  backLicenseFromGallery(int index) async {
    XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    getBackLicense =
        await ImageCropper().cropImage(sourcePath: pickedFile?.path ?? "");
    backLicensePick = getBackLicense!.path;
    notifyListeners();
  }

  void removeBackLicense(index) {
    backLicensePick = null;
    notifyListeners();
  }

  bool euroCompleted = false;

  Future<void> postEuropeanIdentificationDocuments(
    context,
    idCardFront,
    idCardBack,
    licenseFront,
    licenseBack,
    passport,
  ) async {
    showDialog(context: context, builder: (BuildContext context){
      return const LoginProgressIndicator();
    });
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    String? userToken = sharedPrefs.getString("token");
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $userToken',
    };
    var request = http.MultipartRequest(
      "POST",
      Uri.parse('${MyRoutes.BASEURL}/jobber/document'),
    );
    request.headers.addAll(headers);
    if (idCardFront != null) {
      request.files.add(
          await http.MultipartFile.fromPath('eu_id_card_front', idCardFront));
    }
    if (idCardBack != null) {
      request.files.add(
          await http.MultipartFile.fromPath('eu_id_card_back', idCardBack));
    }
    if (licenseFront != null) {
      request.files.add(await http.MultipartFile.fromPath(
          'eu_id_driving_front', licenseFront));
    }
    if (licenseBack != null) {
      request.files.add(
          await http.MultipartFile.fromPath('eu_id_driving_back', licenseBack));
    }
    if (passport != null) {
      request.files.add(
          await http.MultipartFile.fromPath('eu_id_passport_front', passport));
    }
    http.Response response =
        await http.Response.fromStream(await request.send());

    if (response.statusCode == 200) {
      debugPrint("European identification documents Posted successfully ");
      Provider.of<CheckProfileCompletionProvider>(context, listen: false)
          .getProfileCompletionData(context);
      Navigator.pop(context);
      Navigator.of(context)
          .popUntil(ModalRoute.withName(MyRoutes.MANDATORYSTEPSSCREENROUTE));
      Provider.of<PersonalInformationProvider>(context,listen: false).getProfile(context);
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          padding :const EdgeInsets.all(20.0),
          backgroundColor: const Color(0xFFebf9fe),
          content: Text(
            'European Identification Step Completed',
            style: Theme.of(context).textTheme.bodyMedium,
          ).tr(),
          duration: const Duration(
            seconds: 2,
          ),
        ),
      );
      euroCompleted = true;
    } else if(response.statusCode == 401){
      debugPrint('error: 401');
      Navigator.of(context).pushNamedAndRemoveUntil(MyRoutes.LOGINSCREENROUTE, (route) => false);
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          padding :const EdgeInsets.all(20.0),
          backgroundColor: const Color(0xFFebf9fe),
          content:  Text(
            'Session Expired...  Please Log-In',
            style: Theme.of(context).textTheme.bodyMedium,
          ).tr(),
          duration: const Duration(
            seconds: 2,
          ),
        ),
      );
    } else {
      Navigator.pop(context);
      debugPrint('European identification documents upload Failed');
      debugPrint(response.body);
    }
    notifyListeners();
  }
}
