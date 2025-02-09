// screens/crop_price_screen.dart
import 'package:flutter/material.dart';
// import '../helpers/tflite_helper.dart';
import 'package:agri_app/helper/tflite_helper.dart';

class CropPricePredictionScreen extends StatefulWidget {
  const CropPricePredictionScreen({super.key});

  @override
  _CropPricePredictionScreenState createState() => _CropPricePredictionScreenState();
}

class _CropPricePredictionScreenState extends State<CropPricePredictionScreen> {
  final TFLiteHelper _tfliteHelper = TFLiteHelper();
  double _predictedPrice = 0.0;
  bool _isLoading = false;
  
  String? selectedState;
  String? selectedCrop;
  final _productionController = TextEditingController();

  // Define states and crops lists
  final List<String> states = [
    'Andhra Pradesh', 'Bihar', 'Gujarat', 'Haryana', 'Karnataka',
    'Madhya Pradesh', 'Maharashtra', 'Orissa', 'Punjab', 'Rajasthan',
    'Tamil Nadu', 'Uttar Pradesh', 'West Bengal'
  ];

  final List<String> crops = [
    'ARHAR', 'COTTON', 'GRAM', 'GROUNDNUT', 'MAIZE',
    'MOONG', 'PADDY', 'MUSTARD', 'SUGARCANE', 'WHEAT'
  ];

  @override
  void initState() {
    super.initState();
    _loadModel();
  }

  @override
  void dispose() {
    _productionController.dispose();
    _tfliteHelper.closeModel();
    super.dispose();
  }

  Future<void> _loadModel() async {
    setState(() => _isLoading = true);
    await _tfliteHelper.loadModel();
    setState(() => _isLoading = false);
  }

  Future<void> _predictPrice() async {
    if (!_validateInputs()) return;

    setState(() => _isLoading = true);

    try {
      int stateIndex = states.indexOf(selectedState!);
      int cropIndex = crops.indexOf(selectedCrop!);
      double production = double.parse(_productionController.text);
      
      double price = await _tfliteHelper.predictPrice(stateIndex, cropIndex, production);
      setState(() {
        _predictedPrice = price;
        _isLoading = false;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error making prediction'))
      );
      setState(() => _isLoading = false);
    }
  }

  bool _validateInputs() {
    if (selectedState == null || selectedCrop == null || _productionController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields'))
      );
      return false;
    }
    
    if (double.tryParse(_productionController.text) == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid production value'))
      );
      return false;
    }
    
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crop Price Predictor'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: _isLoading 
        ? const Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                DropdownButtonFormField<String>(
                  value: selectedState,
                  decoration: const InputDecoration(
                    labelText: 'Select State',
                    border: OutlineInputBorder(),
                  ),
                  items: states.map((String state) {
                    return DropdownMenuItem(
                      value: state,
                      child: Text(state),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedState = newValue;
                    });
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: selectedCrop,
                  decoration: const InputDecoration(
                    labelText: 'Select Crop',
                    border: OutlineInputBorder(),
                  ),
                  items: crops.map((String crop) {
                    return DropdownMenuItem(
                      value: crop,
                      child: Text(crop),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedCrop = newValue;
                    });
                  },
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _productionController,
                  decoration: const InputDecoration(
                    labelText: 'Production (in quintals)',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _predictPrice,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  ),
                  child: const Text('Predict Price'),
                ),
                const SizedBox(height: 24),
                Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        const Text(
                          'Predicted Price',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '₹${_predictedPrice.toStringAsFixed(2)}',
                          style: const TextStyle(fontSize: 24, color: Colors.green),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
    );
  }
}