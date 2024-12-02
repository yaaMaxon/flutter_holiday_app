import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../components/action_button.dart';
import '../components/holiday_list.dart';
import '../services/api_service.dart';
import '../services/cache_service.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ConnectivityResult _connectivityResult;
  late Stream<ConnectivityResult> _connectivityStream;
  final ApiService apiService = ApiService();
  final CacheService cacheService = CacheService();
  late Future<List<Map<String, dynamic>>> holidaysFuture;

  @override
  void initState() {
    super.initState();
    _connectivityStream = Connectivity().onConnectivityChanged;
    _initializeConnectivity();
    holidaysFuture = _loadHolidays();
  }

  Future<void> _initializeConnectivity() async {
    _connectivityResult = await Connectivity().checkConnectivity();
    if (_connectivityResult == ConnectivityResult.none) {
      _showNetworkError();
    }
    _connectivityStream.listen((result) {
      if (result == ConnectivityResult.none) {
        _showNetworkError();
      }
    });
  }

  Future<List<Map<String, dynamic>>> _loadHolidays() async {
    try {
      final holidays = await apiService.fetchHolidays();
      await cacheService.saveHolidays(holidays);
      return holidays;
    } catch (e) {
      final cachedHolidays = await cacheService.getHolidays();
      if (cachedHolidays != null) {
        return List<Map<String, dynamic>>.from(cachedHolidays);
      } else {
        throw Exception('No internet and no cached data');
      }
    }
  }

  void _showNetworkError() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'No Internet Connection',
          style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        content: const Text(
          'Your connection to the internet has been lost. Please reconnect to continue.',
          style: TextStyle(
            color: Colors.black54,
            fontSize: 16,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              'OK',
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Holidays',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.teal,
        centerTitle: true,
        elevation: 5,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.teal,
              Colors.tealAccent,
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text(
                'Upcoming Holidays',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'View the list of public holidays in England and Wales.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: HolidayList(holidaysFuture: holidaysFuture),
              ),
              const SizedBox(height: 20),
              Center(
                child: ActionButton(
                  text: 'Go to Profile',
                  color: Colors.teal,
                  textColor: Colors.white,
                  onPressed: () {
                    Navigator.pushNamed(context, '/profile');
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
