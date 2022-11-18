import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../providers/accounts_providers/transaction_provider.dart';
import '../../widgets/chart_widget.dart';
import 'package:collection/collection.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    _tabController!.addListener(_handleTabSelection);
    super.initState();
  }

  _handleTabSelection() {
    if (_tabController!.indexIsChanging) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final transactionData = Provider.of<TransactionProvider>(context);
    final extractData = transactionData.transactionModel;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        title: Text(
          'Wallet',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        // actions: [
        //   Row(
        //     children: const <Widget>[
        //       Text(
        //         'Assistance',
        //         style: TextStyle(
        //           fontSize: 18,
        //           color: Colors.blue,
        //           fontWeight: FontWeight.w700,
        //           fontFamily: 'Cerebri Sans Bold',
        //         ),
        //       ),
        //       Icon(Icons.more_vert_rounded)
        //     ],
        //   ),
        // ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      extractData!.wallet,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 40,
                    ),
                    Text(
                      '€',
                      style: Theme.of(context).textTheme.titleLarge,
                    )
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width / 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'No amount to come',
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.black38,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Cerebri Sans Regular',
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 20,
                    ),
                    const Icon(
                      FontAwesomeIcons.circleQuestion,
                      color: Colors.black,
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width / 20,
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1.5,
                  height: MediaQuery.of(context).size.width / 5,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade300,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Icon(
                        Icons.add,
                        color: Colors.white70,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 40,
                      ),
                      const Text(
                        'Transfer my balance',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white70,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Cerebri Sans Regular',
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.width/40,),
                const LineChartWidget(),
                SizedBox(height: MediaQuery.of(context).size.width/40,),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.grey.shade200,
                  ),
                  child: TabBar(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    indicator: BoxDecoration(
                      border: Border.all(color: Colors.black26, width: 0.8),
                      borderRadius: BorderRadius.circular(5), // Creates border
                      color: Colors.white,
                    ),
                    controller: _tabController,
                    unselectedLabelColor: Colors.grey,
                    labelColor: Colors.black,
                    labelStyle: Theme.of(context).textTheme.bodySmall,
                    tabs: [
                      Tab(
                        child: Center(
                          child: const Text(
                            "Day",
                          ).tr(),
                        ),
                      ),
                      Tab(
                        child: Center(
                          child: const Text(
                            "Month",
                          ).tr(),
                        ),
                      ),
                      Tab(
                        child: Center(
                          child: const Text(
                            "Year",
                          ).tr(),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: extractData.transactions.length,
                        itemBuilder: (context, index) => Column(
                          children: [
                            ListTile(
                              horizontalTitleGap: 0,
                              leading: Text(
                                extractData.transactions[index].transactionId.toString(),
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                              title: Text(
                                extractData.transactions[index].jobTitle,
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                              subtitle: Text(
                                extractData.transactions[index].invoiceNo,
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                              trailing: Text(
                                extractData.transactions[index].jobberGet,
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                            ),
                            const Divider(),
                          ],
                        ),
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      controller: ScrollController(),
                      primary: false,
                      itemCount: 3,
                      itemBuilder: (context, index) => Column(
                        children: [
                          ListTile(
                            title: Text(
                              'IBFT BNP',
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            subtitle: Text(
                              'November',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            trailing: Text(
                              '€ 300',
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ),
                          const Divider(),
                        ],
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      controller: ScrollController(),
                      primary: false,
                      itemCount: 5,
                      itemBuilder: (context, index) => Column(
                        children: [
                          ListTile(
                            title: Text(
                              'IBFT BNP',
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            subtitle: Text(
                              '2022',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            trailing: Text(
                              '€ 300',
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ),
                          const Divider(),
                        ],
                      ),
                    ),
                  ][_tabController!.index],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
