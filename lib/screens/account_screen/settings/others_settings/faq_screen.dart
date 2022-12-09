import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../providers/faq_provider.dart';

class FAQScreen extends StatefulWidget {
  const FAQScreen({Key? key}) : super(key: key);

  @override
  State<FAQScreen> createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  List<int> expansion = [];
  var isInit = true;

  @override
  void didChangeDependencies() {
    if(isInit){
      Provider.of<FAQProvider>(context).getFAQ();
    }
    isInit = false;
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    final faqData= Provider.of<FAQProvider>(context, listen: false);
    final extractedFaq = faqData.myFAQ;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text("FAQ".tr(),style: Theme.of(context).textTheme.bodyLarge,),
        centerTitle: false,
        iconTheme: Theme.of(context).iconTheme,
      ),
      body: SingleChildScrollView(
        child: extractedFaq == null ? const Center(child: CircularProgressIndicator(),):Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Card(
                child: ListTile(
                  onTap: () async {
                    String email = Uri.encodeComponent("info@misterjobby.com");
                    String subject = Uri.encodeComponent("Need Support ");
                    String body = Uri.encodeComponent("Hi! ");
                    print(subject); //output: Hello%20Flutter
                    Uri mail = Uri.parse("mailto:$email?subject=$subject&body=$body");
                    if (await launchUrl(mail)) {
                      //email app opened
                    }else{
                      //email app is not opened
                    }
                  },
                  contentPadding: const EdgeInsets.all(10),
                  title: Text(
                    "Email Support",
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  leading: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 0,
                          blurRadius: 1,
                          offset:
                          const Offset(1, 2), // changes position of shadow
                        ),
                      ],
                      color: Colors.amber,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.email_outlined,
                      size: 20,
                    ),
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios_outlined,
                    size: 20,
                  ),
                ),
              ),
              const Divider(thickness: 1),
              Consumer<FAQProvider>(
                builder: (index, faqData, child) => ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: faqData.myFAQ!.length,
                  itemBuilder: (ctx, index) => GestureDetector(
                    onTap: () {
                      faqData.expansionFunction(index);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(
                        top: 10,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 0,
                            blurRadius: 1,
                            offset: const Offset(
                                1, 2), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            color: faqData.expansion.contains(index)
                                ? Colors.grey.shade200
                                : Colors.white,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    faqData.myFAQ![index].question,
                                    style: Theme.of(context).textTheme.bodySmall,
                                  ),
                                ),
                                const Spacer(),
                                faqData.expansion.contains(index)
                                    ? const Icon(
                                  Icons.remove,
                                  size: 20,
                                )
                                    : const Icon(
                                  Icons.add,
                                  size: 20,
                                )
                              ],
                            ),
                          ),
                          faqData.expansion.contains(index)
                              ? Container(
                            padding: const EdgeInsets.all(10),
                            child: HtmlWidget(extractedFaq[index].answer),
                          )
                              : const SizedBox(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
