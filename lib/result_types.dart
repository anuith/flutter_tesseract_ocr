import 'dart:convert';
import 'dart:ui';

class OcrResult {
  final String fullText;
  final Size imageSize;
  final List<OcrBlock> blocks;

  OcrResult(
      {required this.fullText, required this.imageSize, required this.blocks});

  factory OcrResult.fromJson(String str) => OcrResult.fromMap(json.decode(str));

  factory OcrResult.fromMap(Map<String, dynamic> json) => OcrResult(
        fullText: json["fullText"],
        imageSize: Size(json["imgWidth"]?.toDouble(), json["imgHeight"]?.toDouble()),
        blocks:
            List<OcrBlock>.from(json["blocks"].map((x) => OcrBlock.fromMap(x))),
      );
}

/// Represents a block of text recognized by the OCR operation.
/// It contains the recognized text within the block and the bounding box of the block.
/// The bounding box is represented as a rectangle with values proportional to the original image size.
class OcrBlock {
  /// The recognized text within the block.
  final String text;

  /// The bounding box of the block, represented as a rectangle.
  /// The values are proportional to the original image size.
  final Rect box;

  OcrBlock({required this.text, required this.box});

  factory OcrBlock.fromMap(Map<String, dynamic> json) => OcrBlock(
        text: json["text"],
        box: Rect.fromLTWH(
          json["box"]["x"].toDouble(),
          json["box"]["y"].toDouble(),
          json["box"]["w"].toDouble(),
          json["box"]["h"].toDouble(),
        ),
      );
}
