import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:news_app/controller/cubit.dart';
import 'package:news_app/styles/styles.dart';

class MyFormField extends StatelessWidget {
  const MyFormField(
      {super.key,
      required this.title,
      required this.hint,
      this.controller,
      this.widget,
      this.onTap,
      this.validate});
  final String title;
  final String hint;
  final onTap;
  final validate;
  final TextEditingController? controller;
  final Widget? widget;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppCubit.get(context).isDark
                ? titleStyle.copyWith(color: Colors.white)
                : titleStyle,
          ),
          Container(
            height: 40,
            margin: const EdgeInsets.only(top: 5.0, right: 10),
            padding: const EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.grey,
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    readOnly: widget == null ? false : true,
                    controller: controller,
                    onTap: onTap,
                    //autofocus: false,
                    cursorColor: Colors.grey,
                    style: AppCubit.get(context).isDark
                        ? subTitleStyle.copyWith(color: Colors.white)
                        : subTitleStyle,
                    decoration: InputDecoration(
                      hintText: hint,
                      hintStyle: AppCubit.get(context).isDark
                          ? subTitleStyle.copyWith(color: Colors.grey[400])
                          : subTitleStyle,
                      // border: OutlineInputBorder(
                      //   borderRadius: BorderRadius.circular(12),
                      // ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 0),
                      ),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 0),
                      ),
                    ),
                    validator: validate,
                  ),
                ),
                widget == null
                    ? Container()
                    : Container(
                        child: widget,
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
