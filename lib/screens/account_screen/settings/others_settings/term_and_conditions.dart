import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
      Provider.of<TermsAndConditonProvider>(context, listen: false)
          .getTermsAndConditions();
    }
    isInit = false;
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    final termsAndConditionsData = Provider.of<TermsAndConditonProvider>(context);
    final extractTermsAndConditionData = termsAndConditionsData.termsAndCondition;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text("Terms and conditions", style: Theme.of(context).textTheme.titleMedium,),

        iconTheme: const IconThemeData(
            color: Colors.black,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: extractTermsAndConditionData == null ? const Center(child: CircularProgressIndicator(),) :Column(
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    extractTermsAndConditionData.terms,
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
                      extractTermsAndConditionData.privacy,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width / 40,
                    ),
                    Container(
                        margin: const EdgeInsets.all(10),
                        child: Text(
                          "Mister Jobby est une application de services mobiles polyvalents. Professionnellement construit avec un UX élevé pour donner à votre page\n                le grand regard.",
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
