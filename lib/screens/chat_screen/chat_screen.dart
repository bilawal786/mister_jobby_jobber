
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mister_jobby_jobber/models/mandatory_steps_model/jobber_profile_model/jobber_profile_model.dart';
import 'package:provider/provider.dart';

import '../../helper/routes.dart';
// import '../../models/jobs_models/job_reservations_model.dart';
import '../../models/messages_model.dart';
import '../../providers/chat_provider.dart';
import '../../providers/mandatory_steps_provider/personal_information_provider/personal_information_provider.dart';
import 'message_card_widget.dart';

class ChatScreen extends StatefulWidget {
  final String demandeurId;
  final String demandeurName;
  final String demandeurImgUrl;
  const ChatScreen({Key? key, required this.demandeurId, required this.demandeurName, required this.demandeurImgUrl,}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  Messages? msg;
  List<Messages> _list = [];
  final textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final profileData = Provider.of<PersonalInformationProvider>(context, listen: false);
    final extractedData = profileData.profile;
    return Scaffold(
      backgroundColor: const Color(0xFFebf9fe),
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.black,
          size: 25,
        ),
        elevation: 0,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width * 0.1,
              height: MediaQuery.of(context).size.width * 0.1,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.black,
                  width: 1.2,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.network("${MyRoutes.IMAGEURL}/${widget.demandeurImgUrl}", fit: BoxFit.cover,),
              ),
            ),
            SizedBox(width: MediaQuery.of(context).size.width / 40,),
            Text(
              widget.demandeurName,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        )
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: getAllMessages(extractedData!),
              builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {
                switch (snapshot.connectionState) {
                //if data is loading
                  case ConnectionState.waiting:
                  case ConnectionState.none:
                    return const SizedBox();

                //if some or all data is loaded then show it
                  case ConnectionState.active:
                  case ConnectionState.done:
                    final data = snapshot.data?.docs;
                    // print(data.toString());
                    _list = data
                        ?.map((e) => Messages.fromJson(e.data() as Map<String, dynamic>))
                        .toList() ??
                        [];

                    if (_list.isNotEmpty) {
                      return ListView.builder(
                          itemCount: _list.length,
                          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * .01),
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return MessageCard(message: _list[index],);
                          });
                    } else {
                      return const Center(
                        child: Text('Say Hii! 👋',
                            style: TextStyle(fontSize: 20, color: Colors.blue)),
                      );
                    }
                }
              },
            ),
          ),
          _chatInput(extractedData.jobberId.toString())
        ],
      ),
    );
  }
  Widget _chatInput(id,) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.width * .01,
          horizontal: MediaQuery.of(context).size.width * .025),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                        padding: const  EdgeInsets.symmetric(horizontal: 10.0),
                        child: TextField(
                          controller: textController,
                          maxLines: null,
                          decoration: InputDecoration(
                            hintText: "Type something ....",
                            hintStyle: Theme.of(context).textTheme.bodyMedium,
                            border: InputBorder.none,
                          ),
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),),
                  ),
                  // IconButton(
                  //   onPressed: () {},
                  //   icon: const Icon(
                  //     CupertinoIcons.camera,
                  //     color: Colors.blueAccent,
                  //   ),
                  // ),
                  // IconButton(
                  //   onPressed: () {},
                  //   icon: const Icon(
                  //     Icons.image,
                  //     color: Colors.blueAccent,
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              final postChatData = Provider.of<ChatProvider>(context,listen: false);
              if(textController.text.isNotEmpty) {
                sendMessage(widget.demandeurId, id , textController.text);
                textController.text = '';
                if(_list.isEmpty) {
                  postChatData.postChatList(context, widget.demandeurId);
                }
              }
            },
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              minimumSize: const Size(0, 0),
              backgroundColor: Colors.green,
              padding: const EdgeInsets.only(
                  top: 10, bottom: 10, right: 5, left: 10),
            ),
            child: const Icon(
              Icons.send,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  // useful for getting conversation id
  String getConversationID(String jobberId) => widget.demandeurId.hashCode <= jobberId.hashCode
      ? '${widget.demandeurId}_$jobberId'
      : '${jobberId}_${widget.demandeurId}';

  // for getting all messages of a specific conversation from firestore database
  Stream<QuerySnapshot<Map<String, dynamic>>> getAllMessages(
      JobberProfileModel id) {
    return FirebaseFirestore.instance
        .collection('chats/${getConversationID(id.jobberId.toString())}/messages/')
        .snapshots();
  }

  // for sending message
  Future<void> sendMessage(String jobber, String profileId, String msg) async {
    //message sending time (also used as id)
    final time = DateTime.now().millisecondsSinceEpoch.toString();

    //message to send
    final Messages message = Messages(
        toId: jobber.toString(),
        msg: msg,
        read: '',
        fromId: profileId,
        sent: time);

    final ref = FirebaseFirestore.instance
        .collection('chats/${getConversationID(profileId)}/messages/');
    await ref.doc(time).set(message.toJson());
  }

}
