import 'package:app/api/api.dart';
import 'package:app/screens/booking_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:dio/dio.dart';
import 'package:carousel_slider/carousel_slider.dart';

class RoomScreen extends StatefulWidget {
  final String hotelName;
  const RoomScreen({super.key, required this.hotelName});

  @override
  State<RoomScreen> createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {
  var currentSliderPage = 0;
  var currentSlider = 0;
  @override
  Widget build(BuildContext context) {
    final priceFormat = NumberFormat('#,###');
    final dio = Dio();
    dio.options.headers["Header"] = "header";
    final client = RestClient(dio);
    final rooms = client.getRooms();
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          title: Text(widget.hotelName,
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
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
      body: FutureBuilder<HotelRooms>(
          future: rooms,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              alignment: AlignmentDirectional.bottomCenter,
                              children: [
                                //slider
                                CarouselSlider(
                                    items: snapshot.data!.rooms!
                                        .elementAt(index)
                                        .image_urls!
                                        .map((e) {
                                      return Builder(builder: ((context) {
                                        return ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          child: Image.network(
                                            e,
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              return const Center(
                                                  child: Icon(Icons.error));
                                            },
                                          ),
                                        );
                                      }));
                                    }).toList(),
                                    options: CarouselOptions(
                                      viewportFraction: 1,
                                      onPageChanged: (i, reason) {
                                        setState(() {
                                          currentSlider = index;
                                          currentSliderPage = i;
                                        });
                                      },
                                    )),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(5),
                                        child: Container(
                                          color: Colors.white,
                                          width: 75,
                                          height: 21,
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                10, 5, 10, 5),
                                            child: Wrap(
                                                children: List.generate(
                                                    snapshot.data!.rooms!
                                                        .elementAt(index)
                                                        .image_urls!
                                                        .length, (i) {
                                              var opacity = 0.28 - 0.06 * i;
                                              if (opacity < 0) opacity = 0;
                                              return Container(
                                                margin: const EdgeInsets.all(2),
                                                alignment: Alignment.center,
                                                height: 7,
                                                width: 7,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: currentSlider ==
                                                              index &&
                                                          currentSliderPage == i
                                                      ? Colors.black
                                                      : Color.fromRGBO(
                                                          0, 0, 0, opacity),
                                                ),
                                              );
                                            })),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text(
                                //name
                                '${snapshot.data!.rooms!.elementAt(index).name}',
                                style: const TextStyle(
                                    fontSize: 22,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            GridView.builder(
                                //peculiarities
                                shrinkWrap: true,
                                padding: const EdgeInsets.all(15),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: 3.3),
                                itemBuilder: ((context, i) {
                                  return Text(
                                      snapshot.data!.rooms!
                                          .elementAt(index)
                                          .peculiarities!
                                          .elementAt(i),
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Color.fromRGBO(130, 135, 150, 1),
                                      ));
                                }),
                                itemCount: snapshot.data!.rooms!
                                    .elementAt(index)
                                    .peculiarities!
                                    .length),
                            Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: TextButton(
                                  onPressed: () {},
                                  style: TextButton.styleFrom(
                                      padding: EdgeInsets.zero),
                                  child: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text('Подробнее о номере',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Color.fromRGBO(
                                                  13, 114, 255, 1),
                                              fontWeight: FontWeight.w500)),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(left: 7, top: 2),
                                        child: Icon(Icons.arrow_forward_ios,
                                            size: 18,
                                            color: Color.fromRGBO(
                                                13, 114, 255, 1)),
                                      )
                                    ],
                                  )),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 10, bottom: 20),
                              child: Wrap(
                                crossAxisAlignment: WrapCrossAlignment.end,
                                direction: Axis.horizontal,
                                children: [
                                  Text(
                                    //price
                                    '${priceFormat.format(snapshot.data!.rooms!.elementAt(index).price).replaceAll(',', ' ')} ₽',
                                    style: const TextStyle(
                                        overflow: TextOverflow.fade,
                                        fontSize: 30,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 4, left: 7),
                                    child: Text(
                                      snapshot.data!.rooms!
                                          .elementAt(index)
                                          .price_per!
                                          .toLowerCase(),
                                      style: const TextStyle(
                                        overflow: TextOverflow.fade,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: Color.fromRGBO(130, 135, 150, 1),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            //Booking button
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return const BookingScreen();
                                  }));
                                },
                                style: ElevatedButton.styleFrom(
                                    minimumSize: Size(
                                        MediaQuery.of(context).size.width, 48),
                                    backgroundColor:
                                        const Color.fromRGBO(13, 114, 255, 1),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15))),
                                child: const Text('Выбрать номер',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500)))
                          ]),
                    );
                  },
                  itemCount: snapshot.data!.rooms!.length);
            }
            return const Center(child: CircularProgressIndicator());
          }),
    );
  }
}
