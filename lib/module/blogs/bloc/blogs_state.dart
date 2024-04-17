import '../data/blogs.dart';

class BlogsState {
  Blogs? blogs;


  BlogsState({this.blogs});

  BlogsState init() {
    return BlogsState();
  }

  BlogsState clone({Blogs? blogs}) {
    return BlogsState(
      blogs: blogs ?? this.blogs
    );
  }
}
