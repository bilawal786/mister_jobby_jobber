import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import './index_screen.dart';

import '../../screens/chat_screen/message_screen.dart';
import '../../screens/search_screen/search_jobs_screen.dart';
import '../../screens/account_screen/account_screen.dart';

class HomeTabScreen extends StatefulWidget {
  const HomeTabScreen({Key? key}) : super(key: key);

  @override
  State<HomeTabScreen> createState() => _HomeTabScreenState();
}

class _HomeTabScreenState extends State<HomeTabScreen> {
  int pageIndex = 0;
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = const IndexScreen();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        bucket: bucket,
        child: currentScreen,
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        shape: const CircularNotchedRectangle(),
        notchMargin: 25,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              bottomTabBarItem(
                    () {
                  setState(() {
                    currentScreen =
                    const IndexScreen(); // if user taps on this dashboard tab will be active
                    pageIndex = 0;
                  });
                },
                Icons.home_rounded,
                "Home_AppBar_Title",
                0,
              ),
              bottomTabBarItem(
                    () {
                  setState(() {
                      currentScreen = const SearchJobScreen(); // if user taps on this dashboard tab will be active
                    pageIndex = 1;
                  });
                },
                Icons.work_history_outlined,
                "Search",
                1,
              ),
              bottomTabBarItem(
                    () {
                  setState(() {
                    currentScreen =
                    const MessagesScreen(); // if user taps on this dashboard tab will be active
                    pageIndex = 2;
                  });
                },
                Icons.mark_as_unread_outlined,
                "Chat",
                2,
              ),
              bottomTabBarItem(
                    () {
                  setState(() {
                    currentScreen =
                    const AccountScreen(); // if user taps on this dashboard tab will be active
                    pageIndex = 3;
                  });
                },
                Icons.person_outline,
                "Account",
                3,
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation:
      FloatingActionButtonLocation.miniCenterDocked,
    );
  }
  Widget bottomTabBarItem(
      VoidCallback onTap, IconData iconData, String title, int index) {
    return Expanded(
      child: MaterialButton(
        minWidth: 40,
        onPressed: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              iconData,
              size: 25,
              color: pageIndex == index
                  ? Colors.black
                  : Theme.of(context).iconTheme.color,
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                overflow: TextOverflow.ellipsis,
                fontFamily: 'Cerebri Sans Regular',
                color: pageIndex == index
                    ? Colors.black
                    : Theme.of(context).iconTheme.color,
              ),
            ).tr(),
          ],
        ),
      ),
    );
  }
}
