import 'package:flutter/material.dart';

class TermsAndCondition extends StatefulWidget {
  const TermsAndCondition({Key? key}) : super(key: key);

  @override
  State<TermsAndCondition> createState() => _TermsAndConditionState();
}

class _TermsAndConditionState extends State<TermsAndCondition> {
  @override
  Widget build(BuildContext context) {
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
          child: Column(
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "Nous sommes Ikae Digital, une équipe créative et professionnelle avec plus de 7 ans d'expérience chez Conception UI/UX et développement front-end. Nous apportons de la beauté au design. Nous sommes Ikae Digital, une équipe créative et professionnelle avec plus de 7 ans d'expérience chez Conception UI/UX et développement front-end. Nous apportons de la beauté au design. Nous sommes Ikae Digital, une équipe créative et professionnelle avec plus de 7 ans d'expérience chez Conception UI/UX et développement front-end. Nous apportons de la beauté au design. Nous sommes Ikae Digital, une équipe créative et professionnelle avec plus de 7 ans d'expérience chez Conception UI/UX et développement front-end. Nous apportons de la beauté au design. Nous sommes Ikae Digital, une équipe créative et professionnelle avec plus de 7 ans d'expérience chez Conception UI/UX et développement front-end. Nous apportons de la beauté au design. Nous sommes Ikae Digital, une équipe créative et professionnelle avec plus de 7 ans d'expérience chez Conception UI/UX et développement front-end. Nous apportons de la beauté au design.",
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
                      "Tous les droits sont réservés.",
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
                          child: const Icon(Icons.facebook),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * .08,
                          width: MediaQuery.of(context).size.height * .08,
                          decoration: BoxDecoration(
                            color: Colors.pink.shade50,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(Icons.facebook),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * .08,
                          width: MediaQuery.of(context).size.height * .08,
                          decoration: BoxDecoration(
                            color: Colors.green.shade50,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(Icons.facebook),
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
