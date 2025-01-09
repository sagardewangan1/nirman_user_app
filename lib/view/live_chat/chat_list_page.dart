import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer/service/live_chat/chat_list_service.dart';
import 'package:qixer/view/live_chat/chat_message_page.dart';
import 'package:qixer/view/live_chat/components/chat_search.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/constant_styles.dart';
import 'package:qixer/view/utils/others_helper.dart';
import 'package:qixer/view/utils/responsive.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatListPage extends StatefulWidget {
  const ChatListPage({super.key});

  @override
  State<ChatListPage> createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  final cc = ConstantColors();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: physicsCommon,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 17),
            child: Consumer<ChatListService>(
                builder: (context, provider, child) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                  padding: const EdgeInsets.only(
                                      right: 20, top: 20, bottom: 20),
                                  child: const Icon(Icons.arrow_back_ios)),
                            ),
                            Text(
                              lnProvider.getString("Conversations"),
                              style: const TextStyle(
                                  fontSize: 27, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        provider.isLoading == false
                            ? provider.chatList.isNotEmpty
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      //Search bar

                                      const SizedBox(
                                        height: 10,
                                      ),

                                      const ChatSearch(),

                                      const SizedBox(
                                        height: 20,
                                      ),

                                      for (int i = 0;
                                          i < provider.chatList.length;
                                          i++)
                                        InkWell(
                                          onTap: () async {
                                            SharedPreferences prefs =
                                                await SharedPreferences
                                                    .getInstance();
                                            var currentUserId =
                                                prefs.getInt('userId')!;

                                            //======>
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute<void>(
                                                builder:
                                                    (BuildContext context) =>
                                                        ChatMessagePage(
                                                  receiverId: provider
                                                      .chatList[i]
                                                      .sellerList
                                                      .id,
                                                  currentUserId: currentUserId,
                                                  userName: provider.chatList[i]
                                                      .sellerList.name,
                                                ),
                                              ),
                                            );
                                          },
                                          child: Column(
                                            children: [
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: Row(
                                                        children: <Widget>[
                                                          CircleAvatar(
                                                            backgroundImage: NetworkImage((provider
                                                                            .chatList[
                                                                                i]
                                                                            .imageUrl ??
                                                                        "")
                                                                    .isNotEmpty
                                                                ? provider
                                                                    .chatList[i]
                                                                    .imageUrl
                                                                : userPlaceHolderUrl),
                                                            maxRadius: 25,
                                                          ),
                                                          const SizedBox(
                                                            width: 16,
                                                          ),
                                                          Expanded(
                                                            child: Container(
                                                              color: Colors
                                                                  .transparent,
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: <Widget>[
                                                                  Text(
                                                                    (provider
                                                                            .chatList[i]
                                                                            .sellerList
                                                                            ?.name)
                                                                        .toString(),
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            16),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              CommonHelper().dividerCommon()
                                            ],
                                          ),
                                        ),
                                    ],
                                  )
                                : Container(
                                    height: screenHeight - 200,
                                    alignment: Alignment.center,
                                    child: Text(lnProvider.getString(
                                        "You don't have any active conversation")))
                            : SizedBox(
                                height: screenHeight - 200,
                                child:
                                    OthersHelper().showLoading(cc.primaryColor),
                              ),
                      ],
                    )),
          ),
        ),
      ),
    );
  }
}
