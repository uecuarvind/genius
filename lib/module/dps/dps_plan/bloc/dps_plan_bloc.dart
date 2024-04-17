import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:genius_bank/Widgets/show_message.dart';
import 'package:genius_bank/app_helper/enums.dart';
import 'package:genius_bank/app_helper/extensions.dart';
import 'package:genius_bank/main.dart';
import 'package:genius_bank/module/dps/dps_plan/data/dps_plan.dart';
import 'package:genius_bank/repositories/dps_repository.dart';
import 'package:genius_bank/utils/app_constant.dart';

import '../../../../Widgets/message_dialog.dart';
import 'dps_plan_event.dart';
import 'dps_plan_state.dart';

class DpsPlanBloc extends Bloc<DpsPlanEvent, DpsPlanState> {
  DpsRepository repository = DpsRepository();
  DpsPlanBloc() : super(DpsPlanState().init()) {
    on<InitEvent>(_init);
    on<GetPlans>(_getPlans);
    on<ApplyDps>(_applyDps);
  }

  @override
  Future<void> close() {
    repository.close();
    return super.close();
  }

  void _init(InitEvent event, Emitter<DpsPlanState> emit) async {
    emit(state.clone());
    add(GetPlans());
  }

  Future _getPlans(GetPlans event, Emitter<DpsPlanState> emit) async {
    await repository.getPlans(
        onSuccess: (DpsPlan data){
          emit(state.clone(plans: data,pageState: PageState.Success));
        },
        onError: (Map<String,dynamic> data){}
    );
  }



  FutureOr<void> _applyDps(ApplyDps event, Emitter<DpsPlanState> emit) async {
    Map<String,String> body ={
      AppConstant.dps_plan_id: event.data.id.toString(),
      AppConstant.per_installment: event.data.perInstallment!.numeric,
      AppConstant.deposit_amount: event.data.totalDeposit!.numeric,
      AppConstant.matured_amount: event.data.afterMatured!.numeric,
    };

    MessageDialog(
      title: appLanguage().confirmation,
      message: appLanguage().are_you_sure_about_applying_with_this_deposit_plan.replaceAll('@', event.data.title ?? ''),
      isConfirmDialog: true,
      onTap: (state) async{
        backPage();
        if(state){
          await repository.submitDpsRequest(
            body: body,
            onSuccess: (data){
              backPage();
              SuccessMessage(message: appLanguage().your_deposit_request_has_been_sent_successfully);
            },
            onError: (data){}
          );
        }
      }
    );
  }
}
