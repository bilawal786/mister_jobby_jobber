import 'package:flutter/material.dart';
import 'package:mister_jobby_jobber/widgets/const_widgets/custom_button.dart';

import '../../../../widgets/const_widgets/places_selected_input_widget.dart';

class GetBadgeProScreen extends StatelessWidget {
  const GetBadgeProScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black45,
          size: 25,
        ),
        title: Text(
          "Get Badge PRO",
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Number SIRET",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width / 40,
              ),
              TextField(
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
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width / 40,
              ),
              const GooglePlacesApi(),
              SizedBox(
                height: MediaQuery.of(context).size.width / 40,
              ),
              Text(
                "VAT regime",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width / 40,
              ),
              RadioListTile(
                contentPadding: EdgeInsets.zero,
                value: 1,
                groupValue: 1,
                onChanged: (v) {},
                title: Text(
                  "Micro-enterprise scheme",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                subtitle: Text(
                  "Without VAT",
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),
              const Divider(),
              RadioListTile(
                contentPadding: EdgeInsets.zero,
                value: 2,
                groupValue: 1,
                onChanged: (v) {},
                title: Text(
                  "Sole proprietorship scheme",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                subtitle: Text(
                  "subject to VAT",
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),
              const Divider(),
              SizedBox(
                height: MediaQuery.of(context).size.width / 20,
              ),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 1.5,
                    child: Text(
                      "I declare to be covered by a professional insurance and "
                          "I declare to mandate Netdistrict to establish, on my behalf,"
                          " the invoices for the services that I will contract on the Mister Jobby platform.",
                      style: Theme.of(context).textTheme.labelMedium,
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  const Spacer(),
                  Switch(value: false, onChanged: (v){
                  }),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width / 4,
              ),
              CustomButton(onPress: (){}, buttonName: "Confirm"),
            ],
          ),
        ),
      ),
    );
  }
}
