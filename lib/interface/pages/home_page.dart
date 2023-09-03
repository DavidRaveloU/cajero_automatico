import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../constants/colors.dart';

class CarruselImagen extends StatelessWidget {
  final Image imagen;
  final String title;
  final String content;
  const CarruselImagen({
    super.key,
    required this.imagen,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: GoogleFonts.poppins(color: AppColor.black),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              imagen,
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                width: double.infinity,
                color: AppColor.white,
                height: MediaQuery.sizeOf(context).height / 4.2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    AutoSizeText(title,
                        maxFontSize: 30,
                        minFontSize: 10,
                        style: const TextStyle(
                            color: Colors.blueAccent,
                            fontSize: 20,
                            fontWeight: FontWeight.w900)),
                    const SizedBox(height: 20),
                    AutoSizeText(content,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        maxFontSize: 20,
                        minFontSize: 10,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        )),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController _pageController = PageController();
  int _currentPage = 0;
  late Timer _timer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: SafeArea(
          child: Column(children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.8,
          child: PageView(
            onPageChanged: (value) {
              setState(() {
                _currentPage = value;
              });
            },
            scrollDirection: Axis.horizontal,
            controller: _pageController,
            children: [
              CarruselImagen(
                imagen: Image.asset(
                  'assets/imagen1.jpg',
                  cacheHeight: 1000,
                  fit: BoxFit.contain,
                  alignment: Alignment.topCenter,
                ),
                title: 'No compartas tu contraseña',
                content:
                    'Nunca compartas tu contraseña con nadie, ni siquiera con tu pareja, familiares o amigos.',
              ),
              CarruselImagen(
                  imagen: Image.asset(
                    'assets/imagen2.jpg',
                    cacheHeight: 1000,
                    fit: BoxFit.contain,
                    alignment: Alignment.topCenter,
                  ),
                  title: 'Retira en muy pocos pasos',
                  content:
                      'Ingresa tu tarjeta, selecciona el monto y retira. Así de fácil.'),
              CarruselImagen(
                  imagen: Image.asset(
                    'assets/imagen3.jpg',
                    cacheHeight: 1000,
                    fit: BoxFit.contain,
                    alignment: Alignment.topCenter,
                  ),
                  title: 'Tú tranquilo, yo nervioso',
                  content:
                      'No te preocupes, tu dinero está seguro con nosotros.'),
            ],
          ),
        ),
        const SizedBox(height: 20),
        SmoothPageIndicator(
          controller: _pageController,
          effect: const ExpandingDotsEffect(
            activeDotColor: Colors.brown,
            dotColor: AppColor.white,
            dotHeight: 10,
            dotWidth: 10,
            expansionFactor: 4,
            spacing: 5,
          ),
          count: 3,
          onDotClicked: (index) {
            _currentPage = index;
            _pageController.animateToPage(index,
                duration: const Duration(milliseconds: 500),
                curve: Curves.ease);
          },
        ),
        const SizedBox(height: 50),
        MaterialButton(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          color: Colors.brown,
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(context, '/retiro', (_) => false);
          },
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Retirar dinero',
                style: TextStyle(color: AppColor.white),
              ),
              SizedBox(width: 6),
              Icon(
                Icons.arrow_forward,
                color: AppColor.white,
              )
            ],
          ),
        )
      ])),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _timer = Timer.periodic(const Duration(seconds: 3), _autoScroll);
  }

  void _autoScroll(Timer timer) {
    if (_currentPage < 2) {
      _currentPage++;
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    } else {
      _currentPage = 0;
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }
}
