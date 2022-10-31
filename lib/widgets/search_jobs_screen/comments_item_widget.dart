import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../helper/routes.dart';
import '../../models/job_models/single_job_comments.dart';


class CommentsItemWidget extends StatelessWidget {
  const CommentsItemWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final comments = Provider.of<SingleJobCommentsModel>(context);
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width / 8,
                height: MediaQuery.of(context).size.width / 8,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black12,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.network(
                    "${MyRoutes.IMAGEURL}${comments.image}",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 40,
              ),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(comments.name, style: Theme.of(context).textTheme.bodyMedium,),
                        const Spacer(),
                        Text(comments.date, style: Theme.of(context).textTheme.labelMedium,),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width / 40,
                    ),
                    Text(
                      comments.message,
                      style: Theme.of(context).textTheme.bodySmall,
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const Divider(),
      ],
    );
  }
}
