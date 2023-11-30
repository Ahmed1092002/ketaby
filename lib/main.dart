import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ketaby/Views/login_screan.dart';
import 'package:ketaby/src/app_root.dart';
import 'package:ketaby/src/bloc_opserver.dart';
import 'package:ketaby/src/cashe_helper.dart';
import 'package:ketaby/utils/dio_helper.dart';

import 'Views/main_screan.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  Bloc.observer = MyBlocObserver();
  await CashHelper.init();
  Widget widget;

  dynamic token = CashHelper.getData(key: 'token') == null ? null : CashHelper.getData(key: 'token');


    if (token != null) {
      widget =MainScrean();
    } else {
      widget = LoginScrean();
    }



  runApp( MyApp(widget: widget,));
}






