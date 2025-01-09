import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:qixer/service/live_chat/chat_list_service.dart';
import 'package:qixer/service/permissions_service.dart';
import 'package:qixer/view/utils/others_helper.dart';

import '../../../live_chat/chat_list_page.dart';

class ChatIcon extends StatelessWidget {
  const ChatIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 20,
      bottom: 20,
      child: Consumer<PermissionsService>(
        builder: (context, pProvider, child) => InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {
            if (!pProvider.chatPermission) {
              OthersHelper().showToast(
                  'You don\'t have permission to access this feature',
                  Colors.black);
              return;
            }
            //=====>
            Provider.of<ChatListService>(context, listen: false)
                .fetchChatList(context);

            //======>
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => const ChatListPage(),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 3,
                  blurRadius: 12,
                  offset: const Offset(0, 5), // changes position of shadow
                ),
              ],
            ),
            child: SvgPicture.asset(
              'assets/svg/message-green.svg',
              height: 48,
            ),
          ),
        ),
      ),
    );
  }
}
