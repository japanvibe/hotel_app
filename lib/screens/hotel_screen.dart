import 'package:app/screens/room_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:app/api/api.dart';
import 'package:dio/dio.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HotelScreen extends StatefulWidget {
  const HotelScreen({super.key});

  @override
  State<HotelScreen> createState() => HotelScreenState();
}

class HotelScreenState extends State<HotelScreen> {
  var currentSliderPage = 0;

  @override
  Widget build(BuildContext context) {
    final priceFormat = NumberFormat('#,###');
    final dio = Dio();
    dio.options.headers["Header"] = "header";
    final client = RestClient(dio);
    final hotel = client.getHotel();
    return Scaffold(
        body: FutureBuilder<Hotel>(
      future: hotel,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 30, bottom: 10),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Отель',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            )
                          ]),
                    ),
                    Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        CarouselSlider(
                            items: snapshot.data!.image_urls!.map((e) {
                              return Builder(builder: ((context) {
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.network(
                                    e,
                                    errorBuilder: (context, error, stackTrace) {
                                      return const Center(
                                          child: Icon(Icons.error));
                                    },
                                  ),
                                );
                              }));
                            }).toList(),
                            options: CarouselOptions(
                              viewportFraction: 1,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  currentSliderPage = index;
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
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                    child: Wrap(
                                        children: List.generate(
                                            snapshot.data!.image_urls!.length,
                                            (index) {
                                      var opacity = 0.28 - 0.06 * index;
                                      if (opacity < 0) opacity = 0;
                                      return Container(
                                        margin: const EdgeInsets.all(2),
                                        alignment: Alignment.center,
                                        height: 7,
                                        width: 7,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: currentSliderPage == index
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
                    Column(
                      //main info
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //rating
                        Padding(
                          padding: const EdgeInsets.only(top: 12, bottom: 5),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Container(
                              color: const Color.fromRGBO(255, 199, 0, 0.2),
                              width: 149,
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Icon(Icons.star,
                                          color: Color.fromRGBO(255, 168, 0, 1),
                                          size: 15),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 3),
                                        child: Text(
                                          '${snapshot.data!.rating} ${snapshot.data!.rating_name!}',
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
                          '${snapshot.data!.name}',
                          style: const TextStyle(
                              fontSize: 22,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        ),
                        TextButton(
                            //address
                            onPressed: () {},
                            style:
                                TextButton.styleFrom(padding: EdgeInsets.zero),
                            child: Text(
                              '${snapshot.data!.adress}',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color.fromRGBO(13, 114, 255, 1),
                              ),
                            )),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Wrap(
                            direction: Axis.horizontal,
                            crossAxisAlignment: WrapCrossAlignment.end,
                            children: [
                              Text(
                                //price
                                'от ${priceFormat.format(snapshot.data!.minimal_price).replaceAll(',', ' ')} ₽',
                                style: const TextStyle(
                                    overflow: TextOverflow.fade,
                                    fontSize: 30,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 7, bottom: 4),
                                child: Text(
                                  snapshot.data!.price_for_it!.toLowerCase(),
                                  style: const TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Color.fromRGBO(130, 135, 150, 1),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Column(
                          //about hotel
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Об отеле',
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: 160,
                              child: GridView.builder(
                                  shrinkWrap: true,
                                  padding: const EdgeInsets.all(15),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisSpacing: 10,
                                          mainAxisSpacing: 10,
                                          childAspectRatio: 2,
                                          crossAxisCount: 2),
                                  itemBuilder: ((context, index) {
                                    return Text(
                                        '${snapshot.data!.about_the_hotel!['peculiarities'].elementAt(index)}',
                                        style: const TextStyle(
                                          overflow: TextOverflow.fade,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color:
                                              Color.fromRGBO(130, 135, 150, 1),
                                        ));
                                  }),
                                  itemCount: snapshot
                                      .data!
                                      .about_the_hotel!['peculiarities']
                                      .length),
                            ),
                            Text(
                                '${snapshot.data!.about_the_hotel!['description']}',
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Color.fromRGBO(0, 0, 0, 0.9))),
                            Padding(
                              //buttons
                              padding: const EdgeInsets.only(bottom: 40),
                              child: ListView(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15),
                                shrinkWrap: true,
                                children: [
                                  ListTile(
                                    onTap: () {},
                                    minLeadingWidth: 24,
                                    titleAlignment:
                                        ListTileTitleAlignment.center,
                                    leading: const Padding(
                                      padding: EdgeInsets.only(top: 4),
                                      child: Image(
                                          image: AssetImage('emoji-happy.png')),
                                    ),
                                    title: const Text('Удобства',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color:
                                                Color.fromRGBO(44, 48, 53, 1))),
                                    subtitle: const Text('Самое необходимое',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: Color.fromRGBO(
                                                130, 135, 150, 1))),
                                    trailing: const Padding(
                                      padding: EdgeInsets.only(top: 4),
                                      child: Icon(Icons.arrow_forward_ios,
                                          size: 18,
                                          color: Color.fromRGBO(44, 48, 53, 1)),
                                    ),
                                  ),
                                  ListTile(
                                      onTap: () {},
                                      minLeadingWidth: 24,
                                      titleAlignment:
                                          ListTileTitleAlignment.center,
                                      leading: const Padding(
                                        padding: EdgeInsets.only(top: 4),
                                        child: Image(
                                            image:
                                                AssetImage('tick-square.png')),
                                      ),
                                      title: const Text('Что включено',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: Color.fromRGBO(
                                                  44, 48, 53, 1))),
                                      subtitle: const Text('Самое необходимое',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Color.fromRGBO(
                                                  130, 135, 150, 1))),
                                      trailing: const Padding(
                                        padding: EdgeInsets.only(top: 4),
                                        child: Icon(Icons.arrow_forward_ios,
                                            size: 18,
                                            color:
                                                Color.fromRGBO(44, 48, 53, 1)),
                                      )),
                                  ListTile(
                                      onTap: () {},
                                      minLeadingWidth: 24,
                                      titleAlignment:
                                          ListTileTitleAlignment.center,
                                      leading: const Padding(
                                        padding: EdgeInsets.only(top: 4),
                                        child: Image(
                                            image:
                                                AssetImage('close-square.png')),
                                      ),
                                      title: const Text('Что не включено',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: Color.fromRGBO(
                                                  44, 48, 53, 1))),
                                      subtitle: const Text('Самое необходимое',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Color.fromRGBO(
                                                  130, 135, 150, 1))),
                                      trailing: const Padding(
                                        padding: EdgeInsets.only(top: 4),
                                        child: Icon(Icons.arrow_forward_ios,
                                            size: 18,
                                            color:
                                                Color.fromRGBO(44, 48, 53, 1)),
                                      ))
                                ],
                              ),
                            )
                          ]),
                    ),
                    //room button
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return RoomScreen(hotelName: snapshot.data!.name!);
                          }));
                        },
                        style: ElevatedButton.styleFrom(
                            minimumSize:
                                Size(MediaQuery.of(context).size.width, 48),
                            backgroundColor:
                                const Color.fromRGBO(13, 114, 255, 1),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15))),
                        child: const Text('К выбору номера',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w500)))
                  ]),
            ),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    ));
  }
}
