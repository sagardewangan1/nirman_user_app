import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:qixer/model/chat_list_model.dart';
import 'package:qixer/service/common_service.dart';
import 'package:qixer/view/utils/others_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatListService with ChangeNotifier {
  var chatList = [];
  List chatListImage = [];
  List storeChatList = [];
  List storeChatListImage = [];

  bool isLoading = false;

  setLoadingStatus(bool status) {
    isLoading = status;
    notifyListeners();
  }

  setLoadedChatList() {
    chatList = storeChatList;
    chatListImage = storeChatListImage;
    notifyListeners();
  }

  fetchChatList(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    var header = {
      //if header type is application/json then the data should be in jsonEncode method
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };

    var connection = await checkConnection();
    if (!connection) {
      return;
    }

    setLoadingStatus(true);

    var response = await http.get(Uri.parse("$baseApi/user/chat/seller-lists"),
        headers: header);

    setLoadingStatus(false);

    chatList = [];
    chatListImage = [];
    storeChatList = [];
    storeChatListImage = [];

    if (response.statusCode == 201 &&
        jsonDecode(response.body)['chat_seller_lists'].isNotEmpty) {
      final data = ChatListModel.fromJson(jsonDecode(response.body));

      chatList = data.chatSellerLists;
      try {
        chatListImage = jsonDecode(response.body)['seller_image'];
      } catch (e) {}
      storeChatList = chatList;
      storeChatListImage = chatListImage;
      chatList.removeWhere((c) => c.sellerList == null);
      notifyListeners();

      return true;
    } else {
      debugPrint(response.body.toString());
      return false;
    }
  }

  ///Search user
  ///===============>
  searchUser(String searchString) {
    chatList = [];
    chatListImage = [];

    for (int i = 0; i < storeChatList.length; i++) {
      if ((storeChatList[i].sellerList.name.toLowerCase())
          .contains(searchString.toLowerCase())) {
        chatList.add(storeChatList[i]);

        if (storeChatListImage[i] is List) {
          //if api returned empty array then in image we insert empty array
          //because, in frontend we validate image based on the empty array
          chatListImage.add([]);
        } else {
          chatListImage.add(storeChatListImage[i]);
        }
      }
    }
    notifyListeners();
  }
}
