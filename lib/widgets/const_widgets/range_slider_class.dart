import 'package:flutter/material.dart';

class RangeSliderCLass extends StatefulWidget {
  double rangeValue;
  int division;
  void Function(double) onChanged;
  final double minRange;
  final double maxRange;
  RangeSliderCLass({
    Key? key,
    required this.onChanged,
    this.rangeValue = 100,
    this.division = 100,
    required this.minRange,
    required this.maxRange,
  }) : super(key: key);

  @override
  State<RangeSliderCLass> createState() => _RangeSliderCLassState();
}

class _RangeSliderCLassState extends State<RangeSliderCLass> {
  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        activeTrackColor: Theme.of(context).primaryColor,
        inactiveTrackColor: Colors.grey.shade200,
        thumbColor: Colors.blue.shade700,
        inactiveTickMarkColor: Colors.grey.shade200,
        activeTickMarkColor: Theme.of(context).primaryColor,
        thumbShape: const RoundSliderThumbShape(
          enabledThumbRadius: 7,
        ),
      ),
      child: Slider(
        label: "${widget.rangeValue.round()}",
        value: widget.rangeValue,
        divisions: widget.division,
        onChanged: widget.onChanged,
        min: widget.minRange,
        max: widget.maxRange,
      ),
    );
  }
}
