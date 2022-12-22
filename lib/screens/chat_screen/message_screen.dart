import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';

import '../../helper/routes.dart';
import '../../providers/chat_provider.dart';
import '../../widgets/const_widgets/custom_button.dart';
import '../home_screens/home_tab_screen.dart';
import 'chat_screen.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({Key? key}) : super(key: key);

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  var isInit = true;

  @override
  void didChangeDependencies() {
    if (isInit) {
      Provider.of<ChatProvider>(context).getChatList();
    }
    isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final chatList = Provider.of<ChatProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: Theme.of(context).iconTheme,
        elevation: 0,
        title: Text(
          "Chats_AppBar_Title",
          style: Theme.of(context).textTheme.titleLarge,
        ).tr(),
      ),
      body: chatList.chatList == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
        onRefresh: ()async{
          await Provider.of<ChatProvider>(context, listen: false).getChatList();
        },
            child: chatList.chatList!.isNotEmpty ? ListView.builder(
                padding: const EdgeInsets.all(10.0),
                itemCount: chatList.chatList?.length,
                itemBuilder: (ctx, index) => GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) => ChatScreen(
                              demandeurId: chatList.chatList![index].demandeurId
                                  .toString(),
                              demandeurImgUrl: chatList.chatList![index].image,
                              demandeurName:
                                  "${chatList.chatList![index].firstName} ${chatList.chatList![index].lastName}",
                            )));
                  },
                  child: Card(
                    elevation: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width * 0.15,
                            height: MediaQuery.of(context).size.width * 0.15,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.black,
                                width: 1.2,
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.network(
                                "${MyRoutes.IMAGEURL}/${chatList.chatList![index].image}",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 40,
                          ),
                          Text(
                            "${chatList.chatList![index].firstName} ${chatList.chatList![index].lastName}",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          const Spacer(),
                          const Icon(
                            Icons.arrow_forward_ios,
                            size: 20,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ): Container(
              padding: const EdgeInsets.all(40.0),
              margin: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 100,
                  ),
                  Icon(
                    Icons.mark_as_unread_outlined,
                    size: 150,
                    color: Theme.of(context).primaryColor,
                  ),
                  Text(
                    "Chats_Page_Title",
                    style: Theme.of(context).textTheme.titleSmall,
                  ).tr(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 40,
                  ),
                  Text(
                    "Chats_Page_Description",
                    style: Theme.of(context).textTheme.labelLarge,
                    textAlign: TextAlign.center,
                  ).tr(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 40,
                  ),
                  CustomButton(
                    onPress: () {
                      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (ctx)=> HomeTabScreen(pageIndex: 0,)), (route) => false);
                    },
                    buttonName: "I_need_a_favor",
                    elevation: 8,
                  ),
                ],
              ),
            ),
          ),
    );
  }
}
