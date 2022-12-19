import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart'as http;
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../helper/routes.dart';
import '../../check_profile_completion_provider/check_profile_completion_provider.dart';
import '../personal_information_provider/personal_information_provider.dart';

class NonEuroIdentificationProvider with ChangeNotifier {
  final picker = ImagePicker();
  String? singleSideWorkPermitPick;
  String? backWorkPermitPick;
  CroppedFile? getWorkPermit;
  CroppedFile? getBackWorkPermit;
  bool workPermitPicked = false;

  void confirmWorkPermit(context){
    if(singleSideWorkPermitPick != null && backWorkPermitPick != null){
      workPermitPicked= true;
      notifyListeners();
      debugPrint('workPermitPicked $workPermitPicked');
      debugPrint('workPermitFront $singleSideWorkPermitPick');
      debugPrint('workPermitBack $backWorkPermitPick');
      Navigator.of(context).pop();
    }
  }

  void showPickerFrontWorkPermit(context, int index) {
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
                    workPermitFromCamera(index);
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
                    workPermitFromGallery(index);
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

  workPermitFromCamera(int index) async {
    XFile? pickedFile =
    await picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    getWorkPermit =
    await ImageCropper().cropImage(sourcePath: pickedFile?.path ?? "");
    singleSideWorkPermitPick = getWorkPermit!.path;
    notifyListeners();
  }

  workPermitFromGallery(int index) async {
    XFile? pickedFile =
    await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    getWorkPermit =
    await ImageCropper().cropImage(sourcePath: pickedFile?.path ?? "");
    singleSideWorkPermitPick = getWorkPermit!.path;
    notifyListeners();
  }

  void removeWorkPermit(index) {
    singleSideWorkPermitPick = null;
    notifyListeners();
  }

  void showPickerBackWorkPermit(context, int index) {
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
                    backWorkPermitFromCamera(index);
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
                    backWorkPermitFromGallery(index);
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

  backWorkPermitFromCamera(int index) async {
    XFile? pickedFile =
    await picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    getBackWorkPermit =
    await ImageCropper().cropImage(sourcePath: pickedFile?.path ?? "");
    backWorkPermitPick = getBackWorkPermit!.path;
    notifyListeners();
  }

  backWorkPermitFromGallery(int index) async {
    XFile? pickedFile =
    await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    getBackWorkPermit =
    await ImageCropper().cropImage(sourcePath: pickedFile?.path ?? "");
    backWorkPermitPick = getBackWorkPermit!.path;
    notifyListeners();
  }

  void removeBackWorkPermit(index) {
    backWorkPermitPick = null;
    notifyListeners();
  }

  bool nonEuroCompleted = false;

  Future<void> postEuropeanIdentificationDocuments (context,workPermitFront, workPermitBack) async {

    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    String? userToken = sharedPrefs.getString("token");
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization':
      'Bearer $userToken',
    };
    var request = http.MultipartRequest(
      "POST",
      Uri.parse('${MyRoutes.BASEURL}/jobber/document'),
    );
    request.headers.addAll(headers);
    if (workPermitFront != null) {
      request.files.add(await http.MultipartFile.fromPath('eu_id_residence_permit_front', workPermitFront));
    }
    if (workPermitBack != null) {
      request.files.add(await http.MultipartFile.fromPath('eu_residence_permit_back', workPermitBack));
    }
    http.Response response = await http.Response.fromStream(await request.send());

    if (response.statusCode == 200) {
      debugPrint("Non-European identification documents Posted successfully ");
      Provider.of<CheckProfileCompletionProvider>(context, listen: false).getProfileCompletionData(context);
      Provider.of<PersonalInformationProvider>(context,listen: false).getProfile(context);
      Navigator.pop(context);
      Navigator.of(context).popUntil(ModalRoute.withName(MyRoutes.MANDATORYSTEPSSCREENROUTE));
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          padding :const EdgeInsets.all(20.0),
          backgroundColor: const Color(0xFFebf9fe),
          content: Text(
            'Non-European Identification Step Completed',
            style: Theme.of(context).textTheme.bodyMedium,
          ).tr(),
          duration: const Duration(
            seconds: 2,
          ),
        ),
      );
      nonEuroCompleted = true;
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
    }else {
      debugPrint('Non-European identification documents upload Failed');
      debugPrint(response.body);
      Provider.of<CheckProfileCompletionProvider>(context, listen: false)
          .getProfileCompletionData(context);
      Navigator.pop(context);
      Navigator.of(context)
          .popUntil(ModalRoute.withName(MyRoutes.MANDATORYSTEPSSCREENROUTE));
    }
    if (kDebugMode) {
      print(response.request);
    }
    notifyListeners();
  }
}