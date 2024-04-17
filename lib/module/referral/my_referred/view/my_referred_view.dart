import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genius_bank/Widgets/circular_progress.dart';
import 'package:genius_bank/Widgets/default_appbar.dart';
import 'package:genius_bank/Widgets/empty_page.dart';
import 'package:genius_bank/app_helper/enums.dart';
import 'package:genius_bank/main.dart';
import 'package:genius_bank/module/referral/my_referred/data/referral_user.dart';

import '../../../../gen/assets.gen.dart';
import '../../../../theme/app_color.dart';
import '../bloc/my_referred_bloc.dart';
import '../bloc/my_referred_event.dart';
import '../bloc/my_referred_state.dart';

class MyReferredPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => MyReferredBloc()..add(InitEvent()),
      child: BlocBuilder<MyReferredBloc,MyReferredState>(builder: (context,state) => _buildPage(context,state)),
    );
  }

  Widget _buildPage(BuildContext context, MyReferredState state) {
    final bloc = BlocProvider.of<MyReferredBloc>(context);
    return Scaffold(
      appBar: DefaultAppbar(
        title: appLanguage(context).referred_users
      ),
      body: state.myReferred == null || state.pageState != PageState.Success ? CircularProgress(height: 1.sh) : state.myReferred!.data!.isNotEmpty ?
      ListView.builder(
        itemCount: state.myReferred!.data!.length,
        shrinkWrap: true,
        itemBuilder: (ctx,index){
          ReferralData data = state.myReferred!.data![index];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 16.r).copyWith(top: 8.r),
            child: ListTile(
              title: Text(data.name ?? '',style: appTheme(context).textTheme.headlineMedium!.copyWith(color: AppColor.primary),),
              subtitle: Text(data.joinedAt ?? '',style: appTheme(context).textTheme.bodySmall!.copyWith(color: AppColor.grey),textAlign: TextAlign.right,),
            ),
          );
        }
      ) : EmptyPage(message: appLanguage(context).noDataHere, image: Assets.images.notFound),
    );
  }
}

