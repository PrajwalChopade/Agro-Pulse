import 'package:flutter/material.dart';
import '../../models/crop_model.dart';

class CropPredictionScreen extends StatefulWidget {
  const CropPredictionScreen({super.key});

  @override
  _CropPredictionScreenState createState() => _CropPredictionScreenState();
}

class _CropPredictionScreenState extends State<CropPredictionScreen> {
  final CropModel cropModel = CropModel();
  String predictionResult = "Enter values to predict";
  List<CropInfo>? predictions;

  final TextEditingController nController = TextEditingController();
  final TextEditingController pController = TextEditingController();
  final TextEditingController kController = TextEditingController();
  final TextEditingController tempController = TextEditingController();
  final TextEditingController humidityController = TextEditingController();
  final TextEditingController phController = TextEditingController();
  final TextEditingController rainfallController = TextEditingController();

  @override
  void initState() {
    super.initState();
    cropModel.loadModel();
  }

  Future<void> predictCrop() async {
    try {
      // Parse inputs
      double? n = double.tryParse(nController.text);
      double? p = double.tryParse(pController.text);
      double? k = double.tryParse(kController.text);
      double? temperature = double.tryParse(tempController.text);
      double? humidity = double.tryParse(humidityController.text);
      double? ph = double.tryParse(phController.text);
      double? rainfall = double.tryParse(rainfallController.text);

      if ([n, p, k, temperature, humidity, ph, rainfall].contains(null)) {
        throw Exception("Please enter valid numbers for all fields");
      }

      List<double> inputFeatures = [n!, p!, k!, temperature!, humidity!, ph!, rainfall!];

      // Get predictions
      List<CropInfo> newPredictions = cropModel.predict(inputFeatures);

      setState(() {
        predictions = newPredictions;
        predictionResult = "Predictions Ready!";
      });
    } catch (e) {
      setState(() {
        predictionResult = "Error: ${e.toString()}";
        predictions = null;
      });
    }
  }

  Widget _buildPredictionCards() {
    if (predictions == null) return Container();

    return Column(
      children: predictions!.map((crop) {
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      crop.name.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${(crop.confidence * 100).toStringAsFixed(1)}%',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text('🌱 Description: ${crop.description}'),
                const SizedBox(height: 8),
                Text('📅 Growing Season: ${crop.growingSeason}'),
                Text('💧 Water Requirement: ${crop.waterRequirement}'),
                Text('🌍 Soil Type: ${crop.soilType}'),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crop Predictor'),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildInputField(nController, 'Nitrogen (N)', 'Range: 0-140'),
            _buildInputField(pController, 'Phosphorus (P)', 'Range: 5-145'),
            _buildInputField(kController, 'Potassium (K)', 'Range: 5-205'),
            _buildInputField(tempController, 'Temperature (°C)', 'Range: 8-44'),
            _buildInputField(humidityController, 'Humidity (%)', 'Range: 14-100'),
            _buildInputField(phController, 'pH', 'Range: 3.5-10'),
            _buildInputField(rainfallController, 'Rainfall (mm)', 'Range: 20-300'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: predictCrop,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
              child: const Text(
                'Predict Crop',
                style: TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                predictionResult,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            _buildPredictionCards(),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(TextEditingController controller, String label, String hint) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: const OutlineInputBorder(),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }

  @override
  void dispose() {
    cropModel.closeModel();
    nController.dispose();
    pController.dispose();
    kController.dispose();
    tempController.dispose();
    humidityController.dispose();
    phController.dispose();
    rainfallController.dispose();
    super.dispose();
  }
}
