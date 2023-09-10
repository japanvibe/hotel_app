import 'package:app/screens/hotel_screen.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class PaidScreen extends StatelessWidget {
  const PaidScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final rand = Random();
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            title: const Text('Заказ оплачен',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
            shadowColor: Colors.white,
            leading: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                color: Colors.black,
                iconSize: 18,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            automaticallyImplyLeading: false),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 60),
                    child: Image(image: AssetImage('assets/party-popper.png')),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 15),
                    child: Text(
                      'Ваш заказ принят в работу',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 22,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height / 3),
                    child: Text(
                        'Подтверждение заказа №${rand.nextInt(1000000)} может занять некоторое время (от 1 часа до суток). Как только мы получим ответ от туроператора, вам на почту придет уведомление.',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Color.fromRGBO(130, 135, 150, 1))),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(context,
                            MaterialPageRoute(builder: (context) {
                          return const HotelScreen();
                        }), (route) => false);
                      },
                      style: ElevatedButton.styleFrom(
                          minimumSize:
                              Size(MediaQuery.of(context).size.width, 48),
                          backgroundColor:
                              const Color.fromRGBO(13, 114, 255, 1),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15))),
                      child: const Text('Супер!',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w500)))
                ]),
          ),
        ));
  }
}
