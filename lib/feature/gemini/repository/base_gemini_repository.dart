import 'dart:typed_data';

import 'package:athena_ai/feature/gemini/models/candidates/candidates.dart';
import 'package:athena_ai/feature/gemini/models/content/content.dart';

abstract class BaseGeminiRepository {
  Stream<Candidates> streamContent({
    required Content content,
    Uint8List? image,
  });

  Future<String> promptForEmbedding({
    required String userPrompt,
    required Map<String, List<num>>? embeddings,
  });
  Future<Map<String, List<num>>> batchEmbedeChunks({
    required List<String> textChuks,
  });
  double calculateEclideanDistance({
    required List<num> vectorA,
    required List<num> vectorB,
  });
}
