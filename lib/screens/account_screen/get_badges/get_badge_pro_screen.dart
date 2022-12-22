import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mister_jobby_jobber/providers/accounts_providers/get_badges/get_badges_provider.dart';
import 'package:mister_jobby_jobber/widgets/const_widgets/custom_button.dart';
import 'package:provider/provider.dart';


class GetBadgeProScreen extends StatefulWidget {
  const GetBadgeProScreen({Key? key}) : super(key: key);

  @override
  State<GetBadgeProScreen> createState() => _GetBadgeProScreenState();
}

class _GetBadgeProScreenState extends State<GetBadgeProScreen> {
  final TextEditingController companyName = TextEditingController();
  final TextEditingController companyAddress = TextEditingController();
  final TextEditingController siret = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    companyName.dispose();
    companyAddress.dispose();
    siret.dispose();
    super.dispose();
  }

  void onFormSubmit(cName, cAddress, siret, vtype){
    final getBadgeData = Provider.of<GetBadgesProvider>(context, listen: false);
    var isValid = formKey.currentState!.validate();
    if (!isValid) {
      return ;
    }formKey.currentState!.save();
    getBadgeData.getBadges(context, cName, vtype, cAddress, siret);
  }

  @override
  Widget build(BuildContext context) {

    final getBadgeData = Provider.of<GetBadgesProvider>(context, listen: true);
        return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black,
          size: 25,
        ),
        title: Text(
          "Get Badge PRO",
          style: Theme.of(context).textTheme.titleMedium,
        ).tr(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Company Name",
                  style: Theme.of(context).textTheme.bodyMedium,
                ).tr(),
                SizedBox(
                  height: MediaQuery.of(context).size.width / 40,
                ),
                TextField(
                  controller: companyName,
                  style: Theme.of(context).textTheme.bodyMedium,
                  decoration: const InputDecoration(
                    hintText: "Company Name",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width / 40,
                ),
                Text(
                  "Number SIRET",
                  style: Theme.of(context).textTheme.bodyMedium,
                ).tr(),
                SizedBox(
                  height: MediaQuery.of(context).size.width / 40,
                ),
                TextField(
                  controller: siret,
                  style: Theme.of(context).textTheme.bodyMedium,
                  decoration: const InputDecoration(
                    hintText: "12345678912345",
                    border: OutlineInputBorder(),
                  ),
                  maxLength: 14,
                  keyboardType: TextInputType.number,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width / 40,
                ),
                Text(
                  "Billing address",
                  style: Theme.of(context).textTheme.bodyMedium,
                ).tr(),
                SizedBox(
                  height: MediaQuery.of(context).size.width / 40,
                ),
                TextField(
                  controller: companyAddress,
                  style: Theme.of(context).textTheme.bodyMedium,
                  decoration: const InputDecoration(
                    hintText: "Address",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width / 40,
                ),
                Text(
                  "VAT regime",
                  style: Theme.of(context).textTheme.bodyMedium,
                ).tr(),
                SizedBox(
                  height: MediaQuery.of(context).size.width / 40,
                ),
                Consumer<GetBadgesProvider>(builder: (context, value, child) => Column(children: [
                  RadioListTile(
                    contentPadding: EdgeInsets.zero,
                    value: 1,
                    groupValue: value.vtaRegime,
                    onChanged: (v) {
                      value.getRegime(v);
                    },
                    title: Text(
                      "Micro-enterprise scheme",
                      style: Theme.of(context).textTheme.bodySmall,
                    ).tr(),
                    subtitle: Text(
                      "Without VAT",
                      style: Theme.of(context).textTheme.labelMedium,
                    ).tr(),
                  ),
                  const Divider(),
                  RadioListTile(
                    contentPadding: EdgeInsets.zero,
                    value: 2,
                    groupValue: value.vtaRegime,
                    onChanged: (v) {
                      value.getRegime(v);
                    },
                    title: Text(
                      "Sole proprietorship scheme",
                      style: Theme.of(context).textTheme.bodySmall,
                    ).tr(),
                    subtitle: Text(
                      "subject to VAT",
                      style: Theme.of(context).textTheme.labelMedium,
                    ).tr(),
                  ),
                ],),),
                const Divider(),
                SizedBox(
                  height: MediaQuery.of(context).size.width / 20,
                ),
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 1.5,
                      child: Text(
                        "I declare to be covered by a professional insurance and I declare to mandate Netdistrict to establish, on my behalf, the invoices for the services that I will contract on the Mister Jobby platform.",
                        style: Theme.of(context).textTheme.labelMedium,
                        textAlign: TextAlign.justify,
                      ).tr(),
                    ),
                    const Spacer(),
                    Consumer<GetBadgesProvider>(
                      builder: (context, value, child) =>
                          Switch(value: value.switchValue, onChanged: (v) {
                            value.switchOn(v);
                          }),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width / 20,
                ),
                if(getBadgeData.switchValue != false && getBadgeData.vtaRegime != 0 && companyName.text != '' && companyAddress.text != ""  && siret.text != "")
                CustomButton(onPress: () {
                  onFormSubmit(companyName.text,companyAddress.text,siret.text,getBadgeData.regimeName);
                }, buttonName: "Confirm"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
