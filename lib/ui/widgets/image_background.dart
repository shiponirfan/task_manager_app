import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_manager_app/ui/utils/image_path.dart';

class ImageBackground extends StatelessWidget {
  const ImageBackground({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    Size mediaQuery = MediaQuery.of(context).size;
    return Stack(
      children: [
        SvgPicture.asset(
          ImagePath.backgroundSvg,
          width: mediaQuery.width,
          height: mediaQuery.height,
          fit: BoxFit.cover,
        ),
        SafeArea(child: child),
      ],
    );
  }
}
