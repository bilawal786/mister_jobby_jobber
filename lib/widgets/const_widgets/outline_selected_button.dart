import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class OutlineSelectedButton extends StatelessWidget {
  final double height;
  final double? width;
  final String textTitle;
  final Function onTap;
  final bool border;
  final Color? color;
  const OutlineSelectedButton({
    required this.onTap,
    this.border =false,
    this.height = 50,
    this.width,
    this.color = Colors.white,
    required this.textTitle,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        margin:const EdgeInsets.only(left: 5,right: 5,),
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border:Border.all(color: border == false? Colors.transparent:Colors.blue),
          color: color,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(1, 2), // changes position of shadow
            ),
          ],
        ),
        child: Center(
          child: Text(
            textTitle,
            style: Theme.of(context).textTheme.bodyMedium,
          ).tr(),
        ),
      ),
    );
  }
}
