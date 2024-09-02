// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class OverflowDetector extends StatefulWidget {
  final String text;
  final TextStyle style;
  final int maxLines;

  const OverflowDetector({
    super.key,
    required this.text,
    required this.style,
    this.maxLines = 1,
  });

  @override
  _OverflowDetectorState createState() => _OverflowDetectorState();
}

class _OverflowDetectorState extends State<OverflowDetector> {
  late final GlobalKey _key;
  late final String _displayText;
  String _overflowText = "";
  bool _isOverflowing = false;

  @override
  void initState() {
    super.initState();
    _key = GlobalKey();
    _displayText = widget.text;
    WidgetsBinding.instance.addPostFrameCallback((_) => _checkIfOverflowing());
  }

  void _checkIfOverflowing() {
    final RenderBox renderBoxRed = _key.currentContext!.findRenderObject() as RenderBox;
    final sizeRed = renderBoxRed.size;
    final parentBox = _key.currentContext!.findRenderObject()!.parent as RenderBox;

    debugPrint('CHECK: ${sizeRed.width > parentBox.size.width || sizeRed.height > parentBox.size.height}', wrapWidth: 1024);

    if (sizeRed.width > parentBox.size.width || sizeRed.height > parentBox.size.height) {
      if (_displayText.length > 1) {
        setState(() {
          _overflowText = _displayText[_displayText.length - 1] + _overflowText;
          _displayText = _displayText.substring(0, _displayText.length - 1);
          _isOverflowing = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          key: _key,
          child: Text(
            _displayText,
            maxLines: widget.maxLines,
            style: widget.style,
          ),
        ),
        if (_isOverflowing)
          Text(
            _overflowText,
            style: widget.style.copyWith(fontSize: widget.style.fontSize! * 0.8), // 80% of the original size
          ),
      ],
    );
  }
}

/* class OverflowDetector extends StatefulWidget {
  final String text;
  final TextStyle style;
  final int maxLines;

  const OverflowDetector({
    super.key,
    required this.text,
    required this.style,
    this.maxLines = 1,
  });

  @override
  _OverflowDetectorState createState() => _OverflowDetectorState();
}

class _OverflowDetectorState extends State<OverflowDetector> {
  late final GlobalKey _key;
  late final String _displayText;
  bool _isOverflowing = false;

  @override
  void initState() {
    super.initState();
    _key = GlobalKey();
    _displayText = widget.text;
    WidgetsBinding.instance.addPostFrameCallback((_) => _checkIfOverflowing());
  }

  void _checkIfOverflowing() {
    final RenderBox renderBoxRed = _key.currentContext!.findRenderObject() as RenderBox;
    final sizeRed = renderBoxRed.size;
    final parentBox = _key.currentContext!.findRenderObject()!.parent as RenderBox;

    if (sizeRed.width > parentBox.size.width || sizeRed.height > parentBox.size.height) {
      if (_displayText.length > 1) {
        setState(() {
          _displayText = _displayText.substring(0, _displayText.length - 1);
          _isOverflowing = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: _key,
      child: _isOverflowing
          ? Text(
              _displayText,
              maxLines: widget.maxLines,
              style: widget.style.copyWith(fontSize: widget.style.fontSize! * 0.8), // 80% of the original size
            )
          : Text(
              _displayText,
              maxLines: widget.maxLines,
              style: widget.style,
            ),
    );
  }
} */

/* class OverflowDetector extends StatefulWidget {
  final String text;
  final TextStyle style;
  final int maxLines;

  const OverflowDetector({
    super.key,
    required this.text,
    required this.style,
    this.maxLines = 1,
  });

  @override
  _OverflowDetectorState createState() => _OverflowDetectorState();
}

class _OverflowDetectorState extends State<OverflowDetector> {
  late final GlobalKey _key;
  late final String _displayText;

  @override
  void initState() {
    super.initState();
    _key = GlobalKey();
    _displayText = widget.text;
    WidgetsBinding.instance.addPostFrameCallback((_) => _checkIfOverflowing());
  }

  void _checkIfOverflowing() {
    final RenderBox renderBoxRed = _key.currentContext!.findRenderObject() as RenderBox;
    final sizeRed = renderBoxRed.size;
    final parentBox = _key.currentContext!.findRenderObject()!.parent as RenderBox;

    if (sizeRed.width > parentBox.size.width || sizeRed.height > parentBox.size.height) {
      if (_displayText.length > 1) {
        setState(() {
          _displayText = _displayText.substring(0, _displayText.length - 1);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: _key,
      child: Text(
        _displayText,
        maxLines: widget.maxLines,
        style: widget.style,
      ),
    );
  }
} */

/* class OverflowDetector extends StatefulWidget {
  final Text text;
  final Function(bool) onOverflowChanged;

  const OverflowDetector({
    super.key,
    required this.text,
    required this.onOverflowChanged,
  });

  @override
  _OverflowDetectorState createState() => _OverflowDetectorState();
}

class _OverflowDetectorState extends State<OverflowDetector> {
  late final GlobalKey _key;
  bool _isOverflowing = false;

  @override
  void initState() {
    super.initState();
    _key = GlobalKey();
    WidgetsBinding.instance.addPostFrameCallback((_) => _checkIfOverflowing());
  }

  void _checkIfOverflowing() {
    final RenderBox renderBoxRed = _key.currentContext!.findRenderObject() as RenderBox;
    final sizeRed = renderBoxRed.size;
    final parentBox = _key.currentContext!.findRenderObject()!.parent as RenderBox;

    // debugPrint('CHECK: ${sizeRed.width > parentBox.size.width || sizeRed.height > parentBox.size.height}', wrapWidth: 1024);
    // debugPrint('PARENTBOX.SIZE.HEIGHT: ${parentBox.size.height}', wrapWidth: 1024);
    // debugPrint('SIZERED.HEIGHT: ${sizeRed.height}', wrapWidth: 1024);
    // debugPrint('PARENTBOX.SIZE.WIDTH: ${parentBox.size.width}', wrapWidth: 1024);
    // debugPrint('SIZERED.WIDTH: ${sizeRed.width}', wrapWidth: 1024);
    // debugPrint('\n', wrapWidth: 1024);

    if (sizeRed.width > parentBox.size.width || sizeRed.height > parentBox.size.height) {
      if (!_isOverflowing) {
        widget.onOverflowChanged(true);
        _isOverflowing = true;
      }
    } else {
      if (_isOverflowing) {
        widget.onOverflowChanged(false);
        _isOverflowing = false;
      } else {
        widget.onOverflowChanged(true);
        _isOverflowing = true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: _key,
      child: widget.text,
    );
  }
} */
