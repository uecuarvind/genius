import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:genius_bank/repositories/beneficiary_repository.dart';

import '../../../../../app_helper/enums.dart';
import 'beneficiary_list_event.dart';
import 'beneficiary_list_state.dart';

class BeneficiaryListBloc extends Bloc<BeneficiaryListEvent, BeneficiaryListState> {
  BeneficiaryRepository repository = BeneficiaryRepository();

  BeneficiaryListBloc() : super(BeneficiaryListState().init()) {
    on<InitEvent>(_init);
    on<GetData>(_getData);
  }

  @override
  Future<void> close() {
    repository.close();
    return super.close();
  }

  void _init(InitEvent event, Emitter<BeneficiaryListState> emit) async {
    emit(state.clone());
    add(GetData());
  }

  FutureOr<void> _getData(GetData event, Emitter<BeneficiaryListState> emit) async {
    await repository.getBeneficiaryList(
      onSuccess: (data){
        emit(state.clone(pageState: PageState.Success,listData: data));
      },
      onError:(data){}
    );
  }
}
