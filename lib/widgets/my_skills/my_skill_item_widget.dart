import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../helper/routes.dart';
import '../../models/my_skills_model/my_skills_model.dart';
import '../../screens/account_screen/my_skills_edit/edit_my_skills_screen.dart';

class MySkillsItemWidget extends StatelessWidget {
  final MySkillsModel mySkillsModel;
  final int index;
  const MySkillsItemWidget({Key? key, required this.mySkillsModel, required this.index,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.02),
      child: Card(
        elevation: 5,
        margin: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.05),
        child: Stack(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width * 0.5,
              decoration: BoxDecoration(
                color: Colors.green.shade100,
                borderRadius: BorderRadius.circular(
                  MediaQuery.of(context).size.width * 0.01,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                  MediaQuery.of(context).size.width * 0.005,
                ),
                child: Image(
                  colorBlendMode: BlendMode.srcOver,
                  filterQuality: FilterQuality.high,
                  color: Colors.black45,
                  image: NetworkImage(
                    "${MyRoutes.IMAGEURL}${mySkillsModel.image}",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                width: MediaQuery.of(context).size.width / 1.1,
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.04,
                  vertical: MediaQuery.of(context).size.width * 0.03,
                ),
                color: Colors.white54,
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      child: Text(mySkillsModel.subCategory,
                          style: Theme.of(context).textTheme.bodyLarge),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) => EditMySkillsScreen(
                              myskillsModel: mySkillsModel,
                              index: index,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.width * 0.02),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                          ),
                          color: Colors.white54,
                          borderRadius: BorderRadius.circular(
                            MediaQuery.of(context).size.width * 0.01,
                          ),
                        ),
                        child: Row(
                          children: <Widget>[
                            const Icon(CupertinoIcons.pen,
                                color: Colors.black, size: 18),
                            Text(
                              "Edit",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 5,
              child: Container(
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
                width: MediaQuery.of(context).size.width / 4,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(
                        MediaQuery.of(context).size.width * 0.01),
                    bottomRight: Radius.circular(
                        MediaQuery.of(context).size.width * 0.01),
                  ),
                ),
                child: Text(
                  mySkillsModel.mainCategory,
                  style: Theme.of(context).textTheme.bodyMedium,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
