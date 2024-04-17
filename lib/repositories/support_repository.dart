import 'package:genius_bank/app_helper/api_client.dart';

import '../module/blogs/data/blogs.dart';
import '../module/contact_us/data/contact_info.dart';
import '../utils/url.dart';

class SupportRepository{
  ApiClient apiClient = ApiClient();

  void close(){
    apiClient.close();
  }


  Future getContactInfo({required Function(ContactInfo) onSuccess,required Function(Map<String,dynamic>) onError}) async {
    await apiClient.Request(
        url: URL.contactInfo,
        withAuth: false,
        onSuccess: (data){
          onSuccess(ContactInfo.fromJson(data));
        },
        onError: onError
    );
  }


  Future contactUs({required Map<String,String> body,required Function(dynamic) onSuccess,required Function(Map<String,dynamic>) onError}) async {
    await apiClient.Request(
        url: URL.contactUs,
        withAuth: false,
        method: Method.POST,
        body: body,
        onSuccess: onSuccess,
        onError: onError
    );
  }

  Future getBlogs({required Function(Blogs) onSuccess,required Function(Map<String,dynamic>) onError}) async {
    await apiClient.Request(
        url: URL.blogs,
        withAuth: false,
        onSuccess: (Map<String,dynamic> data) {
          Blogs blogs = Blogs.fromJson(data);
          onSuccess(blogs);
        },
        onError: onError
    );
  }


}