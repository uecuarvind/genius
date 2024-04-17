import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:genius_bank/Widgets/circular_progress.dart';
import 'package:genius_bank/Widgets/default_appbar.dart';
import 'package:genius_bank/main.dart';
import 'package:genius_bank/utils/dimension.dart';

import '../bloc/support_bloc.dart';
import '../bloc/support_event.dart';
import '../bloc/support_state.dart';

class SupportPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SupportBloc()..add(InitEvent(context)),
      child: BlocBuilder<SupportBloc,SupportState>(builder: (context,state) => _buildPage(context,state)),
    );
  }

  Widget _buildPage(BuildContext context, SupportState state) {
    final bloc = BlocProvider.of<SupportBloc>(context);

    return Scaffold(
      appBar: DefaultAppbar(title: bloc.arguments ?? ''),
      body: state.singlePage==null ? CircularProgress(height: 1.sh) :
      ListView(
        padding: EdgeInsets.symmetric(horizontal: 16.r),
        children: [
          16.verticalSpace,
          HtmlWidget(
            state.singlePage?.content ?? '',
            textStyle: appTheme().textTheme.bodyLarge,
          ),
          Dimension.bottomSpace
        ]
      ),
    );
  }

}

