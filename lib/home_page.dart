import 'package:agri_app/bookresources_page.dart';
import 'screens/crop_pred.dart';
import 'screens/crop_price_screen.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'profile_page.dart';
import 'about_page.dart';
import 'connect_page.dart';
import 'login_page.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:weather/weather.dart';
import 'package:intl/intl.dart';
import 't&c.dart';
import 'h&s.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();
  LatLng? _currentPosition;
  final WeatherFactory _wf = WeatherFactory('99cd17ead708315e89e03a2d6deaa5de');
  Weather? _weather;
  
  final List<Widget> _pages = [
    const HomeContent(),
    const BookResourcesPage(),
    ConnectPage(),
  ];

  @override
  void initState() {
    super.initState();
    _initializeLocationAndWeather();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _initializeLocationAndWeather() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        _showErrorDialog('Location services are disabled. Please enable them.');
        return;
      }

      var permission = await Permission.location.request();
      if (permission.isGranted) {
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );

        setState(() {
          _currentPosition = LatLng(position.latitude, position.longitude);
        });

        // Fetch weather data
        try {
          final weather = await _wf.currentWeatherByLocation(
            position.latitude,
            position.longitude,
          );
          setState(() {
            _weather = weather;
          });
        } catch (e) {
          _showErrorDialog('Failed to fetch weather data. Please try again later.');
        }
      } else {
        _showErrorDialog('Location permission is required for weather updates.');
      }
    } catch (e) {
      _showErrorDialog('Error initializing location services: $e');
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'FarmConnect',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      drawer: _buildDrawer(context),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: _pages,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.chat),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: 'Booked'),
          BottomNavigationBarItem(
              icon: Icon(Icons.connect_without_contact), label: 'Connect'),
        ],
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text("Prajwal"),
            accountEmail: const Text("prajwal.2242046@viit.ac.in"),
            currentAccountPicture: const CircleAvatar(
              backgroundImage: AssetImage('assets/images/farmer.png'),
            ),
            decoration: const BoxDecoration(color: Colors.green),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const ProfilePage()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('About Us'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AboutUsPage()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.description_outlined, color: Colors.green),
            title: Text(
              'Terms & Conditions',
              style: TextStyle(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TermsPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.description_outlined, color: Colors.green),
            title: Text(
              'Help & Support',
              style: TextStyle(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HelpSupportPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Logout'),
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const LoginPage()));
            },
          ),
        ],
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
  return SingleChildScrollView(
    child: Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.blue[700]!,
                Colors.blue[500]!,
              ],
            ),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: const WeatherWidget(),
        ),
        const SizedBox(height: 24),
        _buildCarousel(),
        const SizedBox(height: 16),
        _buildFeatureCards(context),
      ],
    ),
  );
}

Widget _buildCarousel() {
  final List<Map<String, String>> carouselItems = [
    {
      'image': 'assets/images/tracter.jpeg',
      'title': 'Modern Farming Equipment',
    },
    {
      'image': 'assets/images/harvestor.jpeg',
      'title': 'Advanced Harvesters',
    },
    {
      'image': 'assets/images/irrigation.jpeg',
      'title': 'Agricultural Innovation',
    },
  ];

  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          children: [
            Container(
              width: 4,
              height: 20,
              decoration: BoxDecoration(
                color: Colors.blue[700],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              'Featured Equipment',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue[900],
              ),
            ),
          ],
        ),
      ),
      CarouselSlider(
        options: CarouselOptions(
          height: 220.0,
          autoPlay: true,
          enlargeCenterPage: true,
          viewportFraction: 0.85,
          autoPlayInterval: const Duration(seconds: 4),
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeStrategy: CenterPageEnlargeStrategy.height,
        ),
        items: carouselItems.map((item) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    item['image']!,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    left: 20,
                    right: 20,
                    child: Text(
                      item['title']!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            offset: Offset(1, 1),
                            blurRadius: 2,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    ],
  );
}
  Widget _buildFeatureCards(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          _buildFeatureCard(
            context,
            Icons.water_drop,
            'Crop Yield Prediction',
            const CropPredictionScreen(),
          ),
          _buildFeatureCard(
            context,
            Icons.currency_exchange,
            'Market Trends',
            const CropPricePredictionScreen(),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard(
      BuildContext context, IconData icon, String label, Widget screen) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        leading: Icon(icon, size: 40, color: Colors.green),
        title: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.green),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => screen),
          );
        },
      ),
    );
  }
}

