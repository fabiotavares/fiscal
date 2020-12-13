import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class TextWithCopyButton extends StatelessWidget {
  final String title;
  final String body;
  final String toCopy;
  final Color backgoundColor;
  final EdgeInsets padding;
  final EdgeInsets margin;

  const TextWithCopyButton({
    Key key,
    @required this.title,
    this.body,
    @required this.toCopy,
    @required this.backgoundColor,
    this.padding,
    this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        color: backgoundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: body != null ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              InkWell(
                onTap: () {
                  Clipboard.setData(ClipboardData(text: toCopy));

                  Get.snackbar(
                    'Sucesso',
                    'Copiado para a área de transferência',
                    barBlur: 50,
                    backgroundGradient: LinearGradient(colors: [Colors.white, Colors.white]),
                  );
                },
                child: Icon(Icons.copy, size: 22),
              ),
            ],
          ),
          if (body != null)
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(body),
            ),
        ],
      ),
    );
  }
}
