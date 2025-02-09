import 'package:tflite_flutter/tflite_flutter.dart';

class TFLiteHelper {
  late Interpreter _interpreter;
  bool _isModelLoaded = false;

  Future<void> loadModel() async {
    try {
      _interpreter = await Interpreter.fromAsset('assets/crop_price_predictor.tflite');
      _isModelLoaded = true;
      print("Model loaded successfully.");
    } catch (e) {
      print("Failed to load model: $e");
      _isModelLoaded = false;
    }
  }

Future<double> predictPrice(int stateIndex, int cropIndex, double production) async {
  if (!_isModelLoaded) {
    print("Error: Model is not loaded.");
    return 0.0;
  }

  try {
    // Prepare input data
    var input = [
      [
        stateIndex.toDouble(),
        cropIndex.toDouble(),
        production
      ]
    ];

    // Prepare output tensor
    var output = List.filled(1, List.filled(1, 0.0));

    // Run inference
    _interpreter.run(input, output);

    // Get the predicted price and clamp it
    double predictedPrice = output[0][0];
    return predictedPrice < 1000 ? 1000 : predictedPrice; // Clamp to minimum ₹1000
  } catch (e) {
    print("Prediction error: $e");
    return 0.0;
  }
}

  bool isModelLoaded() => _isModelLoaded;

  void closeModel() {
    if (_isModelLoaded) {
      _interpreter.close();
      _isModelLoaded = false;
    }
  }
}