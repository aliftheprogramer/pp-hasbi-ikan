import 'package:flutter/material.dart';
import 'package:pui_bhasbi_mobile/common/theme/app_theme.dart';

class CustomTextFormField extends StatefulWidget {
  final String label;
  final TextEditingController? controller;
  final bool isPassword;
  final String? hintText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final bool? enabled;
  final bool readOnly; // NEW
  final int? maxLines;
  final Function(String)? onChanged;

  const CustomTextFormField({
    super.key,
    required this.label,
    this.controller,
    this.isPassword = false,
    this.hintText,
    this.keyboardType,
    this.validator,
    this.enabled,
    this.readOnly = false, // Default false
    this.maxLines = 1,
    this.onChanged,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: AppTheme.subtitle.copyWith(
            color: Colors.black87,
            fontWeight: FontWeight.w500, // Slightly bolder for label
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: widget.controller,
          obscureText: widget.isPassword ? _obscureText : false,
          keyboardType: widget.keyboardType,
          validator: widget.validator,
          enabled: widget.enabled,
          readOnly: widget.readOnly, // Pass readOnly
          maxLines: widget.isPassword ? 1 : widget.maxLines,
          onChanged: widget.onChanged,
          style: AppTheme.body.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 16, // Matching the chunky dots look
            letterSpacing: widget.isPassword ? 2.0 : 0, // Spacing for dots
          ),
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: const TextStyle(color: Colors.grey),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              // Use blue border if readOnly (to look "filled") or normally enabled
              borderSide: BorderSide(
                color: widget.readOnly
                    ? Colors.blue.shade400
                    : Colors.blue.shade400,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.blue, width: 2),
            ),
            suffixIcon: widget.isPassword
                ? IconButton(
                    icon: Icon(
                      _obscureText
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
