import 'package:flutter/material.dart';
import 'package:mister_jobby_jobber/providers/accounts_providers/about_provider/about_provider.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  var isInit = true;
  @override
  void didChangeDependencies() {
    if(isInit){
      Provider.of<AboutProvider>(context).getAbout();
    }
    isInit = false;
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    final aboutData = Provider.of<AboutProvider>(context, listen: false);
    final extractedAbout = aboutData.about;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text("About Us", style: Theme.of(context).textTheme.titleMedium,),

        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),
      body: SingleChildScrollView(
        child: extractedAbout == null ? const Center(child: CircularProgressIndicator(),):Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    extractedAbout.description,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width / 40,
              ),
              Card(
                child: Column(
                  children: [
                    Image.asset("assets/images/appLogo.png", scale: 4),
                    Text(
                      extractedAbout.copyright,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width / 40,
                    ),
                    Container(
                        margin: const EdgeInsets.all(10),
                        child: Text(
                          extractedAbout.condition,
                          style: Theme.of(context).textTheme.bodySmall,
                        )),
                    SizedBox(
                      height: MediaQuery.of(context).size.width / 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * .08,
                          width: MediaQuery.of(context).size.height * .08,
                          decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child:const Icon(Icons.facebook),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * .08,
                          width: MediaQuery.of(context).size.height * .08,
                          decoration: BoxDecoration(
                            color: Colors.red.shade50,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(FontAwesomeIcons.instagram),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * .08,
                          width: MediaQuery.of(context).size.height * .08,
                          decoration: BoxDecoration(
                            color: Colors.pink.shade50,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(FontAwesomeIcons.twitter),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * .08,
                          width: MediaQuery.of(context).size.height * .08,
                          decoration: BoxDecoration(
                            color: Colors.green.shade50,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(FontAwesomeIcons.pinterest),
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
