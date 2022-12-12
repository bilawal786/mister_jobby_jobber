import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../providers/accounts_providers/about_provider/about_provider.dart';
import '../../../../providers/accounts_providers/terms_and_condition_provider/terms_and_condition_provider.dart';


class TermsAndCondition extends StatefulWidget {
  const TermsAndCondition({Key? key}) : super(key: key);

  @override
  State<TermsAndCondition> createState() => _TermsAndConditionState();
}

class _TermsAndConditionState extends State<TermsAndCondition> {
  var isInit = true;

  @override
  void didChangeDependencies() {
    if(isInit){
      Provider.of<TermsAndConditonProvider>(context).getTermsAndConditions();
      Provider.of<AboutProvider>(context).getAbout();
    }
    isInit = false;
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    final termsAndConditionData = Provider.of<TermsAndConditonProvider>(context, listen: false);
    final extractTermsAndCondition = termsAndConditionData.termsAndCondition;
    final aboutData = Provider.of<AboutProvider>(context, listen: false);
    final extractedAboutData = aboutData.about;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: false,
        title: Text("Terms and conditions", style: Theme.of(context).textTheme.bodyLarge,).tr(),

        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),
      body: SingleChildScrollView(
        child: extractTermsAndCondition == null ? const Center(child: CircularProgressIndicator()) : Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Image.asset("assets/images/appLogo.png", scale: 4)),
              Center(
                child: HtmlWidget(
                  extractTermsAndCondition!.terms,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width / 40,
              ),
              Card(
                child: Column(
                  children: [
                    Image.asset("assets/images/appLogo.png", scale: 4),
                    HtmlWidget(extractedAboutData!.copyright),
                    SizedBox(
                      height: MediaQuery.of(context).size.width / 40,
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      child: HtmlWidget(extractedAboutData.condition),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width / 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () async {
                            final Uri url = Uri.parse(
                                'https://facebook.com');
                            if (!await launchUrl(url,
                                mode: LaunchMode.externalApplication)) {
                              throw 'Could not launch $url';
                            }
                          },
                          child: Container(
                            height:
                            MediaQuery.of(context).size.height * .08,
                            width:
                            MediaQuery.of(context).size.height * .08,
                            decoration: BoxDecoration(
                              color: Colors.blue.shade50,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(Icons.facebook),
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            final Uri url = Uri.parse(
                                'https://instagram.com');
                            if (!await launchUrl(url,
                                mode: LaunchMode.externalApplication)) {
                              throw 'Could not launch $url';
                            }
                          },
                          child: Container(
                            height:
                            MediaQuery.of(context).size.height * .08,
                            width: MediaQuery.of(context).size.height * .08,
                            decoration: BoxDecoration(
                              color: Colors.red.shade50,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(FontAwesomeIcons.instagram),
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            final Uri url = Uri.parse(
                                'https://twitter.com');
                            if (!await launchUrl(url,
                                mode: LaunchMode.externalApplication)) {
                              throw 'Could not launch $url';
                            }
                          },
                          child: Container(
                            height:
                            MediaQuery.of(context).size.height * .08,
                            width: MediaQuery.of(context).size.height * .08,
                            decoration: BoxDecoration(
                              color: Colors.pink.shade50,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(FontAwesomeIcons.twitter),
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            final Uri url = Uri.parse(
                                'https://pinterest.com');
                            if (!await launchUrl(url,
                                mode: LaunchMode.externalApplication)) {
                              throw 'Could not launch $url';
                            }
                          },
                          child: Container(
                            height:
                            MediaQuery.of(context).size.height * .08,
                            width: MediaQuery.of(context).size.height * .08,
                            decoration: BoxDecoration(
                              color: Colors.green.shade50,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(FontAwesomeIcons.pinterest),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width / 40,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
