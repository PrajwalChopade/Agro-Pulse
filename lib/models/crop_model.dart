// File: lib/models/crop_model.dart

import 'package:tflite_flutter/tflite_flutter.dart';
import 'dart:typed_data';
import 'dart:math';

class CropInfo {
  final String name;
  final String description;
  final String growingSeason;
  final String waterRequirement;
  final String soilType;
  final double confidence;

  CropInfo({
    required this.name,
    required this.description,
    required this.growingSeason,
    required this.waterRequirement,
    required this.soilType,
    required this.confidence,
  });
}

class CropModel {
  final Random _random = Random();
  List<CropInfo>? _currentPredictions;
  List<double>? _lastInputs;
  
  final Map<String, Map<String, String>> cropDetails = {
  'rice': {
    'description': 'Staple food crop grown in flooded fields',
    'growing_season': 'Kharif season (June-November)',
    'water_requirement': 'High (1000-2500mm)',
    'soil_type': 'Clay or clay loam'
  },
  'maize': {
    'description': 'Versatile crop used for food, feed, and industrial products',
    'growing_season': 'Year-round in suitable conditions',
    'water_requirement': 'Medium (500-800mm)',
    'soil_type': 'Well-drained loamy soil'
  },
  'chickpea': {
    'description': 'Protein-rich legume crop',
    'growing_season': 'Rabi season (October-March)',
    'water_requirement': 'Low (400-600mm)',
    'soil_type': 'Sandy loam to clay loam'
  },
  'kidneybeans': {
    'description': 'Nutrient-rich legume crop used for food',
    'growing_season': 'Kharif & Rabi seasons',
    'water_requirement': 'Moderate (500-700mm)',
    'soil_type': 'Well-drained loamy soil'
  },
  'pigeonpeas': {
    'description': 'Drought-resistant legume crop',
    'growing_season': 'Kharif season (June-December)',
    'water_requirement': 'Low (600-1000mm)',
    'soil_type': 'Well-drained sandy loam'
  },
  'mothbeans': {
    'description': 'Drought-tolerant legume grown in arid regions',
    'growing_season': 'Kharif season (June-September)',
    'water_requirement': 'Low (300-500mm)',
    'soil_type': 'Sandy loam soil'
  },
  'mungbean': {
    'description': 'Protein-rich pulse crop used for dal & sprouts',
    'growing_season': 'Kharif & Summer season',
    'water_requirement': 'Low (450-600mm)',
    'soil_type': 'Sandy loam, well-drained soil'
  },
  'blackgram': {
    'description': 'Highly nutritious legume used in dal preparations',
    'growing_season': 'Kharif & Rabi season',
    'water_requirement': 'Medium (600-800mm)',
    'soil_type': 'Loamy or clay loam'
  },
  'lentil': {
    'description': 'Protein-rich legume crop, widely consumed as dal',
    'growing_season': 'Rabi season (October-April)',
    'water_requirement': 'Low (300-450mm)',
    'soil_type': 'Sandy loam to clay loam'
  },
  'pomegranate': {
    'description': 'Drought-tolerant fruit crop with high market value',
    'growing_season': 'Throughout the year',
    'water_requirement': 'Low to medium (500-800mm)',
    'soil_type': 'Well-drained sandy loam'
  },
  'banana': {
    'description': 'Tropical fruit crop requiring high moisture',
    'growing_season': 'Year-round in warm climates',
    'water_requirement': 'High (1500-2500mm)',
    'soil_type': 'Fertile loamy soil with good drainage'
  },
  'mango': {
    'description': 'Popular tropical fruit tree with seasonal production',
    'growing_season': 'Flowering in January-April, harvested in summer',
    'water_requirement': 'Medium (750-2500mm)',
    'soil_type': 'Well-drained loamy soil'
  },
  'grapes': {
    'description': 'Fruit crop used for wine, juice, and fresh consumption',
    'growing_season': 'Spring and early summer',
    'water_requirement': 'Medium (600-800mm)',
    'soil_type': 'Well-drained sandy loam'
  },
  'watermelon': {
    'description': 'Juicy summer fruit with high water content',
    'growing_season': 'Summer (February-June)',
    'water_requirement': 'Moderate (400-600mm)',
    'soil_type': 'Sandy loam, well-drained'
  },
  'muskmelon': {
    'description': 'Sweet summer fruit with high vitamin content',
    'growing_season': 'Summer (March-July)',
    'water_requirement': 'Moderate (500-700mm)',
    'soil_type': 'Sandy loam, well-drained'
  },
  'apple': {
    'description': 'Temperate fruit crop grown in colder regions',
    'growing_season': 'Winter dormancy, harvested in late summer-autumn',
    'water_requirement': 'Medium (800-1200mm)',
    'soil_type': 'Well-drained loamy soil'
  },
  'orange': {
    'description': 'Citrus fruit rich in Vitamin C',
    'growing_season': 'Harvested in winter and early summer',
    'water_requirement': 'Medium (1000-1500mm)',
    'soil_type': 'Well-drained sandy loam'
  },
  'papaya': {
    'description': 'Fast-growing fruit crop with year-round production',
    'growing_season': 'Throughout the year',
    'water_requirement': 'Medium (800-1000mm)',
    'soil_type': 'Loamy soil with good drainage'
  },
  'coconut': {
    'description': 'Tropical tree with multiple uses from food to oil production',
    'growing_season': 'Throughout the year',
    'water_requirement': 'High (1500-2500mm)',
    'soil_type': 'Well-drained sandy loam'
  },
  'cotton': {
    'description': 'Fiber crop used for textile production',
    'growing_season': 'Kharif season (April-October)',
    'water_requirement': 'Medium (700-1200mm)',
    'soil_type': 'Well-drained black cotton soil'
  },
  'jute': {
    'description': 'Fiber crop used for making sacks and ropes',
    'growing_season': 'March-June (Harvested in July-September)',
    'water_requirement': 'High (1200-1500mm)',
    'soil_type': 'Alluvial soil, loamy'
  },
  'coffee': {
    'description': 'Beverage crop grown in shaded high-altitude areas',
    'growing_season': 'Harvested in winter (November-March)',
    'water_requirement': 'High (1500-2500mm)',
    'soil_type': 'Well-drained volcanic or loamy soil'
  }
};

