import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mister_jobby_jobber/providers/jobs_providers/area_of_intervention_provider/area_intervention_provider.dart';
import 'package:provider/provider.dart';
import 'package:searchfield/searchfield.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

import '../../models/coordinates_model.dart';

class GooglePlacesApi extends StatefulWidget {
  const GooglePlacesApi({Key? key}) : super(key: key);

  @override
  State<GooglePlacesApi> createState() => _GooglePlacesApiState();
}

class _GooglePlacesApiState extends State<GooglePlacesApi> {
  TextEditingController searchController = TextEditingController();
  var uuid = const Uuid();
  String _sessionToken = '123456';
  List<dynamic> _placesList = [];
  @override
  void initState() {
    super.initState();

    searchController.addListener(() {
      onChange();
    });
  }

  void onChange() {
    if (_sessionToken == 'null') {
      setState(() {
        _sessionToken = uuid.v4();
      });
    }

    getSuggestion(searchController.text);
  }

  void getSuggestion(String input) async {
    String kPLACESAPIKEY = "AIzaSyAeKxMwTMJzHH2AR1xt7OLWIWFMIzm-JLM&libraries";
    String gBASEURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String requestUrl =
        '$gBASEURL?input=$input&key=$kPLACESAPIKEY&sessiontoken=$_sessionToken';

    var response = await http.get(Uri.parse(requestUrl));

    if (response.statusCode == 200) {
      setState(() {
        _placesList = jsonDecode(response.body.toString())['predictions'];
      });
    } else {
      throw Exception('failed to load data google api data');
    }
    // print(response.body.toString());
  }


  CoordinatesModel? getCoordinates;

  Future<void> getLatLngGeoCodingApi(String address) async {
    String geoCodingApiKey = "AIzaSyAeKxMwTMJzHH2AR1xt7OLWIWFMIzm-JLM&libraries";
    String geoCodingBaseUrl = "https://maps.googleapis.com/maps/api/geocode/json";
    String requestUrl = "$geoCodingBaseUrl?address=$address&key=$geoCodingApiKey";
    var response = await http.get(Uri.parse(requestUrl));
    if(response.statusCode == 200){
      setState(() {
        getCoordinates = CoordinatesModel.fromJson(jsonDecode(response.body));
      });
      // print("response : ${response.body}");
    }
  }
  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  double longitude = 0.0;
  double latitude = 0.0;
  String address = "";
  @override
  Widget build(BuildContext context) {
    final searchData = Provider.of<AreaInterventionProvider>(context, listen: false);
    return SearchField(
      controller: searchController,
      hint: 'Find_Address'.tr(),
      searchStyle: Theme.of(context).textTheme.bodySmall,
      searchInputDecoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade500, width: 1),
          borderRadius: BorderRadius.circular(5.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:
          BorderSide(color: Theme.of(context).primaryColor, width: 1),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      itemHeight: MediaQuery.of(context).size.width / 10,
      maxSuggestionsInViewPort: _placesList.length,
      suggestionStyle: Theme.of(context).textTheme.bodySmall,
      suggestions: _placesList.map((e) {
        return SearchFieldListItem(
          e['description'],
          item: e,
        );
      }).toList(),
      onSuggestionTap: (p0) async {
        FocusScope.of(context).unfocus();
        getLatLngGeoCodingApi(searchController.text).then((value) {
          searchData.getAddress(
            address = searchController.text,
            longitude = getCoordinates!.results[0].geometry.location.lng,
            latitude = getCoordinates!.results[0].geometry.location.lat,
          );
          debugPrint("\n \n \n \n ");
          debugPrint("full address : $address");
          debugPrint("latitude:  $latitude");
          debugPrint("longitude: $longitude");
        });
        // List<Location> location = await locationFromAddress(searchController.text);

      },
    );
  }
}
