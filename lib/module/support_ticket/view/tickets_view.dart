import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genius_bank/module/support_ticket/data/tickets.dart';

import '../../../Widgets/bottom_dialog.dart';
import '../../../Widgets/circular_progress.dart';
import '../../../Widgets/default_appbar.dart';
import '../../../Widgets/default_dialog.dart';
import '../../../Widgets/dialog_button.dart';
import '../../../Widgets/empty_page.dart';
import '../../../app_helper/enums.dart';
import '../../../app_helper/helper.dart';
import '../../../gen/assets.gen.dart';
import '../../../main.dart';
import '../../../routes/app_pages.dart';
import '../../../theme/app_color.dart';
import '../../../utils/dimension.dart';
import '../bloc/tickets_bloc.dart';
import '../bloc/tickets_event.dart';
import '../bloc/tickets_state.dart';
import 'add_data_dialog.dart';

class TicketsPage extends StatelessWidget {
  TicketsBloc? bloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => TicketsBloc()..add(InitEvent()),
      child: BlocBuilder<TicketsBloc,TicketsState>(builder: (context,state) => _buildPage(context,state)),
    );
  }

  Widget _buildPage(BuildContext context, TicketsState state) {
    bloc ??= BlocProvider.of<TicketsBloc>(context);

    return Scaffold(
      appBar: DefaultAppbar(title: appLanguage(context).support_tickets),
      body: state.tickets==null || state.pageState==PageState.Loading ? CircularProgress(
          height: 1.sh
      ) : state.tickets!.data!.isEmpty ? EmptyPage(message: appLanguage(context).noDataHere, image: Assets.images.notFound) : ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: state.tickets!.data!.length,
        itemBuilder: (BuildContext context, int index){
          return singleDisputes(state.tickets!.data![index],index);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: (){
            showNewDataDialog();
          },
          backgroundColor: AppColor.primary,
          label: Text(appLanguage(context).add_ticket,style: appTheme(context).textTheme.headlineLarge!.copyWith(color: AppColor.buttonTextColor),)
      ),
    );
  }

  Widget singleDisputes(TicketData data, int index, {bool isDialog=false}) {
    return Card(
      elevation: Dimension.cardElevation,
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.all(16.r).copyWith(top: index == 0 ? 16.r : 0),
      color: AppColor.cardColor,
      child: InkWell(
        onTap: isDialog ? null : (){
            goToPage(Routes.TICKET_DETAILS_PAGE,arguments: data);
        },
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.all(10.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(data.subject!,style: appTheme().textTheme.headlineLarge,),
                  5.verticalSpace,
                  Row(
                    children: [
                      Expanded(
                        child: Text(data.time ?? '',style: appTheme().textTheme.bodyLarge,textAlign: TextAlign.end,),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Visibility(
              visible: !isDialog,
              child: Positioned(
                  right: 0,
                  top: -5,
                  child: IconButton(
                    onPressed: (){
                      deleteTicketDialog(singleDisputes(data, index,isDialog: true),index);
                    },
                    icon: Icon(Icons.delete_outline,color: AppColor.red,),
                  )
              ),
            )
          ],
        ),
      ),
    );
  }
  void deleteTicketDialog(Widget child, int index)async{
    var data = await showDialog(
        context: appContext,
        builder: (BuildContext context){
          return DefaultDialog(
            title: appLanguage(context).delete_message,
            titleColor: AppColor.red,
            padding: EdgeInsets.symmetric(horizontal: 10.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.r),
                  child: Text(appLanguage().remove_alert,style: appTheme(context).textTheme.bodyLarge,),
                ),
                16.verticalSpace,
                child,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.r),
                  child: DialogButton(
                    negativeButton: appLanguage(context).no,
                    positiveButton: appLanguage(context).yes,
                    onTap: (state){
                      backPage(state);
                    }
                  ),
                )
              ],
            ),
          );
        }
    );
    if(data!=null && data){
      bloc!.add(DeleteEvent(index));
    }
  }

  Future showNewDataDialog() async {
    var data = await BottomDialog(
        title: appLanguage().add_message,
        width: 1.sw,
        child: DefaultDialog(
            barrierDismissible: false,
            width: 1.sw,
            title: appLanguage().add_ticket,
            alignment: Alignment.bottomCenter,
            enableCloseButton: true,
            child: AddDataDialog(bloc!)
        ),
        barrierDismissible: false
    );
    if(data!=null){
      bloc!.add(InitEvent());
    }
  }
}

