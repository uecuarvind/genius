import 'package:flutter_bloc/flutter_bloc.dart';

import '../../main.dart';
import '../blogs/data/blogs.dart';
import 'blog_details_event.dart';
import 'blog_details_state.dart';

class BlogDetailsBloc extends Bloc<BlogDetailsEvent, BlogDetailsState> {
  BlogDetailsBloc() : super(BlogDetailsState().init()) {
    on<InitEvent>(_init);
  }

  void _init(InitEvent event, Emitter<BlogDetailsState> emit) async {
    emit(state.clone(
      blocData: settings(event.context).arguments as BlogData
    ));
  }
}
