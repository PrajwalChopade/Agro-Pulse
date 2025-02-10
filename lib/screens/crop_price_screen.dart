import 'package:flutter/material.dart';

class CropPricePredictionScreen extends StatefulWidget {
  const CropPricePredictionScreen({super.key});

  @override
  _CropPricePredictionScreenState createState() => _CropPricePredictionScreenState();
}

class _CropPricePredictionScreenState extends State<CropPricePredictionScreen> {
  String? selectedState;
  String? selectedCrop;
  final _productionController = TextEditingController();
  double _predictedPrice = 0.0;

  // Define states list
  final List<String> states = [
    'Andhra Pradesh', 'Bihar', 'Gujarat', 'Haryana', 'Karnataka',
    'Madhya Pradesh', 'Maharashtra', 'Orissa', 'Punjab', 'Rajasthan',
    'Tamil Nadu', 'Uttar Pradesh', 'West Bengal'
  ];

  // Define crops with their MSP prices
  final Map<String, double> cropPrices = {
    'ARHAR': 7550.0,
    'COTTON': 7121.0,
    'GRAM': 5335.0,
    'GROUNDNUT': 6783.0,
    'MAIZE': 2225.0,
    'MOONG': 8682.0,
    'PADDY': 2300.0,
    'MUSTARD': 5650.0,
    'SUGARCANE': 3050.0,
    'WHEAT': 2275.0,
  };

  // Get emoji for crop
  String getCropEmoji(String crop) {
    switch (crop) {
      case 'ARHAR': return '🌱';
      case 'COTTON': return '☁️';
      case 'GRAM': return '🌰';
      case 'GROUNDNUT': return '🥜';
      case 'MAIZE': return '🌽';
      case 'MOONG': return '💚';
      case 'PADDY': return '🌾';
      case 'MUSTARD': return '🌼';
      case 'SUGARCANE': return '🎋';
      case 'WHEAT': return '🌾';
      default: return '🌱';
    }
  }

  void _calculatePrice() {
    if (!_validateInputs()) return;

    try {
      double production = double.parse(_productionController.text);
      double basePrice = cropPrices[selectedCrop!] ?? 0.0;
      setState(() {
        _predictedPrice = production * basePrice;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error calculating price'))
      );
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
        title: const Text('Crop Price Calculator 🌾'),
        backgroundColor: Colors.green.shade700,
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.green.shade50, Colors.white],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const Text(
                        '📍 Select Location',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      const SizedBox(height: 16),
                      DropdownButtonFormField<String>(
                        value: selectedState,
                        decoration: InputDecoration(
                          labelText: 'State',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          prefixIcon: const Icon(Icons.location_on, color: Colors.green),
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
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const Text(
                        '🌾 Select Crop',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      const SizedBox(height: 16),
                      DropdownButtonFormField<String>(
                        value: selectedCrop,
                        decoration: InputDecoration(
                          labelText: 'Crop Type',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          prefixIcon: const Icon(Icons.grass, color: Colors.green),
                        ),
                        items: cropPrices.keys.map((String crop) {
                          return DropdownMenuItem(
                            value: crop,
                            child: Text('${getCropEmoji(crop)} $crop'),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedCrop = newValue;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const Text(
                        '⚖️ Enter Production',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _productionController,
                        decoration: InputDecoration(
                          labelText: 'Production (in quintals)',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          prefixIcon: const Icon(Icons.balance, color: Colors.green),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _calculatePrice,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.green.shade700,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Calculate Price 💰',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(height: 24),
              Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.green.shade100, Colors.green.shade50],
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.price_check, color: Colors.green, size: 28),
                          SizedBox(width: 8),
                          Text(
                            'Estimated Price',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        '₹${_predictedPrice.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.green.shade700,
                        ),
                      ),
                      if (selectedCrop != null) ...[
                        const SizedBox(height: 8),
                        Text(
                          'Base MSP: ₹${cropPrices[selectedCrop]}/quintal',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.green.shade900,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}