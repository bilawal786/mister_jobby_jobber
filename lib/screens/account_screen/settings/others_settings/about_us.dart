import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../providers/accounts_providers/about_provider/about_provider.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  var isInit = true;

  @override
  void didChangeDependencies() {
    if (isInit) {
      Provider.of<AboutProvider>(context).getAbout();
    }
    isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final aboutData = Provider.of<AboutProvider>(context, listen: false);
    final extratedAboutData = aboutData.about;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "About_Us".tr(),
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        centerTitle: false,
        iconTheme: Theme.of(context).iconTheme,
      ),
      body: SingleChildScrollView(
        child: extratedAboutData == null
            ? const Center(
          child: CircularProgressIndicator(),
        )
            : Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: HtmlWidget(extratedAboutData.description),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width / 40,
              ),
              Card(
                child: Column(
                  children: [
                    Image.asset("assets/images/appLogo.png", scale: 4),
                    HtmlWidget(extratedAboutData.copyright),
                    SizedBox(
                      height: MediaQuery.of(context).size.width / 40,
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      child: HtmlWidget(extratedAboutData.condition),
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
