// import 'package:flutter/material.dart';
// import '../repositories/user_repository_impl.dart';

// class LoginPage extends StatefulWidget {
//   @override
//   _LoginPageState createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   String _errorMessage = '';

//   Future<void> _loginUser() async {
//     final email = _emailController.text.trim();
//     final password = _passwordController.text.trim();

//     if (email.isEmpty || password.isEmpty) {
//       setState(() {
//         _errorMessage = 'Please fill in all fields.';
//       });
//       return;
//     }

//     final userRepository = UserRepositoryImpl();
//     final user = await userRepository.getUser();

//     if (user != null &&
//         user['email'] == email &&
//         user['password'] == password) {
//       setState(() {
//         _errorMessage = '';
//       });
//       _showSuccessDialog('Login Successful', 'Welcome back!');
//     } else {
//       setState(() {
//         _errorMessage = 'Invalid email or password.';
//       });
//       _showErrorDialog('Login Failed', 'Invalid email or password.');
//     }
//   }

//   void _showSuccessDialog(String title, String message) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text(title,
//             style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
//         content: Text(message, style: TextStyle(color: Colors.black87)),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.pop(context);
//               Navigator.pushNamed(context, '/home');
//             },
//             child: Text('OK',
//                 style:
//                     TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
//           ),
//         ],
//       ),
//     );
//   }

