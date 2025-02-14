import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_button.dart';
import '../utils/validators.dart';
import '../services/auth_services.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscureText = true;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildLogo(),
                    const SizedBox(height: 40),
                    _buildUsernameField(),
                    const SizedBox(height: 20),
                    _buildPasswordField(),
                    _buildForgotPassword(),
                    const SizedBox(height: 30),
                    _buildSignInButton(),
                    const SizedBox(height: 30),
                    _buildOrSeparator(),
                    const SizedBox(height: 30),
                    _buildGoogleSignIn(),
                    const SizedBox(height: 25),
                    _buildCreateAccount(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Column(
      children: [
        SvgPicture.asset(
          'assets/icons/school.svg',
          color: const Color(0xFF2E384D),
          height: 80,
        ),
        const SizedBox(height: 20),
        Text(
          'Login',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.grey[800],
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }

  Widget _buildUsernameField() {
    return CustomTextField(
      controller: _usernameController,
      label: 'Email ID',
      hintText: 'Enter your email',
      labelStyle: TextStyle(
        color: Colors.grey[700],
        fontWeight: FontWeight.w500,
      ),
      validator: Validators.validateEmail,
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey[400]!),
      ),
    );
  }

  Widget _buildPasswordField() {
    return CustomTextField(
      controller: _passwordController,
      label: 'Password',
      hintText: 'Enter your password',
      labelStyle: TextStyle(
        color: Colors.grey[700],
        fontWeight: FontWeight.w500,
      ),
      obscureText: _obscureText,
      validator: Validators.validatePassword,
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey[400]!),
      ),
      suffixIcon: IconButton(
        icon: Icon(
          _obscureText ? Icons.visibility : Icons.visibility_off,
          color: Colors.grey[600],
          size: 22,
        ),
        onPressed: () => setState(() => _obscureText = !_obscureText),
      ),
    );
  }

  Widget _buildForgotPassword() {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
        ),
        child: Text(
          'Forget?',
          style: TextStyle(
            color: const Color(0xFF4CAF50),
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
Widget _buildSignInButton() {
  return CustomButton(
    onPressed: _handleSignIn,
    text: 'Login',
    isLoading: _isLoading,
    style: CustomButtonStyle.filled,
    backgroundColor: const Color(0xFF2196F3),
    textColor: Colors.white,
    elevation: 2,
    borderRadius: 8,
    borderColor: const Color(0xFF2196F3), // Same as background color
  );
}
  Widget _buildOrSeparator() {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: Colors.grey[400],
            thickness: 1,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'or',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          child: Divider(
            color: Colors.grey[400],
            thickness: 1,
          ),
        ),
      ],
    );
  }

 Widget _buildGoogleSignIn() {
  return CustomButton(
    onPressed: _handleGoogleSignIn,
    text: 'Sign in with Google',
    style: CustomButtonStyle.outline,
    icon: SvgPicture.asset(
      'assets/icons/google.svg',
      height: 20,
      color: const Color(0xFF4285F4),
    ),
    textColor: const Color(0xFF4285F4),
    borderColor: const Color(0xFF4285F4),
    borderRadius: 8,
    elevation: 0,
    backgroundColor: Colors.transparent,
  );
}
  Widget _buildCreateAccount() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'New to Finds Logistics?',
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 14,
          ),
        ),
        TextButton(
          onPressed: () => Navigator.pushReplacementNamed(context, '/register'),
          style: TextButton.styleFrom(
            padding: const EdgeInsets.only(left: 6),
          ),
          child: Text(
            'Register',
            style: TextStyle(
              color: const Color(0xFF4CAF50),
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _handleSignIn() async {
  if (_formKey.currentState!.validate()) {
    setState(() => _isLoading = true);
    
    await AuthService.signIn(
      _usernameController.text,
      _passwordController.text,
    );

    // Navigate to home screen
    Navigator.pushReplacementNamed(context, '/');
    
    setState(() => _isLoading = false);
  }
}

  Future<void> _handleGoogleSignIn() async {
    // Implement Google Sign-In
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
