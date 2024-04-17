import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genius_bank/main.dart';
import 'package:genius_bank/repositories/support_repository.dart';

import 'support_event.dart';
import 'support_state.dart';

class SupportBloc extends Bloc<SupportEvent, SupportState> {
  dynamic arguments;
  SupportRepository repository = SupportRepository();

  SupportBloc() : super(SupportState().init()) {
    on<InitEvent>(_init);
  }

  @override
  Future<void> close() {
    repository.close();
    return super.close();
  }

  void _init(InitEvent event, Emitter<SupportState> emit) async {
    arguments = settings(event.context).arguments;
    if(state.pages != null){
      _managePage();
      return;
    }
   /* await repository.getPages(
        onSuccess: (data){
          emit(state.clone(pages: data));
          _managePage();
        },
        onError: (data){
        }
    );*/
  }

  void _managePage() {
    String? slug;
    if(arguments.toString() == appLanguage().terms_and_condition){
      slug = 'terms';
    } else if(arguments.toString() == appLanguage().privacy_policy){
      slug = 'privacy';
    } else if(arguments.toString() == appLanguage().about_us){
      slug = 'about';
    }

    for(int i=0; i<state.pages!.data!.length; i++){
      if(state.pages!.data![i].slug == slug){
        emit(state.clone(singlePage: state.pages!.data![i]));
        break;
      }
    }
  }
}
