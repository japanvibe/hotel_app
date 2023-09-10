import 'package:app/api/api.dart';
import 'package:app/screens/paid_screen.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:app/widget/tourist_card.dart';
import 'package:email_validator/email_validator.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  List<TouristCard> touristList = [
    TouristCard(
        touristNumber: 'Первый турист', formKey: GlobalKey<FormState>()),
  ];
  @override
  Widget build(BuildContext context) {
    final buyerFormKey = GlobalKey<FormState>();
    final phoneMaskFormatter = MaskTextInputFormatter(
        mask: '+7 (9##) ###-##-##',
        filter: {"#": RegExp(r'[0-9]')},
        type: MaskAutoCompletionType.lazy);
    final priceFormat = NumberFormat('#,###');
    final dio = Dio();
    dio.options.headers["Header"] = "header";
    final client = RestClient(dio);
    final bookingData = client.getBooking();
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            title: const Text('Бронирование',
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
        body: FutureBuilder<Booking>(
          future: bookingData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Padding(
                  padding: const EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            //main info
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //rating
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 12, bottom: 5),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: Container(
                                    color:
                                        const Color.fromRGBO(255, 199, 0, 0.2),
                                    width: 149,
                                    child: Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const Icon(Icons.star,
                                                color: Color.fromRGBO(
                                                    255, 168, 0, 1),
                                                size: 15),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 3),
                                              child: Text(
                                                '${snapshot.data!.horating} ${snapshot.data!.rating_name!}',
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                    color: Color.fromRGBO(
                                                        255, 168, 0, 1)),
                                              ),
                                            )
                                          ]),
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                //name
                                '${snapshot.data!.hotel_name}',
                                style: const TextStyle(
                                    fontSize: 22,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),
                              ),
                              TextButton(
                                  //address
                                  onPressed: () {},
                                  style: TextButton.styleFrom(
                                      padding: EdgeInsets.zero),
                                  child: Text(
                                    '${snapshot.data!.hotel_adress}',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Color.fromRGBO(13, 114, 255, 1),
                                    ),
                                  ))
                            ],
                          ),
                          Padding(
                              //booking data
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2,
                                          child: const Text('Вылет из',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                  color: Color.fromRGBO(
                                                      130, 135, 150, 1))),
                                        ),
                                        Expanded(
                                          child: Text(
                                              '${snapshot.data!.departure}',
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.black)),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2,
                                          child: const Text('Страна, город',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                  color: Color.fromRGBO(
                                                      130, 135, 150, 1))),
                                        ),
                                        Expanded(
                                          child: Text(
                                              '${snapshot.data!.arrival_country}',
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.black)),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2,
                                          child: const Text('Даты',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                  color: Color.fromRGBO(
                                                      130, 135, 150, 1))),
                                        ),
                                        Expanded(
                                          child: Text(
                                              '${snapshot.data!.tour_date_start}-${snapshot.data!.tour_date_stop}',
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.black)),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2,
                                          child: const Text('Кол-во ночей',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                  color: Color.fromRGBO(
                                                      130, 135, 150, 1))),
                                        ),
                                        Expanded(
                                          child: Text(
                                              '${snapshot.data!.number_of_nights}',
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.black)),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2,
                                          child: const Text('Отель',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                  color: Color.fromRGBO(
                                                      130, 135, 150, 1))),
                                        ),
                                        Expanded(
                                          child: Text(
                                              '${snapshot.data!.hotel_name}',
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.black)),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2,
                                          child: const Text('Номер',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                  color: Color.fromRGBO(
                                                      130, 135, 150, 1))),
                                        ),
                                        Expanded(
                                          child: Text('${snapshot.data!.room}',
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.black)),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2,
                                          child: const Text('Питание',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                  color: Color.fromRGBO(
                                                      130, 135, 150, 1))),
                                        ),
                                        Expanded(
                                          child: Text(
                                              '${snapshot.data!.nutrition}',
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.black)),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              )),
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Column(
                              //buyer info
                              children: [
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Информация о покупателе',
                                      style: TextStyle(
                                          fontSize: 22,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                                Form(
                                    key: buyerFormKey,
                                    child: Column(children: [
                                      TextFormField(
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Поле заполнено некорректно';
                                          }
                                          return null;
                                        },
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [phoneMaskFormatter],
                                        decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            label: Text(
                                              'Номер телефона',
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  color: Color.fromRGBO(
                                                      169, 171, 183, 1),
                                                  fontWeight: FontWeight.w400),
                                            )),
                                      ),
                                      TextFormField(
                                        onEditingComplete: () {
                                          buyerFormKey.currentState!.validate();
                                        },
                                        validator: (value) {
                                          if (!EmailValidator.validate(
                                                  value!) ||
                                              value.isEmpty) {
                                            return 'Поле заполнено некорректно';
                                          }
                                          return null;
                                        },
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        decoration: const InputDecoration(
                                            contentPadding:
                                                EdgeInsets.only(left: 0),
                                            border: InputBorder.none,
                                            label: Text(
                                              'Почта',
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  color: Color.fromRGBO(
                                                      169, 171, 183, 1),
                                                  fontWeight: FontWeight.w400),
                                            )),
                                      )
                                    ])),
                                const Text(
                                  'Эти данные никому не передаются. После оплаты мы вышлем чек на указанный вами номер и почту.',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Color.fromRGBO(130, 135, 150, 1),
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                          //tourist list
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Column(
                              children: [
                                ListView.builder(
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return touristList.elementAt(index);
                                  },
                                  itemCount: touristList.length,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const Text(
                                          'Добавить туриста',
                                          style: TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black),
                                        ),
                                        ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            child: InkWell(
                                              onTap: () {
                                                setState(() {
                                                  touristList.add(TouristCard(
                                                      touristNumber:
                                                          'Второй турист',
                                                      formKey: GlobalKey<
                                                          FormState>()));
                                                });
                                              },
                                              child: Container(
                                                  width: 32,
                                                  height: 32,
                                                  decoration:
                                                      const BoxDecoration(
                                                          color: Color.fromRGBO(
                                                              13, 114, 255, 1)),
                                                  child: const Icon(Icons.add,
                                                      color: Colors.white,
                                                      size: 20)),
                                            ))
                                      ]),
                                )
                              ],
                            ),
                          ),
                          //final price
                          Padding(
                              //booking data
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2,
                                          child: const Text('Тур',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                  color: Color.fromRGBO(
                                                      130, 135, 150, 1))),
                                        ),
                                        Expanded(
                                          child: Text(
                                              textAlign: TextAlign.end,
                                              '${priceFormat.format(snapshot.data!.tour_price).replaceAll(',', ' ')} ₽',
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.black)),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2,
                                          child: const Text('Топливный сбор',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                  color: Color.fromRGBO(
                                                      130, 135, 150, 1))),
                                        ),
                                        Expanded(
                                          child: Text(
                                              textAlign: TextAlign.end,
                                              '${priceFormat.format(snapshot.data!.fuel_charge).replaceAll(',', ' ')} ₽',
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.black)),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2,
                                          child: const Text('Сервисный сбор',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                  color: Color.fromRGBO(
                                                      130, 135, 150, 1))),
                                        ),
                                        Expanded(
                                          child: Text(
                                              textAlign: TextAlign.end,
                                              '${priceFormat.format(snapshot.data!.service_charge).replaceAll(',', ' ')} ₽',
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.black)),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2,
                                          child: const Text('К оплате',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                  color: Color.fromRGBO(
                                                      130, 135, 150, 1))),
                                        ),
                                        Expanded(
                                          child: Text(
                                              textAlign: TextAlign.end,
                                              '${priceFormat.format(snapshot.data!.tour_price! + snapshot.data!.fuel_charge! + snapshot.data!.service_charge!).replaceAll(',', ' ')} ₽',
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  color: Color.fromRGBO(
                                                      13, 114, 255, 1))),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              )),
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: ElevatedButton(
                                onPressed: () {
                                  bool touristsDataValid = false;
                                  for (var tourist in touristList) {
                                    if (tourist.getKey().currentState != null) {
                                      touristsDataValid = tourist
                                          .getKey()
                                          .currentState!
                                          .validate();
                                      if (!touristsDataValid) break;
                                    } else {
                                      break;
                                    }
                                  }
                                  var buyerDataValid =
                                      buyerFormKey.currentState!.validate();

                                  if (touristsDataValid && buyerDataValid) {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return const PaidScreen();
                                    }));
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                    minimumSize: Size(
                                        MediaQuery.of(context).size.width, 48),
                                    backgroundColor:
                                        const Color.fromRGBO(13, 114, 255, 1),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15))),
                                child: Text(
                                    'Оплатить ${priceFormat.format(snapshot.data!.tour_price! + snapshot.data!.fuel_charge! + snapshot.data!.service_charge!).replaceAll(',', ' ')} ₽',
                                    style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500))),
                          )
                        ]),
                  ));
            }
            return const Center(child: CircularProgressIndicator());
          },
        ));
  }
}
