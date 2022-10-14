import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../helper/routes.dart';
import '../../models/job_models/single_job_comments.dart';


class SingleJobCommentsProvider with ChangeNotifier {
  List<SingleJobCommentsModel>? singleJobComments;

  // Future<void> getSingleJobComments(jobId) async {
  //   final SharedPreferences sharePref = await SharedPreferences.getInstance();
  //   String? userToken = sharePref.getString('token');
  //   var response = await http.get(
  //     Uri.parse('${MyRoutes.BASEURL}/getComments/$jobId'),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //       'Accept': 'application/json',
  //       'Authorization': 'Bearer $userToken'
  //     },
  //   );
  //   if (response.statusCode == 200) {
  //     print('Single Job Comments Api is working perfectly.');
  //     singleJobComments = singleJobCommentsModelFromJson(response.body);
  //     notifyListeners();
  //   } else {
  //     print('Single Job Comments Api is not working correctly');
  //   }
  //   notifyListeners();
  // }
  //
  // void postSingleComment(BuildContext context, SingleJobCommentsModel sComments, int jobId) async {
  //   SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
  //   String? userToken = sharedPrefs.getString("token");
  //   var response = await http.post(
  //     Uri.parse('${MyRoutes.BASEURL}/comments'),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //       'Accept': 'application/json',
  //       'Authorization': 'Bearer ${userToken!}',
  //     },
  //     body: jsonEncode(<String, String>{
  //       'job_id': jobId.toString(),
  //       'comment': sComments.message
  //     }),
  //   );
  //   if (response.statusCode == 200) {
  //     final newComment = SingleJobCommentsModel(
  //         id: 0,
  //         userId: profileData!.userId,
  //         name: "${profileData.firstName} ${profileData.lastName}",
  //         image: profileData.image,
  //         message: sComments.message,
  //         date: sComments.date,
  //     );
  //     singleJobComments!.add(newComment);
  //     print("Comment Post API WORKS");
  //     notifyListeners();
  //   } else {
  //     print("Comment Post API NOT WORKS");
  //   }
  //   notifyListeners();
  // }
}