class WeatherWidget extends StatefulWidget {
  const WeatherWidget({Key? key}) : super(key: key);

  @override
  State<WeatherWidget> createState() => _WeatherWidgetState();
}

class _WeatherWidgetState extends State<WeatherWidget> {
  Weather? _weather;
  final WeatherFactory _weatherFactory = WeatherFactory('99cd17ead708315e89e03a2d6deaa5de');
  Position? _currentPosition;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _initializeWeather();
  }
  Future<void> _initializeWeather() async {
    try {
      setState(() {
        _isLoading = true;
        _error = null;
      });

      // First, check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() {
          _error = 'Location services are disabled. Please enable them.';
          _isLoading = false;
        });
        return;
      }

      // Check location permission
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() {
            _error = 'Location permission denied';
            _isLoading = false;
          });
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        setState(() {
          _error = 'Location permissions are permanently denied';
          _isLoading = false;
        });
        return;
      }

      // Get accurate position with maximum accuracy
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
        timeLimit: const Duration(seconds: 30),
      );
      
      // Force location refresh by clearing cache
      await Geolocator.getLastKnownPosition();
      
      Weather weather = await _weatherFactory.currentWeatherByLocation(
        position.latitude,
        position.longitude,
      );
      
      setState(() {
        _weather = weather;
        _currentPosition = position;
        _isLoading = false;
      });

      // Debug print to verify coordinates
      debugPrint('Location: ${position.latitude}, ${position.longitude}');
      debugPrint('Weather location: ${weather.areaName}');
      
    } catch (e) {
      setState(() {
        _error = 'Failed to load weather data: $e';
        _isLoading = false;
      });
      debugPrint('Error getting weather: $e');
    }
  }
  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator(color: Colors.white));
    }

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              _error!,
              style: const TextStyle(color: Colors.white),
            ),
            TextButton(
              onPressed: _initializeWeather,
              child: const Text('Retry', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      );
    }

    if (_weather == null) {
      return const Center(
        child: Text(
          'No weather data available',
          style: TextStyle(color: Colors.white),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _weather?.areaName ?? 'Unknown Location',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    DateFormat('EEEE, d MMM').format(_weather!.date!),
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    '${_weather!.temperature!.celsius?.round()}°C',
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    _getWeatherIcon(_weather!.weatherMain ?? 'Clear'),
                    size: 32,
                    color: Colors.amber,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildWeatherInfo(
                'Min',
                '${_weather!.tempMin!.celsius?.round()}°C',
                Icons.arrow_downward,
              ),
              _buildWeatherInfo(
                'Max',
                '${_weather!.tempMax!.celsius?.round()}°C',
                Icons.arrow_upward,
              ),
              _buildWeatherInfo(
                'Humidity',
                '${_weather!.humidity}%',
                Icons.water_drop,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherInfo(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, size: 20, color: Colors.grey[600]),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  IconData _getWeatherIcon(String condition) {
    switch (condition.toLowerCase()) {
      case 'clear':
        return Icons.wb_sunny;
      case 'clouds':
        return Icons.cloud;
      case 'rain':
        return Icons.water_drop;
      case 'drizzle':
        return Icons.grain;
      case 'thunderstorm':
        return Icons.flash_on;
      case 'snow':
        return Icons.ac_unit;
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return Icons.cloud_queue;
      case 'tornado':
        return Icons.tornado;
      case 'windy':
        return Icons.air;
      default:
        return Icons.wb_sunny; // Default to sunny icon
    }
  }
}