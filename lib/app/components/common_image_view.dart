import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:green_pool/generated/assets.dart';

// ignore: must_be_immutable
class CommonImageView extends StatelessWidget {
  ///[url] is required parameter for fetching network image
  String? url;
  String? imagePath;
  String? svgPath;
  File? file;
  double? height;
  Alignment alignment;
  double? width;
  final BoxFit fit;
  final String placeHolder;
  final Color? svgColor;

  ///a [CommonNetworkImageView] it can be used for showing any network images
  /// it will shows the placeholder image if image is not found on network
  CommonImageView({
    super.key,
    this.url,
    this.imagePath,
    this.svgPath,
    this.svgColor,
    this.alignment  = Alignment.center,
    this.file,
    this.height,
    this.width,
    this.fit = BoxFit.cover,
    this.placeHolder = Assets.iconsLogo,
  });

  @override
  Widget build(BuildContext context) {
    return _buildImageView();
  }

  Widget _buildImageView() {
    if (url == '' || imagePath == '' || svgPath == '') {
      return Image.asset(
        placeHolder,
        height: height,
        width: width,
        fit: fit,
      );
    } else if (svgPath != null && svgPath!.isNotEmpty) {
      return SizedBox(
        height: height,
        width: width,
        child: SvgPicture.asset(
          svgPath!,
          height: height,
          width: width,
          fit: fit,
          // color: svgColor,
        ),
      );
    } else if (file != null && file!.path.isNotEmpty) {
      return Image.file(
        file!,
        height: height,
        width: width,
        fit: fit,
      );
    } else if (url != null && url!.isNotEmpty && url != "") {
      return CachedNetworkImage(
        height: height,
        width: width,
       alignment: alignment,
        fit: fit,
        imageUrl: url!,
        placeholder: (context, url) => SizedBox(
          height: 30,
          width: 30,
          child: LinearProgressIndicator(
            color: Colors.grey.shade200,
            backgroundColor: Colors.grey.shade100,
          ),
        ),
        errorWidget: (context, url, error) => Image.asset(
          placeHolder,
          height: height,
          width: width,
          fit: fit,
        ),
      );
    } else if (imagePath != null && imagePath!.isNotEmpty) {
      return Image.asset(
        imagePath!,
        height: height,
        width: width,
        fit: fit,
      );
    }
    return const SizedBox();
  }
}
