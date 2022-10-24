import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/jobs_providers/area_of_intervention_provider/area_intervention_provider.dart';

import '../../widgets/const_widgets/range_slider_class.dart';
import '../../widgets/const_widgets/custom_button.dart';
import '../../widgets/const_widgets/places_selected_input_widget.dart';

class AreaOfInterventionScreen extends StatelessWidget {
  const AreaOfInterventionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final setArea =
        Provider.of<AreaInterventionProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(
          size: 25,
          color: Colors.black,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Define your area of intervention",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width / 20,
              ),
              Text(
                "Only the jobs present in this zone will be in your job list.",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width / 20,
              ),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.location_on,
                    color: Theme.of(context).primaryColor,
                    size: 25,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 20,
                  ),
                  Text(
                    "Address",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width / 40,
              ),
              const GooglePlacesApi(),
              SizedBox(
                height: MediaQuery.of(context).size.width / 40,
              ),
              const Divider(),
              SizedBox(
                height: MediaQuery.of(context).size.width / 20,
              ),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.sports_volleyball_outlined,
                    color: Theme.of(context).primaryColor,
                    size: 25,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 20,
                  ),
                  Text(
                    "Intervention radius",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width / 40,
              ),
              Consumer<AreaInterventionProvider>(
                builder: (_, selectArea, child) => Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      selectArea.interventionArea.toString(),
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.cast_outlined,
                          color: Theme.of(context).primaryColor,
                          size: 25,
                        ),
                        Expanded(
                          child: RangeSliderCLass(
                            rangeValue: selectArea.interventionArea,
                            minRange: 1,
                            maxRange: 50,
                            division: 49,
                            onChanged: (value) =>
                                selectArea.radiusOfIntervention(value),
                          ),
                        ),
                        Icon(
                          Icons.cast_connected,
                          color: Theme.of(context).primaryColor,
                          size: 25,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Divider(),
              SizedBox(
                height: MediaQuery.of(context).size.width / 2.5,
              ),
              const Divider(),
              CustomButton(
                  onPress: () {
                    setArea.setAreaIntervention(
                      context,
                      setArea.latitude,
                      setArea.longitude,
                      setArea.interventionArea,
                      setArea.completeAddress,
                    );
                  },
                  buttonName: "Set Area"),
            ],
          ),
        ),
      ),
    );
  }
}
