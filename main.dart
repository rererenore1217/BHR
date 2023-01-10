import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:mlkit_text_recognition_v2_app/pages/home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class CustomShapeBorder extends ShapeBorder {
  const CustomShapeBorder({this.blocks, this.absoluteImageSize});
  final List<TextBlock>? blocks;
  final Size? absoluteImageSize;

  @override
  EdgeInsetsGeometry get dimensions => const EdgeInsets.all(20);

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return Path();
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return Path();
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) async {
    final backgroundPaint = Paint();
    final double scaleX =
        absoluteImageSize != null ? rect.width / absoluteImageSize!.width : 1;
    final double scaleY =
        absoluteImageSize != null ? rect.height / absoluteImageSize!.height : 1;

    canvas
      ..saveLayer(
        rect,
        backgroundPaint,
      )
      ..restore();

    if (blocks == null && blocks != null && blocks!.isEmpty) return;

    // 描画するBoxのスタイル
    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;
    paint.color = Colors.lightBlue;

    // 描画するTextのスタイル
    const textStyle = TextStyle(
      color: Colors.black,
      fontSize: 12,
    );

    // 各ブロックのBoxtとTextを描画
    blocks?.forEach((block) {
      // Blockの描画
      final blockRect = Rect.fromLTWH(
          block.boundingBox.left,
          block.boundingBox.top,
          block.boundingBox.width,
          block.boundingBox.height);
      canvas.drawRect(
          Rect.fromLTRB(
            blockRect.left * scaleX + rect.left,
            blockRect.top * scaleY + rect.top,
            blockRect.right * scaleX + rect.left,
            blockRect.bottom * scaleY + rect.top,
          ),
          paint);

      // Textの描画
      final textSpan = TextSpan(
        text: block.text,
        style: textStyle,
      );
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout(
        minWidth: 0,
        maxWidth: rect.width,
      );
      final dx = block.boundingBox.left * scaleX + rect.left;
      final dy = block.boundingBox.top * scaleY + rect.top;
      final offset = Offset(dx, dy);
      textPainter.paint(canvas, offset);
    });
  }

  @override
  ShapeBorder scale(double t) {
    return CustomShapeBorder(absoluteImageSize: absoluteImageSize);
  }
}
