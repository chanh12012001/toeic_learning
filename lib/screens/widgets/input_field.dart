import 'package:flutter/material.dart';

import '../../config/theme.dart';

class InputField extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;
  final TextInputType? inputType;
  final Function(String)? onChanged;
  final bool? enable;
  const InputField({
    Key? key,
    required this.title,
    required this.hint,
    this.controller,
    this.widget,
    this.inputType = TextInputType.multiline,
    this.onChanged,
    this.enable = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: titleStyle,
          ),
          Container(
            height: 52,
            margin: const EdgeInsets.only(top: 8),
            padding: const EdgeInsets.only(left: 14, right: 14),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    enabled: enable,
                    onChanged: onChanged,
                    keyboardType: inputType,
                    readOnly: widget == null ? false : true,
                    autofocus: false,
                    cursorColor: Colors.grey,
                    controller: controller,
                    style: subTitleStyle,
                    decoration: InputDecoration(
                      hintText: hint,
                      hintStyle: subTitleStyle,
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 0,
                        ),
                      ),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 0,
                        ),
                      ),
                    ),
                  ),
                ),
                widget == null ? Container() : Container(child: widget)
              ],
            ),
          )
        ],
      ),
    );
  }
}
