import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../helper/routes.dart';
import '../../../../providers/const_provider/const_provider.dart';

import '../../../../widgets/const_widgets/outline_selected_button.dart';
import '../../../../widgets/const_widgets/custom_button.dart';

class ValidIdentityDocuments extends StatelessWidget {
  const ValidIdentityDocuments({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final citizenData = Provider.of<ConstProvider>(context, listen: false);
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
                "Are you a citizen of European nationality?",
                style: Theme.of(context).textTheme.titleMedium,
              ).tr(),
              SizedBox(
                height: MediaQuery.of(context).size.width / 20,
              ),
              Consumer<ConstProvider>(
                builder: (_, isEuropean, child) => SizedBox(
                  height: MediaQuery.of(context).size.width / 2.25,
                  child: ListView.builder(
                    itemCount: 2,
                    itemExtent: MediaQuery.of(context).size.width / 5,
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) => Container(
                      margin: const EdgeInsets.all(10),
                      child: OutlineSelectedButton(
                        onTap: () =>
                            isEuropean.europeanCitizenFunction(index),
                        textTitle: index == 0 ? "Yes" : "No",
                        color: isEuropean.europeanCitizen - 1 == index
                            ? Colors.blue.shade50
                            : Colors.grey.shade300,
                        border: isEuropean.europeanCitizen - 1 == index
                            ? true
                            : false,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(elevation: 20, child:
      Padding(padding: const EdgeInsets.only(left: 30,right: 30, top: 10, bottom: 10),
          child: CustomButton(onPress: (){
            if(citizenData.europeanCitizen == 1) {
              print("yes");
              Navigator.of(context).pushNamed(MyRoutes.EUROPEANCITIZENIDENTIFICATIONROUTE);
            }else{
              print("No");
              Navigator.of(context).pushNamed(MyRoutes.NONEUROPEANCITIZENROUTE);
            }
          }, buttonName: "Continue"),),),
    );
  }
}
