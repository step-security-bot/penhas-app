import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:penhas/app/shared/design_system/colors.dart';

class SupportCenterInputDDD extends StatelessWidget {
  const SupportCenterInputDDD({
    Key? key,
    required this.hintText,
    required this.errorText,
    required this.onChanged,
  }) : super(key: key);

  final String hintText;
  final String errorText;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        decoration: InputDecoration(
          counterText: '',
          hintText: hintText,
          border: const OutlineInputBorder(),
          contentPadding:
              const EdgeInsetsDirectional.only(end: 8.0, start: 8.0),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: DesignSystemColors.easterPurple,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: DesignSystemColors.easterPurple,
            ),
          ),
          errorText: errorText.isEmpty ? null : errorText,
        ),
        keyboardType: TextInputType.phone,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ],
        onChanged: onChanged,
        maxLength: 2,
      ),
    );
  }
}
