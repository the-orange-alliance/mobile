import 'package:flutter/widgets.dart';

class TOAIcons {
  static const IconData FIRST = const TOAIconData(0xe800);
  static const IconData TOA = const TOAIconData(0xe808);
  static const IconData FTC = const TOAIconData(0xe809);
}

class TOAIconData extends IconData {
  const TOAIconData(int codePoint): super(
      codePoint,
      fontFamily: 'TOA Icons'
  );
}