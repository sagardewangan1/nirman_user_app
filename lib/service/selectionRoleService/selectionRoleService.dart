import 'package:flutter/cupertino.dart';

class SelectionRoleService extends ChangeNotifier {
  int _roleId = 0;
  int get roleId => _roleId;

  setRoleId(int roleId) {
    _roleId = roleId;
    notifyListeners();
  }
}
