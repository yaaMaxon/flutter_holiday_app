import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'screens/login.dart';
import 'screens/register.dart';
import 'screens/profile.dart';
import 'screens/home.dart';
import 'repositories/user_repository_impl.dart';
import 'services/api_service.dart';
import 'services/cache_service.dart';
import 'cubit/user_cubit.dart';
import 'cubit/holiday_cubit.dart';

void main() {
  final apiService = ApiService();
  final cacheService = CacheService();

  runApp(MyApp(apiService: apiService, cacheService: cacheService));
}

class MyApp extends StatelessWidget {
  final ApiService apiService;
  final CacheService cacheService;

  const MyApp({
    Key? key,
    required this.apiService,
    required this.cacheService,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => UserCubit(cacheService)..initializeUser(),
        ),
        BlocProvider(
          create: (_) => HolidayCubit(apiService, cacheService),
        ),
      ],
      child: MaterialApp(
        title: 'Магічний Лічильник',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
          useMaterial3: true,
        ),
        home: const InitialScreen(),
        routes: {
          '/login': (context) => LoginPage(),
          '/register': (context) => RegisterPage(),
          '/profile': (context) => ProfilePage(),
          '/home': (context) => HomePage(),
        },
      ),
    );
  }
}

class InitialScreen extends StatefulWidget {
  const InitialScreen({Key? key}) : super(key: key);

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  final UserRepositoryImpl userRepository = UserRepositoryImpl();
  late ConnectivityResult _connectivityResult;

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    try {
      final connectivity = await Connectivity().checkConnectivity();
      _connectivityResult = connectivity; // Призначаємо результат

      final bool isLoggedIn = await userRepository.isLoggedIn();

      if (_connectivityResult == ConnectivityResult.none) {
        _showNetworkError();
      } else if (isLoggedIn) {
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        Navigator.pushReplacementNamed(context, '/login');
      }
    } catch (e) {
      debugPrint("Error checking connectivity: $e");
      _showNetworkError();
    }
  }

  void _showNetworkError() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("No Internet Connection"),
        content: const Text(
          "You are not connected to the internet. Please connect to continue.",
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/login');
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
