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
  int billeteDiez = 0;
  int billeteveinte = 0;
  int billetecincuenta = 0;
  int billetecien = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: SafeArea(
          child: DefaultTextStyle(
        style: GoogleFonts.poppins(color: AppColor.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Cantidad de billetes en el cajero'),
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
              entregarBilletes(20000);
            }, () {
              entregarBilletes(50000);
            }),
            const SizedBox(height: 20),
            rowButton('100,000', '200,000', () {
              entregarBilletes(100000);
            }, () {
              entregarBilletes(200000);
            }),
            const SizedBox(height: 20),
            rowButton('300,000', '400,000', () {
              entregarBilletes(300000);
            }, () {
              entregarBilletes(400000);
            }),
            const SizedBox(height: 20),
            rowButton('600,000', 'Solicitar un valor \ndiferente', () {
              entregarBilletes(600000);
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
            const SizedBox(height: 20),
            Text('Billetes entregados:',
                style: GoogleFonts.poppins(fontSize: 18)),
            Text('10,000: $billeteDiez'),
            Text('20,000: $billeteveinte'),
            Text('50,000: $billetecincuenta'),
            Text('100,000: $billetecien')
          ],
        ),
      )),
    );
  }

  void comprobarTexfield() {
    if (_textEditingController.text != '') {
      int? valor = int.parse(_textEditingController.text);
      if (valor % 10000 == 0 && valor >= 10000) {
        entregarBilletes(valor);
        Navigator.pop(context);
        _textEditingController.clear();
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

  void entregarBilletes(int valor) {
    int acumulado = 0;
    int iteracion = 1;
    int billete10000 = 0;
    int billete20000 = 0;
    int billete50000 = 0;
    int billete100000 = 0;

    do {
      if (iteracion <= 1) {
        if (acumulado + 10000 <= valor) {
          acumulado += 10000;
          billete10000++;
        }
      }
      if (iteracion <= 2) {
        if (acumulado + 20000 <= valor) {
          acumulado += 20000;
          billete20000++;
        }
      }
      if (iteracion <= 3) {
        if (acumulado + 50000 <= valor) {
          acumulado += 50000;
          billete50000++;
        }
      }
      if (iteracion <= 4) {
        if (acumulado + 100000 <= valor) {
          acumulado += 100000;
          billete100000++;
        }
      }
      if (iteracion == 4) {
        iteracion = 0;
      }
      iteracion++;
    } while (acumulado < valor);
    setState(() {
      diezCantidad = diezCantidad - billete10000;
      veinteCantidad = veinteCantidad - billete20000;
      cincuentaCantidad = cincuentaCantidad - billete50000;
      cienCantidad = cienCantidad - billete100000;

      billeteDiez = billete10000;
      billeteveinte = billete20000;
      billetecincuenta = billete50000;
      billetecien = billete100000;
    });
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
}
