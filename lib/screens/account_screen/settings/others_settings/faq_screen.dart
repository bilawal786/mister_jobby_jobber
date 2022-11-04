import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../providers/faq_provider.dart';
import 'package:provider/provider.dart';

class FAQScreen extends StatefulWidget {
  const FAQScreen({Key? key}) : super(key: key);

  @override
  State<FAQScreen> createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  List<int> expansion = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text("FAQ".tr(),style: Theme.of(context).textTheme.titleSmall,),
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.black,
          size: 25,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Card(
                child: ListTile(
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
                            child: Text(
                              faqData.myFAQ![index].answer,
                              style:
                              Theme.of(context).textTheme.labelMedium,
                            ),
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
