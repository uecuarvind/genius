import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genius_bank/main.dart';
import 'package:genius_bank/theme/app_color.dart';
class WidgetValidation extends StatelessWidget {
  WidgetValidation({
    Key? key,
    required this.validator,
    required this.child,
    this.color,
    this.borderRadius,
  }) : super(key: key);
  final String? Function(dynamic) validator;
  Widget child;
  Color? color;
  double? borderRadius;

  @override
  Widget build(BuildContext context) {
    return FormField(
        validator: validator,
        builder: (formFieldState) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(borderRadius ?? 0),
                  border: formFieldState.hasError ? Border.all(width: 1,color: AppColor.red) : null
                ),
                clipBehavior: Clip.antiAlias,
                child: child
              ),
              if (formFieldState.hasError)
                Padding(
                  padding: EdgeInsets.only(top: 8.r,left: 16.r),
                  child: Text(
                    formFieldState.errorText!,
                    style: appTheme(context).textTheme.bodySmall!.copyWith(color: AppColor.red),
                  ),
                )
            ],
          );
        }
      );
   }
}