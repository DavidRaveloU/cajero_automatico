import 'package:auto_size_text/auto_size_text.dart';
import 'package:cajero_automatico/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class WithdrawMoneyPage extends StatefulWidget {
  const WithdrawMoneyPage({super.key});

  @override
  State<WithdrawMoneyPage> createState() => _WithdrawMoneyPageState();
}

class _WithdrawMoneyPageState extends State<WithdrawMoneyPage> {
  final TextEditingController _textEditingController = TextEditingController();
  int diezCantidad = 200;
  int veinteCantidad = 200;
  int cincuentaCantidad = 200;
  int cienCantidad = 200;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: SafeArea(
          child: DefaultTextStyle(
        style: GoogleFonts.poppins(color: AppColor.white),
        child: Column(
          children: [
            const Text('Cantidad de billes en el cajero'),
            const SizedBox(height: 20),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Column(
                children: [
                  const AutoSizeText('\$10,000',
                      maxFontSize: 20,
                      minFontSize: 10,
                      style: TextStyle(fontSize: 18)),
                  const SizedBox(height: 10),
                  AutoSizeText(diezCantidad.toString(),
                      maxFontSize: 17,
                      minFontSize: 10,
                      style: const TextStyle(fontSize: 14)),
                ],
              ),
              Column(
                children: [
                  const AutoSizeText('\$20,000',
                      maxFontSize: 20,
                      minFontSize: 10,
                      style: TextStyle(fontSize: 18)),
                  const SizedBox(height: 10),
                  AutoSizeText(veinteCantidad.toString(),
                      maxFontSize: 17,
                      minFontSize: 10,
                      style: const TextStyle(fontSize: 14)),
                ],
              ),
              Column(
                children: [
                  const AutoSizeText('\$50,000',
                      maxFontSize: 20,
                      minFontSize: 10,
                      style: TextStyle(fontSize: 18)),
                  const SizedBox(height: 10),
                  AutoSizeText(cincuentaCantidad.toString(),
                      maxFontSize: 17,
                      minFontSize: 10,
                      style: const TextStyle(fontSize: 14)),
                ],
              ),
              Column(
                children: [
                  const AutoSizeText('\$100,000',
                      maxFontSize: 20,
                      minFontSize: 10,
                      style: TextStyle(fontSize: 18)),
                  const SizedBox(height: 10),
                  AutoSizeText(cienCantidad.toString(),
                      maxFontSize: 17,
                      minFontSize: 10,
                      style: const TextStyle(fontSize: 14)),
                ],
              )
            ]),
            const SizedBox(height: 20),
            const AutoSizeText(
              'Seleccionar valor a retirar',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            rowButton('20,000', '50,000', () {
              sistemaAcarreo(20000);
              esMultiploDe100000(1240000);
            }, () {
              sistemaAcarreo(50000);
            }),
            const SizedBox(height: 20),
            rowButton('100,000', '200,000', () {
              sistemaAcarreo(100000);
            }, () {
              sistemaAcarreo(200000);
            }),
            const SizedBox(height: 20),
            rowButton('300,000', '400,000', () {
              sistemaAcarreo(300000);
            }, () {
              sistemaAcarreo(400000);
            }),
            const SizedBox(height: 20),
            rowButton('600,000', 'Solicitar un valor \ndiferente', () {
              sistemaAcarreo(600000);
            }, () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      backgroundColor: AppColor.backgroundColor,
                      title: Text(
                        'Ingrese cantidad a retirar',
                        style: GoogleFonts.poppins(
                            color: AppColor.white, fontSize: 16),
                      ),
                      content: TextField(
                        controller: _textEditingController,
                        style: GoogleFonts.poppins(color: AppColor.white),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                        ],
                        decoration: InputDecoration(
                            focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.brown)),
                            border: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                            hintStyle: GoogleFonts.poppins(
                                color: AppColor.white.withOpacity(0.4)),
                            hintText: 'Ingrese cantidad'),
                      ),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Cancelar',
                              style: GoogleFonts.poppins(color: Colors.red),
                            )),
                        TextButton(
                            onPressed: () {
                              comprobarTexfield();
                            },
                            child: Text(
                              'Aceptar',
                              style: GoogleFonts.poppins(color: AppColor.white),
                            )),
                      ],
                    );
                  });
            }),
          ],
        ),
      )),
    );
  }

  void comprobarTexfield() {
    if (_textEditingController.text != '') {
      int? valor = int.parse(_textEditingController.text);
      if (valor % 10000 == 0 && valor >= 10000) {
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('La cantidad ingresada no es válida.'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  void esMultiploDe100000(int numero) {
    if (numero % 100000 == 0) {
      print('bien');
    } else {
      print('mal');
    }
  }

  Widget rowButton(
      String text1, String text2, VoidCallback boton1, VoidCallback boton2) {
    return DefaultTextStyle(
      style: GoogleFonts.poppins(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          MaterialButton(
            color: Colors.brown,
            onPressed: boton1,
            child: Text(text1),
          ),
          const Spacer(),
          MaterialButton(
            color: Colors.brown,
            onPressed: boton2,
            child: Text(
              text2,
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  void sistemaAcarreo(int valor) {
    int acomulado = 0;
    int billete10 = 0;
    int billete20 = 0;
    int billete50 = 0;
    int billete100 = 0;
    if (valor % 100000 == 0 && valor >= 200000) {}
  }
}
