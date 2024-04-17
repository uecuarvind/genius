import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import '../../Widgets/network_image.dart';
import '../../app_helper/helper.dart';
import '../../main.dart';
import '../../theme/app_color.dart';
import '../../utils/dimension.dart';
import 'blog_details_bloc.dart';
import 'blog_details_event.dart';
import 'blog_details_state.dart';

class BlogDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => BlogDetailsBloc()..add(InitEvent(context)),
      child: BlocBuilder<BlogDetailsBloc,BlogDetailsState>(builder: (context,state) => _buildPage(context,state)),
    );
  }

  Widget _buildPage(BuildContext context, BlogDetailsState state) {
    final bloc = BlocProvider.of<BlogDetailsBloc>(context);

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CachedImage(
                  imageUrl: state.blocData?.photo ?? '',
                  width: 1.sw,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16.r),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      10.verticalSpace,
                      Text(state.blocData?.title ?? '',style: appTheme().textTheme.headlineLarge,),
                      5.verticalSpace,
                      Row(
                        children: [
                          Text(Helper.getFormatDate('dd MMM,yyyy', state.blocData?.createdAt ?? ''),style: appTheme().textTheme.bodyLarge,),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(Icons.favorite_border_rounded,size: 16.r,color: AppColor.grey,),
                                5.horizontalSpace,
                                Text('${state.blocData?.views ?? '0'} ${appLanguage().views}',style: appTheme().textTheme.bodyLarge,),
                              ],
                            ),
                          )
                        ],
                      ),
                      10.verticalSpace,
                      Text('${appLanguage().source}: ${state.blocData?.source ?? ''}',style: appTheme().textTheme.bodyLarge,),
                      16.verticalSpace,
                      HtmlWidget(
                        state.blocData?.details ?? '',
                        textStyle: appTheme().textTheme.bodyLarge,
                      ),
                      Dimension.bottomSpace
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: Dimension.paddingTop,
            child: BackButton(
              onPressed: ()=>backPage(),
            ),
          )
        ],
      ),
    );
  }
}