//   void _showErrorDialog(String title, String message) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text(title,
//             style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
//         content: Text(message, style: TextStyle(color: Colors.black87)),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: Text('OK',
//                 style:
//                     TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[50],
//       appBar: AppBar(
//         title: Text('Login',
//             style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.white)),
//         backgroundColor: Colors.teal,
//         elevation: 6,
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Welcome Back!',
//               style: TextStyle(
//                 fontSize: 32,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.teal[800],
//               ),
//             ),
//             const SizedBox(height: 20),
//             Text(
//               'Email',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.w600,
//                 color: Colors.teal[700],
//               ),
//             ),
//             const SizedBox(height: 8),
//             TextField(
//               controller: _emailController,
//               decoration: InputDecoration(
//                 hintText: 'Enter your email',
//                 hintStyle: TextStyle(color: Colors.teal[300]),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 filled: true,
//                 fillColor: Colors.white,
//               ),
//             ),
//             const SizedBox(height: 16),
//             Text(
//               'Password',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.w600,
//                 color: Colors.teal[700],
//               ),
//             ),
//             const SizedBox(height: 8),
//             TextField(
//               controller: _passwordController,
//               obscureText: true,
//               decoration: InputDecoration(
//                 hintText: 'Enter your password',
//                 hintStyle: TextStyle(color: Colors.teal[300]),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 filled: true,
//                 fillColor: Colors.white,
//               ),
//             ),
//             const SizedBox(height: 10),
//             if (_errorMessage.isNotEmpty)
//               Padding(
//                 padding: const EdgeInsets.only(bottom: 10),
//                 child: Text(
//                   _errorMessage,
//                   style: TextStyle(
//                       color: Colors.red,
//                       fontSize: 14,
//                       fontWeight: FontWeight.bold),
//                 ),
//               ),
//             const SizedBox(height: 20),
//             Center(
//               child: ElevatedButton(
//                 onPressed: _loginUser,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.teal,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 48,
//                     vertical: 12,
//                   ),
//                 ),
//                 child: Text(
//                   'Login',
//                   style: TextStyle(
//                       fontSize: 18,
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             Center(
//               child: TextButton(
//                 onPressed: () {
//                   Navigator.pushNamed(context, '/register');
//                 },
//                 child: Text(
//                   "Don't have an account? Register",
//                   style: TextStyle(
//                     color: Colors.teal[700],
//                     fontSize: 16,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flashlight_plugin/flashlight_plugin.dart'; // Плагін ліхтарика
// import '../repositories/user_repository_impl.dart';

// class LoginPage extends StatefulWidget {
//   @override
//   _LoginPageState createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   String _errorMessage = '';
//   bool _isFlashlightOn = false; // Стан ліхтарика

//   Future<void> _toggleFlashlight() async {
//     try {
//       setState(() {
//         _isFlashlightOn = !_isFlashlightOn;
//       });
//       await FlashlightPlugin.toggleFlashlight(_isFlashlightOn);
//     } catch (e) {
//       setState(() {
//         _isFlashlightOn = false;
//       });
//       _showErrorDialog(
//           'Error', 'Flashlight is not supported on this platform.');
//     }
//   }

//   Future<void> _loginUser() async {
//     final email = _emailController.text.trim();
//     final password = _passwordController.text.trim();

//     if (email.isEmpty || password.isEmpty) {
//       setState(() {
//         _errorMessage = 'Please fill in all fields.';
//       });
//       return;
//     }

//     final userRepository = UserRepositoryImpl();
//     final user = await userRepository.getUser();

//     if (user != null &&
//         user['email'] == email &&
//         user['password'] == password) {
//       setState(() {
//         _errorMessage = '';
//       });
//       _showSuccessDialog('Login Successful', 'Welcome back!');
//     } else {
//       setState(() {
//         _errorMessage = 'Invalid email or password.';
//       });
//       _showErrorDialog('Login Failed', 'Invalid email or password.');
//     }
//   }

//   void _showSuccessDialog(String title, String message) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text(title,
//             style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
//         content: Text(message, style: TextStyle(color: Colors.black87)),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.pop(context);
//               Navigator.pushNamed(context, '/home');
//             },
//             child: Text('OK',
//                 style:
//                     TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
//           ),
//         ],
//       ),
//     );
//   }

//   void _showErrorDialog(String title, String message) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text(title,
//             style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
//         content: Text(message, style: TextStyle(color: Colors.black87)),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: Text('OK',
//                 style:
//                     TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[50],
//       appBar: AppBar(
//         title: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               'Login',
//               style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white),
//             ),
//             IconButton(
//               icon: Icon(
//                 _isFlashlightOn ? Icons.flashlight_on : Icons.flashlight_off,
//                 color: Colors.white,
//               ),
//               onPressed: _toggleFlashlight,
//             ),
//           ],
//         ),
//         backgroundColor: Colors.teal,
//         elevation: 6,
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Welcome Back!',
//               style: TextStyle(
//                 fontSize: 32,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.teal[800],
//               ),
//             ),
//             const SizedBox(height: 20),
//             Text(
//               'Email',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.w600,
//                 color: Colors.teal[700],
//               ),
//             ),
//             const SizedBox(height: 8),
//             TextField(
//               controller: _emailController,
//               decoration: InputDecoration(
//                 hintText: 'Enter your email',
//                 hintStyle: TextStyle(color: Colors.teal[300]),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 filled: true,
//                 fillColor: Colors.white,
//               ),
//             ),
//             const SizedBox(height: 16),
//             Text(
//               'Password',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.w600,
//                 color: Colors.teal[700],
//               ),
//             ),
//             const SizedBox(height: 8),
//             TextField(
//               controller: _passwordController,
//               obscureText: true,
//               decoration: InputDecoration(
//                 hintText: 'Enter your password',
//                 hintStyle: TextStyle(color: Colors.teal[300]),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 filled: true,
//                 fillColor: Colors.white,
//               ),
//             ),
//             const SizedBox(height: 10),
//             if (_errorMessage.isNotEmpty)
//               Padding(
//                 padding: const EdgeInsets.only(bottom: 10),
//                 child: Text(
//                   _errorMessage,
//                   style: TextStyle(
//                       color: Colors.red,
//                       fontSize: 14,
//                       fontWeight: FontWeight.bold),
//                 ),
//               ),
//             const SizedBox(height: 20),
//             Center(
//               child: ElevatedButton(
//                 onPressed: _loginUser,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.teal,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 48,
//                     vertical: 12,
//                   ),
//                 ),
//                 child: Text(
//                   'Login',
//                   style: TextStyle(
//                       fontSize: 18,
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             Center(
//               child: TextButton(
//                 onPressed: () {
//                   Navigator.pushNamed(context, '/register');
//                 },
//                 child: Text(
//                   "Don't have an account? Register",
//                   style: TextStyle(
//                     color: Colors.teal[700],
//                     fontSize: 16,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flashlight_plugin/flashlight_plugin.dart'; // Плагін ліхтарика
import '../repositories/user_repository_impl.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _errorMessage = '';
  bool _isFlashlightOn = false; // Стан ліхтарика

  Future<void> _toggleFlashlight() async {
    try {
      setState(() {
        _isFlashlightOn = !_isFlashlightOn;
      });
      await FlashlightPlugin.toggleFlashlight(_isFlashlightOn);
    } catch (e) {
      setState(() {
        _isFlashlightOn = false;
      });
      _showErrorDialog(
          'Error', 'Flashlight is not supported on this platform.');
    }
  }

  Future<void> _loginUser() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      setState(() {
        _errorMessage = 'Please fill in all fields.';
      });
      return;
    }

    final userRepository = UserRepositoryImpl();
    final user = await userRepository.getUser();

    if (user != null &&
        user['email'] == email &&
        user['password'] == password) {
      setState(() {
        _errorMessage = '';
      });
      _showSuccessDialog('Login Successful', 'Welcome back!');
    } else {
      setState(() {
        _errorMessage = 'Invalid email or password.';
      });
      _showErrorDialog('Login Failed', 'Invalid email or password.');
    }
  }

  void _showSuccessDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title,
            style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
        content: Text(message, style: TextStyle(color: Colors.black87)),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/home');
            },
            child: Text('OK',
                style:
                    TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  void _showErrorDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title,
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
        content: Text(message, style: TextStyle(color: Colors.black87)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK',
                style:
                    TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.teal,
        elevation: 6,
        centerTitle: true,
        title: Stack(
          alignment: Alignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Login',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            IconButton(
              icon: Icon(
                _isFlashlightOn ? Icons.flashlight_on : Icons.flashlight_off,
                color: Colors.white,
              ),
              onPressed: _toggleFlashlight,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome Back!',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.teal[800],
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Email',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.teal[700],
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                hintText: 'Enter your email',
                hintStyle: TextStyle(color: Colors.teal[300]),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Password',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.teal[700],
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Enter your password',
                hintStyle: TextStyle(color: Colors.teal[300]),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            if (_errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(
                  _errorMessage,
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
              ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _loginUser,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 48,
                    vertical: 12,
                  ),
                ),
                child: Text(
                  'Login',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
                child: Text(
                  "Don't have an account? Register",
                  style: TextStyle(
                    color: Colors.teal[700],
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
