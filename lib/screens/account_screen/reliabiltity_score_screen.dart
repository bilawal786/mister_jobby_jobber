import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ScoreScreen extends StatelessWidget {
  const ScoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'visibility score',
                    style: Theme.of(context).textTheme.titleLarge,
                  ).tr(),
                  SizedBox(
                    height: MediaQuery.of(context).size.width / 20,
                  ),
                  Center(
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 48,
                          color: Colors.orange.shade300,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Cerebri Sans Bold',
                        ),
                        children: [
                          const TextSpan(text: '0'),
                          WidgetSpan(
                            child: Transform.translate(
                              offset: const Offset(0.00, 5.0),
                              child: Text(
                                'pts',
                                style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.orange.shade300,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: 'Cerebri Sans Bold',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width / 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Container(
                          width: 60,
                          height: 8,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.red.shade300),
                        ),
                      ),
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.orange.shade300),
                        child: const Center(
                            child: Icon(
                          Icons.circle_sharp,
                          color: Colors.white,
                          size: 20,
                        )),
                      ),
                      Align(
                        widthFactor: 0.8,
                        child: Container(
                          width: 50,
                          height: 8,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.orange.shade300),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Container(
                          width: 60,
                          height: 8,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.green.shade300),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width / 20,
                  ),
                  Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width / 3,
                      height: MediaQuery.of(context).size.width / 7,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.orange.shade300),
                      child: Center(
                        child: Text(
                          'neutral',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ).tr(),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width / 20,
                  ),
                  const Text(
                    'your profile is placed just behind that of providers with a visibility score higher than yours',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black26,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Cerebri Sans bold',
                    ),
                    textAlign: TextAlign.center,
                  ).tr(),
                  SizedBox(
                    height: MediaQuery.of(context).size.width / 20,
                  ),
                  Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.5,
                      height: MediaQuery.of(context).size.width / 6,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey.shade200)),
                      child: Center(
                        child: Text(
                          'how it works ?',
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.blue.shade300,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Cerebri Sans Bold',
                          ),
                        ).tr(),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width / 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Icon(
                        Icons.visibility_off,
                        color: Colors.black26,
                        size: 18,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 40,
                      ),
                      const Text(
                        'the score is invisible to customers',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black26,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Cerebri Sans bold',
                        ),
                        textAlign: TextAlign.center,
                      ).tr(),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width / 20,
                  ),
                ],
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'point history',
                    style: Theme.of(context).textTheme.titleLarge,
                  ).tr(),
                  SizedBox(
                    height: MediaQuery.of(context).size.width / 40,
                  ),
                  const Text(
                    'you have not had any activity during the last two months',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black26,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Cerebri Sans bold',
                    ),
                  ).tr(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
