import 'package:flutter/material.dart';

class LoginProgressIndicator extends StatelessWidget {

  const LoginProgressIndicator({Key? key,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xFFebf9fe),
      child: Container(
        margin: const EdgeInsets.all(15.0),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width/30,
              ),
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.black),
              ),
               SizedBox(
                width: MediaQuery.of(context).size.width/20,
              ),
              Text(
                'Please Wait...',style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
