import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../pages_default/dashBoard.dart';
import '../pages_default/login.dart';
import '../services/auth_service.dart';


class CheckAuth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Obx(() => AuthService.to.userIsAuthenticated.value
        ? DashBoard(matricula: 1,)
        : Home());
  }
}
