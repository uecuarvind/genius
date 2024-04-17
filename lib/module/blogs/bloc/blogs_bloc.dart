import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../repositories/support_repository.dart';
import 'blogs_event.dart';
import 'blogs_state.dart';

class BlogsBloc extends Bloc<BlogsEvent, BlogsState> {
  SupportRepository repository = SupportRepository();

  BlogsBloc() : super(BlogsState().init()) {
    on<InitEvent>(_init);
  }

  @override
  Future<void> close() {
    repository.close();
    return super.close();
  }

  void _init(InitEvent event, Emitter<BlogsState> emit) async {
    await repository.getBlogs(
        onSuccess: (data){
          emit(state.clone(blogs: data));
        },
        onError: (data){
        }
    );
  }
}
