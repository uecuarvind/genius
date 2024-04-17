import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genius_bank/Widgets/app_background.dart';
import 'package:genius_bank/gen/assets.gen.dart';

import '../../theme/app_color.dart';
import 'splash_bloc.dart';
import 'splash_event.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SplashBloc()..add(InitSplashEvent()),
      child: Builder(builder: (context) => _buildPage(context)),
    );
  }

  Widget _buildPage(BuildContext context) {
    final bloc = BlocProvider.of<SplashBloc>(context);

    return Scaffold(
      //backgroundColor: AppColor.Primary,
      body: AppBackground(
        child: Center(
          child: Assets.banner.image(color: AppColor.logoColor)
        ),
      ),
    );
  }
}

