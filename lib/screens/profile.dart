import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../repositories/user_repository_impl.dart';
import '../components/edit_name_dialog.dart';
import '../components/edit_email_dialog.dart';
import '../components/action_button.dart';
import '../components/user_info_block.dart';
import '../components/logout_confirmation_dialog.dart';
import '../components/network_error_dialog.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final UserRepositoryImpl userRepository = UserRepositoryImpl();
  late ConnectivityResult _connectivityResult;

  String userName = 'User Name';
  String userEmail = 'user@example.com';

  @override
  void initState() {
    super.initState();
    _checkInternetConnection();
    _loadUserData();
  }

  Future<void> _checkInternetConnection() async {
    _connectivityResult = await Connectivity().checkConnectivity();
    if (_connectivityResult == ConnectivityResult.none) {
      _showNetworkError();
    }
  }

  Future<void> _loadUserData() async {
    final user = await userRepository.getUser();
    if (user != null) {
      setState(() {
        userName = user['name']!;
        userEmail = user['email']!;
      });
    }
  }

  Future<void> _updateUserName(String newName) async {
    final user = await userRepository.getUser();
    if (user != null) {
      final email = user['email']!;
      final password = user['password']!;
      await userRepository.saveUser(email, password, newName);
      setState(() {
        userName = newName;
      });
    }
  }

  Future<void> _updateUserEmail(String newEmail) async {
    final user = await userRepository.getUser();
    if (user != null) {
      final name = user['name']!;
      final password = user['password']!;
      await userRepository.saveUser(newEmail, password, name);
      setState(() {
        userEmail = newEmail;
      });
    }
  }

  Future<void> _handleLogout() async {
    final shouldLogout = await _showLogoutConfirmationDialog();
    if (shouldLogout) {
      await userRepository.logout();
      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
    }
  }

  Future<void> _handleDeleteAccount() async {
    await userRepository.clearUser();
    Navigator.pushNamedAndRemoveUntil(context, '/register', (route) => false);
  }

  Future<bool> _showLogoutConfirmationDialog() async {
    return await showDialog<bool>(
          context: context,
          builder: (context) => LogoutConfirmationDialog(
            onConfirm: () => Navigator.pop(context, true),
          ),
        ) ??
        false;
  }

  void _showNetworkError() {
    showDialog(
      context: context,
      builder: (context) => const NetworkErrorDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[200], // Змінений колір фону на teal
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.teal,
        elevation: 6,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'User Profile',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.teal[800],
              ),
            ),
            const SizedBox(height: 20),
            UserInfoBlock(
              userName: userName,
              userEmail: userEmail,
              onEditName: () {
                showDialog(
                  context: context,
                  builder: (context) => EditNameDialog(
                    currentName: userName,
                    onNameSaved: _updateUserName,
                  ),
                );
              },
              onEditEmail: () {
                showDialog(
                  context: context,
                  builder: (context) => EditEmailDialog(
                    currentEmail: userEmail,
                    onEmailSaved: _updateUserEmail,
                  ),
                );
              },
            ),
            const SizedBox(height: 40),
            Center(
              child: ActionButton(
                text: 'Logout',
                color: Colors.teal, // Залишити без змін
                textColor: Colors.white,
                onPressed: _handleLogout,
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ActionButton(
                text: 'Delete Account',
                color: Colors.red, // Залишити без змін
                textColor: Colors.white,
                onPressed: _handleDeleteAccount,
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ActionButton(
                text: 'Return to Home',
                color: Colors.green,
                textColor: Colors.white,
                onPressed: () {
                  Navigator.pushNamed(context, '/home');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
