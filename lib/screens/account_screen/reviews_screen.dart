import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mister_jobby_jobber/helper/routes.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

import '../../providers/accounts_providers/all_reviews_provider.dart';

class ReviewsScreen extends StatelessWidget {
  const ReviewsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final reviewsData = Provider.of<AllReviewsProvider>(context);
    final extractData = reviewsData.allReviewsModel;
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
                        RichText(text: TextSpan(text: extractData!.rating.toString(),
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
                            for (int i = 0; i < 5; i++)
                              Icon(
                                Icons.star,
                                color: i == extractData.rating ? Colors.grey.shade300 : Colors.amber ,
                                size: 27,
                              ),
                          ],
                        ),
                        SizedBox(height: MediaQuery.of(context).size.width / 40,),
                        Text('Based on ${extractData.totalReviews} Reviews',
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
                          percent: extractData.stars5/extractData.totalReviews,
                          leading: Text('5 Star', style: Theme.of(context).textTheme.bodyMedium,),
                          barRadius: Radius.circular(20),
                          progressColor: Colors.amber,
                          backgroundColor: Colors.grey.shade300,
                        ),
                        LinearPercentIndicator(
                          width: MediaQuery.of(context).size.width/3.5,
                          lineHeight: 10.0,
                          percent: extractData.stars4/extractData.totalReviews,
                          leading: Text('4 Star', style: Theme.of(context).textTheme.bodyMedium,),
                          barRadius: Radius.circular(20),
                          backgroundColor: Colors.grey.shade300,
                          progressColor: Colors.amber,
                        ),
                        LinearPercentIndicator(
                          width: MediaQuery.of(context).size.width/3.5,
                          lineHeight: 10.0,
                          percent: extractData.stars3/extractData.totalReviews,
                          leading: Text('3 Star', style: Theme.of(context).textTheme.bodyMedium,),
                          barRadius: Radius.circular(20),
                          backgroundColor: Colors.grey.shade300,
                          progressColor: Colors.amber,
                        ),
                        LinearPercentIndicator(
                          width: MediaQuery.of(context).size.width/3.5,
                          lineHeight: 10.0,
                          percent: extractData.stars2/extractData.totalReviews,
                          leading: Text('2 Star', style: Theme.of(context).textTheme.bodyMedium,),
                          barRadius: Radius.circular(20),
                          backgroundColor: Colors.grey.shade300,
                          progressColor: Colors.amber,
                        ),
                        LinearPercentIndicator(
                          width: MediaQuery.of(context).size.width/3.5,
                          lineHeight: 10.0,
                          percent: extractData.stars1/extractData.totalReviews,
                          leading: Text('1 Star', style: Theme.of(context).textTheme.bodyMedium,),
                          barRadius: Radius.circular(20),
                          progressColor: Colors.amber,
                          backgroundColor: Colors.grey.shade300,
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
                itemCount: extractData.reviews.length,
                itemBuilder: (context, index) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
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
                          "${MyRoutes.IMAGEURL}${extractData.reviews[index].image}",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(extractData.reviews[index].name, style: Theme.of(context).textTheme.bodyMedium,),
                        Text(extractData.reviews[index].date, style: Theme.of(context).textTheme.labelSmall,),
                      ],
                    ),
                    subtitle: Row(children: <Widget>[
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          if(5 == 0)
                            const Icon(Icons.star, size: 15,),
                          for (int i = 0; i < extractData.reviews[index].star; i++)
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 15,
                            ),
                          SizedBox(width: MediaQuery.of(context).size.width/100,),
                          Text('(${extractData.reviews[index].star})',style:Theme.of(context).textTheme.bodySmall,),
                        ],
                      ),
                    ],),
                  ),
                  Text(extractData.reviews[index].message,
                    style: Theme.of(context).textTheme.labelMedium,),
                  const Divider(),
                ],),),
            ],),
        ),
      ),
    );
  }
}
