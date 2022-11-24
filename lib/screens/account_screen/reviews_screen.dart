import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ReviewsScreen extends StatelessWidget {
  const ReviewsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        title: Text('Reviews', style: Theme.of(context).textTheme.titleSmall,),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width/2.5,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                  color: Colors.grey.shade200,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        RichText(text: TextSpan(text: '4.5',
                          style: Theme.of(context).textTheme.titleLarge,
                          children: [
                            WidgetSpan(child: Text(' /',
                              style:Theme.of(context).textTheme.bodyMedium,),),
                            WidgetSpan(
                              child: Transform.translate(
                                offset: const Offset(-1.0, 4.5),
                                child: Text('5',
                                  style:Theme.of(context).textTheme.bodyMedium,),
                              ),
                            ),],),),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            if(5 == 0)
                              const Icon(Icons.star, size: 27,),
                            for (int i = 0; i < 5; i++)
                              const Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 27,
                              ),
                          ],
                        ),
                        SizedBox(height: MediaQuery.of(context).size.width / 40,),
                        Text('Based on 100 Reviews',
                          style: Theme.of(context).textTheme.labelMedium,).tr(),
                      ],),
                    const Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        LinearPercentIndicator(
                          width: MediaQuery.of(context).size.width/3.5,
                          lineHeight: 10.0,
                          percent: 1.0,
                          leading: Text('5 Star', style: Theme.of(context).textTheme.bodyMedium,),
                          barRadius: Radius.circular(20),
                          progressColor: Colors.amber,
                          backgroundColor: Colors.grey.shade200,
                        ),
                        LinearPercentIndicator(
                          width: MediaQuery.of(context).size.width/3.5,
                          lineHeight: 10.0,
                          percent: 0.85,
                          leading: Text('4 Star', style: Theme.of(context).textTheme.bodyMedium,),
                          barRadius: Radius.circular(20),
                          backgroundColor: Colors.grey.shade200,
                          progressColor: Colors.amber,
                        ),
                        LinearPercentIndicator(
                          width: MediaQuery.of(context).size.width/3.5,
                          lineHeight: 10.0,
                          percent: 0.7,
                          leading: Text('3 Star', style: Theme.of(context).textTheme.bodyMedium,),
                          barRadius: Radius.circular(20),
                          backgroundColor: Colors.grey.shade200,
                          progressColor: Colors.amber,
                        ),
                        LinearPercentIndicator(
                          width: MediaQuery.of(context).size.width/3.5,
                          lineHeight: 10.0,
                          percent: 0.6,
                          leading: Text('2 Star', style: Theme.of(context).textTheme.bodyMedium,),
                          barRadius: Radius.circular(20),
                          backgroundColor: Colors.grey.shade200,
                          progressColor: Colors.amber,
                        ),
                        LinearPercentIndicator(
                          width: MediaQuery.of(context).size.width/3.5,
                          lineHeight: 10.0,
                          percent: 0.5,
                          leading: Text('1 Star', style: Theme.of(context).textTheme.bodyMedium,),
                          barRadius: Radius.circular(20),
                          progressColor: Colors.amber,
                          backgroundColor: Colors.grey.shade200,
                        ),
                      ],),
                  ],),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.width / 40,),
              const Divider(),
              SizedBox(height: MediaQuery.of(context).size.width / 40,),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 1,
                itemBuilder: (context, index) => Column(children: <Widget>[
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.black38,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(35),
                        child: Image.network(
                          "https://www.hayalanka.com/wp-content/uploads/2017/07/avtar-image.jpg",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    title: Text('Frank Garrett', style: Theme.of(context).textTheme.bodyMedium,),
                    subtitle: Row(children: <Widget>[
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          if(5 == 0)
                            const Icon(Icons.star, size: 27,),
                          for (int i = 0; i < 5; i++)
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 27,
                            ),
                          SizedBox(width: MediaQuery.of(context).size.width/100,),
                          Text('(5)',style:Theme.of(context).textTheme.bodyMedium,),
                        ],
                      ),
                      const Spacer(),
                      Text('1 day ago', style: Theme.of(context).textTheme.labelMedium,),
                    ],),
                  ),
                  Text('Furniture repair man was great, his work is excelent, having latest tools and techonology, satisified with his work he must be recommended',
                    style: Theme.of(context).textTheme.labelMedium,),
                  const Divider(),
                ],),),
            ],),
        ),
      ),
    );
  }
}
