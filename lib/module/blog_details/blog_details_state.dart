
import '../blogs/data/blogs.dart';

class BlogDetailsState {
  BlogData? blocData;


  BlogDetailsState({this.blocData});

  BlogDetailsState init() {
    return BlogDetailsState();
  }

  BlogDetailsState clone({BlogData? blocData}) {
    return BlogDetailsState(
      blocData: blocData ?? this.blocData
    );
  }
}
