import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:genius_bank/main.dart';
import 'package:genius_bank/routes/app_pages.dart';
import 'package:genius_bank/utils/app_constant.dart';

import '../../../../app_helper/enums.dart';
import '../../../../repositories/deposit_repository.dart';
import 'all_deposit_event.dart';
import 'all_deposit_state.dart';

class AllDepositBloc extends Bloc<AllDepositEvent, AllDepositState> {
  DepositRepository repository = DepositRepository();

  AllDepositBloc() : super(AllDepositState().init()) {
    on<InitEvent>(_init);
    on<GetData>(_getData);
    on<ApplyForDeposit>(_applyForDeposit);
  }

  @override
  Future<void> close() {
    repository.close();
    return super.close();
  }

  void _init(InitEvent event, Emitter<AllDepositState> emit) async {
    emit(state.clone());
    add(GetData());
  }

  FutureOr<void> _getData(GetData event, Emitter<AllDepositState> emit) async {
    await repository.getDepositList(
      onSuccess: (data){
        emit(state.clone(pageState: PageState.Success,deposits: data));
      },
      onError:(data){}
    );
  }

  FutureOr<void> _applyForDeposit(ApplyForDeposit event, Emitter<AllDepositState> emit) async {
    emit(state.clone(amountVerificationLoading: true));
    await repository.applyForDeposit(
      amount: event.amount,
      onSuccess: (data){
        backPage();
        state.depositData = data;
        goAndReplacePage(Routes.PAYMENT_PAGE,arguments: {
          AppConstant.url: data.data!.payUrl!
        });
      },
      onError:(data){}
    );
    emit(state.clone(amountVerificationLoading: true));
  }
}
