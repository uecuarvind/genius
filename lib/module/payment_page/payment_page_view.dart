import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genius_bank/Widgets/circular_progress.dart';
import 'package:genius_bank/Widgets/default_appbar.dart';
import 'package:genius_bank/Widgets/default_dialog.dart';
import 'package:genius_bank/app_helper/enums.dart';
import 'package:genius_bank/main.dart';
import 'package:genius_bank/theme/app_color.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'payment_page_bloc.dart';
import 'payment_page_event.dart';
import 'payment_page_state.dart';

class PaymentPagePage extends StatelessWidget {
  PaymentPageBloc? bloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => PaymentPageBloc()..add(InitEvent(context)),
      child: BlocBuilder<PaymentPageBloc,PaymentPageState>(builder: (context,state) => _buildPage(context,state)),
    );
  }

  Widget _buildPage(BuildContext context, PaymentPageState state) {
    bloc ??= BlocProvider.of<PaymentPageBloc>(context);

    return Scaffold(
      appBar: DefaultAppbar(title: appLanguage(context).payment,onBack: back),
      body: BlocBuilder<PaymentPageBloc,PaymentPageState>(builder: (BuildContext context, state) {
        return WillPopScope(
          onWillPop: back,
          child: Stack(
            alignment: Alignment.center,
            children: [
              if(state.webUrl!=null)
                WebViewWidget(
                  controller: bloc!.controller,
                  /*debuggingEnabled: true,
                  gestureNavigationEnabled: true,*/
                ),
              IgnorePointer(
                ignoring: true,
                child: Visibility(visible:state.pageState == PageState.Loading,child: CircularProgress(height: 1.sh)),
              )
            ],
          ),
        );
      }),
    );
  }


  Future<bool> back() async {
    if(await bloc!.controller.canGoBack()){
      await bloc!.controller.goBack();
    } else {
      backPage();
    }
    return Future.value(false);
  }
}

