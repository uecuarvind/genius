import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Widgets/circular_progress.dart';
import '../../../Widgets/default_appbar.dart';
import '../../../Widgets/network_image.dart';
import '../../../app_helper/helper.dart';
import '../../../main.dart';
import '../../../routes/app_pages.dart';
import '../../../theme/app_color.dart';
import '../bloc/blogs_bloc.dart';
import '../bloc/blogs_event.dart';
import '../bloc/blogs_state.dart';
import '../data/blogs.dart';

class BlogsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => BlogsBloc()..add(InitEvent()),
      child: BlocBuilder<BlogsBloc,BlogsState>(builder: (context,state) => _buildPage(context,state)),
    );
  }

  Widget _buildPage(BuildContext context, BlogsState state) {
    final bloc = BlocProvider.of<BlogsBloc>(context);

    return Scaffold(
      appBar: DefaultAppbar(title: appLanguage(context).blog),
      body: state.blogs==null ? CircularProgress(height: 1.sh) :
      ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: state.blogs!.data!.length,
          itemBuilder: (context,index){
            return blogItem(state.blogs!.data![index],index);
          }
      ),
    );
  }

  Widget blogItem(BlogData data, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachedImage(
                imageUrl: data.photo,
                width: 1.sw,
              ),
              10.verticalSpace,
              Text(data.title!,style: appTheme().textTheme.headlineLarge,),
              5.verticalSpace,
              Text(Helper.getFormatDate('dd MMM,yyyy', data.createdAt!),style: appTheme().textTheme.bodyLarge,),
            ],
          ),
        ),
        InkWell(
          onTap: ()=> goToPage(Routes.BLOG_DETAILS,arguments: data),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.r,vertical: 10.r),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 2,
                  width: 0.1.sw,
                  margin: EdgeInsets.only(top: 2.r),
                  color: AppColor.primary,
                ),
                Text(appLanguage().read_more.toUpperCase(),style: appTheme().textTheme.headlineLarge!.copyWith(
                    color: AppColor.primary
                )),
              ],
            ),
          ),
        ),
        16.verticalSpace
      ],
    );
  }
}

