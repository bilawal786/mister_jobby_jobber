import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart'as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../helper/routes.dart';
import '../../../widgets/const_widgets/progress_indicator.dart';
import '../../check_profile_completion_provider/check_profile_completion_provider.dart';

class SocialSecurityProvider with ChangeNotifier {
  final picker = ImagePicker();
  String? vitalCardPick;
  String? socialSecurityCardPick;
  CroppedFile? getVitalCard;
  CroppedFile? getSecurityCard;
  bool vitalCardPicked = false;
  bool securityCardPicked = false;

  String? vitalCardNumber;
  String? securityCardNumber;

  void confirmVitalCard(context){
    if(vitalCardPick != null && vitalCardNumber != null){
      vitalCardPicked= true;
      notifyListeners();
      debugPrint('vitalCardPicked $vitalCardPicked');
      debugPrint('VitalCard $vitalCardPick');
      debugPrint('VitalCard Number $vitalCardNumber');
      Navigator.of(context).pop();
    }
  }

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


  void confirmSecurityCard(context){
    if(socialSecurityCardPick != null && securityCardNumber != null){
      securityCardPicked = true;
      notifyListeners();
      debugPrint('securityPicked $vitalCardPicked');
      debugPrint('securityCard $socialSecurityCardPick');
      debugPrint('securityCard Number $securityCardNumber');
      Navigator.of(context).pop();
    }
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

  bool securityCompleted = false;

  Future<void> postSecurityCertificates (context, vitalCard, vitalCardNumber, securityCertificate, securityCertificateNumber,) async {
    showDialog(context: context, builder: (BuildContext context){
      return const LoginProgressIndicator();
    });
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
      Uri.parse('${MyRoutes.BASEURL}/jobber/security/document'),
    );
    request.headers.addAll(headers);
    if (vitalCard != null) {
      request.files.add(await http.MultipartFile.fromPath('vital_card', vitalCard));
    }
    if (securityCertificate != null) {
      request.files.add(await http.MultipartFile.fromPath('social_security_certificate', securityCertificate));
    }

    request.fields['vital_card_number']= vitalCardNumber;
    request.fields['social_security_number']= securityCertificateNumber;

    http.Response response = await http.Response.fromStream(await request.send());

    if (response.statusCode == 200) {
      debugPrint("Non-European identification documents Posted successfully ");
      Provider.of<CheckProfileCompletionProvider>(context, listen: false)
          .getProfileCompletionData();
      Navigator.pop(context);
      Navigator.of(context)
          .popUntil(ModalRoute.withName(MyRoutes.MANDATORYSTEPSSCREENROUTE));
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.blueGrey,
          content: Text(
            'Security Identification Step Completed',
            // textAlign: TextAlign.center,
          ),
          duration: Duration(
            seconds: 2,
          ),
        ),
      );
      securityCompleted = true;
    } else {
      Navigator.pop(context);
      debugPrint('Non-European identification documents upload Failed');
      debugPrint(response.body);
    }
    if (kDebugMode) {
      print(response.request);
    }
    notifyListeners();
  }

}