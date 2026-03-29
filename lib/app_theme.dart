import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final themeNotifier = ValueNotifier<AppTheme>(AppTheme.darkTeal);
final perplexityNavIndex = ValueNotifier<int>(0);
final pendingPromptNotifier = ValueNotifier<String?>(null);

enum AppTheme { darkTeal, lightGrey }

extension AppThemeExt on BuildContext {
  bool get isLight => themeNotifier.value == AppTheme.lightGrey;

  Color get primary => Theme.of(this).colorScheme.primary;
  Color get secondary => Theme.of(this).colorScheme.secondary;

  Color get cardBg => isLight ? const Color(0xFFFFFFFF) : const Color(0xFF161618);
  Color get codeBg => isLight ? const Color(0xFFF0F4F3) : const Color(0xFF090910);
  Color get codeHeader => isLight ? const Color(0xFFE0EDEA) : const Color(0xFF161618);
  Color get accentLight => isLight ? const Color(0xFF0F7060) : const Color(0xFF20D9A0);
  Color get accentMid => isLight ? const Color(0xFF0D9E80) : const Color(0xFF1B9E78);
  Color get surfaceBg => isLight ? const Color(0xFFF4F4F6) : const Color(0xFF0C0C0F);
  Color get codeText => isLight ? const Color(0xFF0D6655) : const Color(0xFF7FFFD4);
  Color get codeBorder => isLight ? const Color(0xFFBDD8D2) : const Color(0xFF1A3530);
  Color get tipBg => isLight ? const Color(0xFFE8F5F2) : const Color(0xFF0D2520);
  Color get tipBorder => isLight ? const Color(0xFFA0CFC8) : const Color(0xFF1B6B5E);
  Color get tipText => isLight ? const Color(0xFF0F6050) : const Color(0xFF5FCFB0);
  Color get drawerDivider => isLight ? const Color(0xFFDDEAE8) : const Color(0xFF1A3530);
  Color get onSurface => isLight ? const Color(0xFF1A2A28) : const Color(0xFFE0F0EC);

  List<Color> get heroGradient => isLight
      ? [const Color(0xFF0F7060), const Color(0xFF159E84), const Color(0xFF20D9A0)]
      : [const Color(0xFF000000), const Color(0xFF0C2B26), const Color(0xFF154F44)];

  List<Color> get palette => isLight
      ? [
          const Color(0xFF0F7060),
          const Color(0xFF0D9E80),
          const Color(0xFF159E84),
          const Color(0xFF0A5A50),
          const Color(0xFF20D9A0),
          const Color(0xFF12806A),
        ]
      : [
          const Color(0xFF20D9A0),
          const Color(0xFF1B9E78),
          const Color(0xFF17C490),
          const Color(0xFF0EE090),
          const Color(0xFF1B6B5E),
          const Color(0xFF25F0B0),
        ];
}

Widget sectionTitle(String text, BuildContext context) => Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 8),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: context.accentLight,
        ),
      ),
    );

class CodeBlock extends StatelessWidget {
  final String code;
  final String? title;
  const CodeBlock({super.key, required this.code, this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: context.codeBg,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: context.codeBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: context.codeHeader,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(title!,
                      style: TextStyle(
                          color: context.accentLight,
                          fontSize: 12,
                          fontWeight: FontWeight.w600)),
                  IconButton(
                    icon: Icon(Icons.copy, size: 16, color: context.accentLight),
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: code));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Code copié !'),
                          duration: Duration(seconds: 1),
                        ),
                      );
                    },
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: SelectableText(
              code,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
                color: context.codeText,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
