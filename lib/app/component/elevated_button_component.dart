import 'package:flutter/material.dart';

class ElevatedButtonComponent extends StatelessWidget {
  const ElevatedButtonComponent({
    Key? key,
    this.width = double.infinity,
    this.height = 64,
    this.padding,
    this.primary = Colors.white,
    this.borderColor = Colors.transparent,
    this.icon,
    required this.labelText,
    this.style,
    required this.onPressed,
  }) : super(key: key);

  final double width;
  final double height;
  final EdgeInsetsGeometry? padding;
  final Color? primary;
  final Color? borderColor;
  final Widget? icon;
  final String labelText;
  final TextStyle? style;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.symmetric(vertical: 8),
      child: SizedBox(
        width: width,
        height: height,
        child: icon == null ? _buildElevatedButton() : _buildElevatedIconButton(),
      ),
    );
  }

  Widget _buildElevatedButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
          side: BorderSide(color: borderColor ?? Colors.transparent),
        ), backgroundColor: primary,
      ),
      child: Text(
        labelText,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: style ??
            const TextStyle(
              fontSize: 14,
              color: Colors.white,
            ),
      ),
      onPressed: onPressed,
    );
  }

  Widget _buildElevatedIconButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
          side: const BorderSide(color: Colors.transparent),
        ), backgroundColor: primary,
      ),
      child: ListTile(
        leading: icon,
        title: Text(
          labelText,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: style ??
              const TextStyle(
                fontSize: 14,
                color: Colors.white,
              ),
        ),
      ),
      onPressed: onPressed,
    );
  }
}
