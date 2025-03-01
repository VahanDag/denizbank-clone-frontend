// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'package:denizbank_clone/screens/auth/register/register_screen.dart';

class CheckboxRichTextWidget extends StatefulWidget {
  final String? richText;
  final Function(bool?) onChanged;
  final bool initialValue;
  final Text? text;
  const CheckboxRichTextWidget({
    super.key,
    this.richText,
    required this.onChanged,
    this.initialValue = false,
    this.text,
  });

  @override
  State<CheckboxRichTextWidget> createState() => _CheckboxRichTextWidgetState();
}

class _CheckboxRichTextWidgetState extends State<CheckboxRichTextWidget> {
  late bool isChecked;

  @override
  void initState() {
    super.initState();
    isChecked = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Checkbox(
          activeColor: (AppColors.mainBlue),
          value: isChecked,
          onChanged: (value) {
            setState(() {
              isChecked = value ?? false;
            });
            widget.onChanged(value);
          },
        ),
        const SizedBox(width: 4),
        Expanded(
          child: widget.text ??
              RichText(
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: _parseTextSpans(widget.richText!),
                ),
              ),
        ),
      ],
    );
  }

  List<TextSpan> _parseTextSpans(String text) {
    final List<TextSpan> spans = [];

    final RegExp boldPattern = RegExp(r'\*\*(.*?)\*\*');
    int lastMatchEnd = 0;

    for (final Match match in boldPattern.allMatches(text)) {
      if (match.start > lastMatchEnd) {
        spans.add(TextSpan(
          text: text.substring(lastMatchEnd, match.start),
        ));
      }

      spans.add(TextSpan(
        text: match.group(1),
        style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.mainBlue),
      ));

      lastMatchEnd = match.end;
    }

    if (lastMatchEnd < text.length) {
      spans.add(TextSpan(
        text: text.substring(lastMatchEnd),
      ));
    }

    return spans;
  }
}
