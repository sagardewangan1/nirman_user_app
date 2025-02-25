// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:qixer/model/chat_messages_model.dart';
import 'package:qixer/service/common_service.dart';
import 'package:qixer/service/profile_service.dart';
import 'package:qixer/service/push_notification_service.dart';
import 'package:qixer/view/utils/others_helper.dart';
import 'package:qixer/view/utils/responsive.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatMessagesService with ChangeNotifier {
  var messagesList;

  bool isloading = false;
  bool sendLoading = false;

  late int totalPages;
  int currentPage = 1;

  setCurrentPage(newValue) {
    currentPage = newValue;
    notifyListeners();
  }

  setTotalPage(newPageNumber) {
    totalPages = newPageNumber;
    notifyListeners();
  }

  setMessageListDefault() {
    messagesList = null;
    currentPage = 1;
  }

  setLoadingTrue() {
    isloading = true;
    notifyListeners();
  }

  setLoadingFalse() {
    isloading = false;
    notifyListeners();
  }

  setSendLoadingTrue() {
    sendLoading = true;
    notifyListeners();
  }

  setSendLoadingFalse() {
    sendLoading = false;
    notifyListeners();
  }

  final ImagePicker _picker = ImagePicker();
  Future pickImage() async {
    final XFile? imageFile =
        await _picker.pickImage(source: ImageSource.gallery);

    if (imageFile != null) {
      return imageFile;
    } else {
      return null;
    }
  }

  fetchMessages(context, {bool isrefresh = false, required receiverId}) async {
    setChatSellerId(receiverId);
    if (isrefresh) {
      //making the list empty first to show loading bar (we are showing loading bar while the product list is empty)
      //we are make the list empty when the sub category or brand is selected because then the refresh is true
      messagesList = null;

      setCurrentPage(1);
    } else {}

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('shashaktnirmantoken');

    var header = {
      //if header type is application/json then the data should be in jsonEncode method
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };

    var connection = await checkConnection();
    if (connection) {
      //if connection is ok

      var response = await http.get(
          Uri.parse(
              "$baseApi/user/chat/all-messages?to_user=$receiverId&page=$currentPage"),
          headers: header);

      if (response.statusCode == 200 &&
          jsonDecode(response.body)['messages']['data'].isNotEmpty) {
        var data = ChatMessagesModel.fromJson(jsonDecode(response.body));

        setTotalPage(data.messages.lastPage);

        //else add new data

        setMessageList(data.messages.data, receiverId);

        messagesList ??= [];
        currentPage++;
        setCurrentPage(currentPage);
        return true;
      } else {
        messagesList ??= [];
        notifyListeners();
        debugPrint(response.body.toString());
        return false;
      }
    }
  }

  setMessageList(dataList, userId) {
    if (userId.toString() != chatSellerId.toString()) {
      return;
    }
    messagesList ??= [];
    for (int i = 0; i < dataList.length; i++) {
      messagesList.add({
        'id': dataList[i].id,
        'message': dataList[i].message,
        'attachment':
            dataList[i].imageUrl.isNotEmpty ? dataList[i].imageUrl : null,
        'fromUser': dataList[i].fromUser,
        'imagePicked':
            false //check if this image is just got picked from device in that case we will show it from device location
      });
    }
    notifyListeners();
  }

//Send new message ======>

  sendMessage(toUser, message, imagePath, BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('shashaktnirmantoken');

    var dio = Dio();
    dio.options.headers['Content-Type'] = 'multipart/form-data';
    dio.options.headers['Accept'] = 'application/json';
    dio.options.headers['Authorization'] = "Bearer $token";
    FormData formData;
    if (imagePath != null) {
      formData = FormData.fromMap({
        'to_user': toUser,
        'message': message,
        'image': await MultipartFile.fromFile(imagePath,
            filename: 'ticket$imagePath.jpg')
      });
    } else {
      formData = FormData.fromMap({
        'to_user': toUser,
        'message': message,
      });
    }

    var connection = await checkConnection();
    if (connection) {
      setSendLoadingTrue();
      //if connection is ok

      var response = await dio.post(
        '$baseApi/user/chat/send',
        data: formData,
        options: Options(
          validateStatus: (status) {
            return true;
          },
        ),
      );
      setSendLoadingFalse();

      if (response.statusCode == 200) {
        log(response.data.toString());
        SharedPreferences prefs = await SharedPreferences.getInstance();
        var currentUserId = prefs.getInt('userId')!;
        addNewMessage(message, imagePath, currentUserId);

        sendNotification(context,
            sellerId: toUser,
            msg: lnProvider.getString('Message:') + ' ' + message);
        return true;
      } else {
        OthersHelper().showToast('Something went wrong', Colors.black);

        return false;
      }
    } else {
      OthersHelper()
          .showToast('Please check your internet connection', Colors.black);
      return false;
    }
  }

  addNewMessage(message, imagePath, userId) async {
    messagesList.insert(0, {
      'id': '',
      'message': message,
      'attachment': imagePath,
      'fromUser': userId,
      'imagePicked': imagePath !=
          null //check if this image is just got picked from device in that case we will show it from device location
    });
    notifyListeners();
  }

  addNewSellerMessage(message, imagePath, userId) async {
    messagesList.insert(0, {
      'id': '',
      'message': message,
      'attachment': imagePath,
      'fromUser': userId,
      'imagePicked':
          false //check if this image is just got picked from device in that case we will show it from device location
    });
    notifyListeners();
  }

  sendNotification(BuildContext context, {required sellerId, required msg}) {
    //Send notification to seller
    var username = Provider.of<ProfileService>(context, listen: false)
            .profileDetails
            .userDetails
            .name ??
        '';
    PushNotificationService().sendNotificationToSeller(context,
        sellerId: sellerId,
        title: lnProvider.getString("New chat message") + ": $username",
        body: '$msg',
        type: "message");
  }
}
