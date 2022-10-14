import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/job_models/single_job_comments.dart';
import '../../providers/jobs_providers/single_job_comments_provider.dart';

class CommentInputWidget extends StatefulWidget {
  // final int jobId;
  const CommentInputWidget({Key? key,
    // required this.jobId
  }) : super(key: key);

  @override
  State<CommentInputWidget> createState() => _CommentInputWidgetState();
}

class _CommentInputWidgetState extends State<CommentInputWidget> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController commentController = TextEditingController();
  var _singleComment = SingleJobCommentsModel(
      id: 0, userId: 0, name: "", image: "", message: "", date: "");

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: TextFormField(
                controller: commentController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  labelText: "Comments".tr(),
                  isDense: true,
                ),
                style: Theme.of(context).textTheme.bodySmall,
                enabled: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return '';
                  }
                  return null;
                },
                onSaved: (value) {
                  _singleComment = SingleJobCommentsModel(
                    id: _singleComment.id,
                    userId: _singleComment.userId,
                    name: _singleComment.name,
                    image: _singleComment.image,
                    message: value!,
                    date: _singleComment.date,
                  );
                },
              ),
            ),
            IconButton(
              onPressed: () {
                final isValid = _formKey.currentState?.validate();
                _formKey.currentState?.save();
                if (!isValid!) {
                  return;
                }
                // Provider.of<SingleJobCommentsProvider>(context, listen: false).postSingleComment(context, _singleComment, widget.jobId);
                commentController.text = "";
              },
              icon: Icon(
                Icons.send,
                size: 25,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
