import 'package:flutter/material.dart';

import '../../helper/routes.dart';

class JobbyProfile extends StatelessWidget {
  final String demanderImgUrl;
  final String demanderName;
  final String demanderLName;
  final String memberSince;
  final String demands;
  final String reservations;
  final String evaluations;
  const JobbyProfile({Key? key, required this.demanderImgUrl, required this.demanderName, required this.demanderLName, required this.memberSince, required this.demands, required this.reservations, required this.evaluations, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(backgroundColor: Colors.white,
    foregroundColor: Colors.black,
      elevation: 0,
    ),
    body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width / 3.5,
            height: MediaQuery.of(context).size.width / 3.5,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.black38,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(200),
              child: Image.network(
                "${MyRoutes.IMAGEURL}$demanderImgUrl",
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.width / 40,
          ),
          Text(
            "$demanderName $demanderLName",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.width / 40,
          ),
          Text(
            memberSince,
            style: Theme.of(context).textTheme.labelMedium,
          ),
            SizedBox(
              height: MediaQuery.of(context).size.width / 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
            Container(
              width: MediaQuery.of(context).size.width / 3.5,
              height: MediaQuery.of(context).size.width / 3.5,
              decoration: BoxDecoration(color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              Text(
                demands,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                "Demandes",
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ],),),
              Container(
                width: MediaQuery.of(context).size.width / 3.5,
                height: MediaQuery.of(context).size.width / 3.5,
                decoration: BoxDecoration(color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      reservations,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      "Reservation",
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ],),),
              Container(
                width: MediaQuery.of(context).size.width / 3.5,
                height: MediaQuery.of(context).size.width / 3.5,
                decoration: BoxDecoration(color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      evaluations,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      "Evaluation",
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ],),),
            ],),
        ],
        ),
      ),
    ),
    );
  }
}
