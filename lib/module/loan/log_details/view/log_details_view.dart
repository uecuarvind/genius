import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genius_bank/Widgets/circular_progress.dart';
import 'package:genius_bank/Widgets/default_appbar.dart';
import 'package:genius_bank/Widgets/empty_page.dart';
import 'package:genius_bank/app_helper/enums.dart';
import 'package:genius_bank/main.dart';
import 'package:genius_bank/module/loan/log_details/data/logs.dart';
import 'package:genius_bank/utils/app_constant.dart';

import '../../../../gen/assets.gen.dart';
import '../../../../theme/app_color.dart';
import '../bloc/log_details_bloc.dart';
import '../bloc/log_details_event.dart';
import '../bloc/log_details_state.dart';

class LogDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LogDetailsBloc()..add(InitEvent(context)),
      child: BlocBuilder<LogDetailsBloc,LogDetailsState>(builder: (context,state) => _buildPage(context,state)),
    );
  }

  Widget _buildPage(BuildContext context, LogDetailsState state) {
    final bloc = BlocProvider.of<LogDetailsBloc>(context);
    return Scaffold(
      appBar: DefaultAppbar(
        title: bloc.arguments?[AppConstant.page] ?? appLanguage(context).all_loans
      ),
      body: state.logs == null || state.pageState != PageState.Success ? CircularProgress(height: 1.sh) : state.logs!.data!.isNotEmpty ?
      ListView.builder(
        itemCount: state.logs!.data!.length,
        shrinkWrap: true,
        itemBuilder: (ctx,index){
          LogData data = state.logs!.data![index];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 16.r).copyWith(top: 8.r),
            child: ListTile(
              iconColor: AppColor.iconColor,
              title: Row(
                children: [
                  Expanded(child: Text(data.transactionNo ?? '',style: appTheme(context).textTheme.headlineSmall!.copyWith(color: AppColor.primary),)),
                  Text(data.amount ?? '',style: appTheme(context).textTheme.bodyMedium!.copyWith(color: AppColor.primary),)
                ],
              ),
              subtitle: Align(
                alignment: Alignment.topRight,
                child: Text(data.date ?? '',style: appTheme(context).textTheme.bodySmall,),
              ),
            ),
          );
        }
      ) : EmptyPage(message: appLanguage(context).noDataHere, image: Assets.images.notFound),
    );
  }
}

