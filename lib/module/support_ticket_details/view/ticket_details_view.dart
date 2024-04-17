import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genius_bank/module/support_ticket_details/data/reply.dart';
import '../../../Widgets/circle_button.dart';
import '../../../Widgets/default_appbar.dart';
import '../../../Widgets/default_textfield.dart';
import '../../../Widgets/empty_view.dart';
import '../../../app_helper/enums.dart';
import '../../../main.dart';
import '../../../theme/app_color.dart';
import '../../../utils/dimension.dart';
import '../bloc/ticket_details_bloc.dart';
import '../bloc/ticket_details_event.dart';
import '../bloc/ticket_details_state.dart';

class TicketDetailsPage extends StatelessWidget {
  TicketDetailsBloc? bloc;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => TicketDetailsBloc()..add(InitEvent(context)),
      child: BlocBuilder<TicketDetailsBloc,TicketDetailsState>(
        builder: (context,state) => _buildPage(context,state)
      ),
    );
  }

  Widget _buildPage(BuildContext context, TicketDetailsState state) {
    bloc ??= BlocProvider.of<TicketDetailsBloc>(context);

    return Scaffold(
      appBar: DefaultAppbar(title: appLanguage().messages),
      body: Stack(
        children: [
          ListView(
            padding: EdgeInsets.only(bottom: 65.r),
            children: [
              state.reply!=null ? state.reply!.data!.isNotEmpty ?
              messageView(state.reply!) : EmptyView() : EmptyView(),
              Padding(
                padding: EdgeInsets.only(bottom:16.r)
              )
            ],
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: 1.sw,
              color: AppColor.cardColor,
              padding: EdgeInsets.only(bottom: Dimension.paddingBottom),
              child: DefaultTextField(
                controller: bloc!.message,
                hint: appLanguage().type_a_message,
                enableValidation: false,
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: AppColor.buttonTextColor,
                          shape: BoxShape.circle
                      ),
                      child: CircleButton(
                          loading: state.pageState == PageState.Loading,
                          onTap: ()=> bloc!.add(SendMessageEvent()),
                          loadingColor: AppColor.primary,
                          child: Padding(
                            padding: EdgeInsets.all(8.r),
                            child: Icon(Icons.send,color: AppColor.primary,size: 20.r,),
                          )
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget messageView(Reply messages) {
    return ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 10.r),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: messages.data!.length,
        itemBuilder: (context,i){
          bool isMind=messages.data![i].userId==bloc!.state.auth!.data!.user!.id!.toString();
          return Container(
            alignment: isMind ? Alignment.bottomRight : Alignment.bottomLeft,
            margin: EdgeInsets.only(top: 16.r,left: isMind ? 0.2.sw : 0 ,right: isMind ? 0 : 0.2.sw),
            child: isMind ? Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: isMind ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.r,vertical: 5.r),
                    decoration: BoxDecoration(
                        color: isMind ? AppColor.primary : AppColor.buttonTextColor,
                        borderRadius: isMind ? BorderRadius.only(bottomLeft: Radius.circular(20.r),topLeft: Radius.circular(20.r),topRight: Radius.circular(20.r)) :
                        BorderRadius.only(topRight: Radius.circular(20.r),bottomRight: Radius.circular(20.r),topLeft: Radius.circular(20.r))
                    ),
                    child: Text(messages.data![i].message!,style: appTheme(context).textTheme.bodyLarge!.copyWith(color: isMind ? AppColor.buttonTextColor : AppColor.textColor),)
                ),
                Container(
                  padding: EdgeInsets.only(top: 5.r,right: isMind ? 5.r : 0 ,left: isMind ? 0 : 5.r),
                  child: Text(messages.data![i].createdAt ?? '',style: appTheme(context).textTheme.bodyMedium!.copyWith(fontSize: 10.spMin),),
                )
              ],
            ) : Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: isMind ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.r,vertical: 5.r),
                  decoration: BoxDecoration(
                      color: isMind ? AppColor.primary : AppColor.cardColor,
                      borderRadius: isMind ? BorderRadius.only(bottomLeft: Radius.circular(20.r),topLeft: Radius.circular(20.r),topRight: Radius.circular(20.r)) :
                      BorderRadius.only(topRight: Radius.circular(20.r),bottomRight: Radius.circular(20.r),topLeft: Radius.circular(20.r))
                  ),
                  child: Text(messages.data![i].message!,style: appTheme(context).textTheme.bodyLarge!.copyWith(color: isMind ? AppColor.buttonTextColor : AppColor.textColor),)
                ),
                Container(
                  padding: EdgeInsets.only(top: 5.r,right: !isMind ? 5.r : 0 ,left: !isMind ? 0 : 5.r),
                  child: Text(messages.data![i].createdAt ?? '',style: appTheme(context).textTheme.bodyMedium!.copyWith(fontSize: 10.spMin),),
                )
              ],
            ),
          );
        }
    );
  }
}

