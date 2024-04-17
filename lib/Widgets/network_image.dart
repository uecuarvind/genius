import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:genius_bank/Widgets/image_placeholder.dart';
import 'package:genius_bank/utils/url.dart';

class CachedImage extends StatelessWidget {
  String? imageUrl;
  final BoxFit? fit;
  final double? height;
  final double? width;
  final bool isProfileImage;
  final Color? color;
  CachedImage({Key? key,required this.imageUrl, this.height, this.width,this.fit,this.isProfileImage = false,this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(imageUrl!=null && imageUrl!.isNotEmpty && !imageUrl!.contains('http')){
      imageUrl = '${URL.baseUrl}$imageUrl';
    }
    return (imageUrl == null || imageUrl!.isEmpty) ? isProfileImage ? UserImagePlaceHolder(
      height: height ?? double.infinity,
      width: width,
      fit: fit ?? BoxFit.cover,
    ) : ImagePlaceHolder(height: height,fit: fit ?? BoxFit.cover,width: width) :
    CachedNetworkImage(
      imageUrl: imageUrl!,
      height: height,
      width: width,
      placeholder: (context, url) => isProfileImage ? UserImagePlaceHolder(
        height: height ?? double.infinity,
        width: width,
        fit: fit ?? BoxFit.cover,
      ) : ImagePlaceHolder(height: height,fit: fit ?? BoxFit.cover,width: width),
      errorWidget: (context, url, error) => isProfileImage ? UserImagePlaceHolder(
        height: height ?? double.infinity,
        width: width,
        fit: fit ?? BoxFit.cover,
      ) : ImagePlaceHolder(height: height,fit: fit ?? BoxFit.cover,width: width),
      fit: fit ?? BoxFit.cover,
      color: color,
    );
  }
}
