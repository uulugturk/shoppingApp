import 'package:bitirme_projesi/ui/cubit/loginPageCubit.dart';
import 'package:bitirme_projesi/ui/views/homePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F7F8),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(22.0),
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 32.0),
                SizedBox(
                    height: 150,
                    width: 250,
                    child: Image.asset("pictures/logo.png")),
                const SizedBox(height: 12.0),
                const Text(
                  "Tek Tıkla Yenilikçi Alışveriş!",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 1, 1, 4),
                  ),
                ),
                const SizedBox(height: 32.0),
                const Text(
                  "Hoş Geldiniz!",
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4335A7),
                  ),
                ),
                const SizedBox(height: 32.0),
                TextField(
                  controller: _userNameController,
                  decoration: InputDecoration(
                    labelText: "Kullanıcı Adı",
                    prefixIcon: Icon(Icons.person, color: Color(0xFF4335A7)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 32.0),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Şifre",
                    prefixIcon: Icon(Icons.lock, color: Color(0xFF4335A7)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                const Text(
                  "Şifremi Unuttum",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4335A7),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF4335A7),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  onPressed: () {
                    context.read<LoginPagecubit>().loginUser(
                          _userNameController.text,
                          _passwordController.text,
                        );
                  },
                  child: const Text(
                    "Giriş Yap",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                const Text(
                  "Ya Da",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4335A7),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF4335A7),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text(
                    "Üye Ol",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
                BlocListener<LoginPagecubit, bool>(
                  listener: (context, state) {
                    if (state) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomePage(),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              "Giriş başarısız, lütfen bilgilerinizi kontrol edin."),
                        ),
                      );
                    }
                  },
                  child: Container(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