  Future<void> loadModel() async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      print("✅ Model Loaded Successfully! (Random Mode)");
      printModelDetails();
    } catch (e) {
      print("❌ Model Load Error: $e");
      rethrow;
    }
  }

  void printModelDetails() {
    print("📌 Running in Random Prediction Mode");
    print("📌 Available Crops: ${cropDetails.length}");
  }

  bool _areInputsEqual(List<double> newInputs) {
    if (_lastInputs == null) return false;
    if (newInputs.length != _lastInputs!.length) return false;
    for (int i = 0; i < newInputs.length; i++) {
      if (newInputs[i] != _lastInputs![i]) return false;
    }
    return true;
  }

  List<CropInfo> predict(List<double> inputFeatures) {
    // If inputs haven't changed and we have predictions, return existing predictions
    if (_currentPredictions != null && _areInputsEqual(inputFeatures)) {
      return _currentPredictions!;
    }

    try {
      // Store new inputs
      _lastInputs = List.from(inputFeatures);

      // Get 3 random unique crops
      final selectedCrops = List<String>.from(cropDetails.keys.toList())
        ..shuffle(_random);
      selectedCrops.length = 3;

      // Generate confidence scores
      List<double> confidences = [0.85 + _random.nextDouble() * 0.15,
                                0.70 + _random.nextDouble() * 0.15,
                                0.55 + _random.nextDouble() * 0.15];

      // Create CropInfo objects
      _currentPredictions = List.generate(3, (index) {
        String cropName = selectedCrops[index];
        Map<String, String> details = cropDetails[cropName]!;
        
        return CropInfo(
          name: cropName,
          description: details['description']!,
          growingSeason: details['growing_season']!,
          waterRequirement: details['water_requirement']!,
          soilType: details['soil_type']!,
          confidence: confidences[index],
        );
      });

      print("🎲 New Predictions Generated");
      _currentPredictions!.forEach((crop) {
        print("🌱 ${crop.name}: ${(crop.confidence * 100).toStringAsFixed(1)}%");
      });

      return _currentPredictions!;
    } catch (e) {
      print("❌ Prediction Error: $e");
      throw Exception("Prediction error: $e");
    }
  }

  void resetPredictions() {
    _currentPredictions = null;
    _lastInputs = null;
  }

  void closeModel() {
    print("👋 Random prediction mode closed");
  }
}