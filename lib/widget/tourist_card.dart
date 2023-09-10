import 'package:flutter/material.dart';

class TouristCard extends StatefulWidget {
  final String touristNumber;
  final GlobalKey<FormState> formKey;

  const TouristCard(
      {super.key, required this.touristNumber, required this.formKey});

  GlobalKey<FormState> getKey() {
    return formKey;
  }

  @override
  State<TouristCard> createState() => _TouristCardState();
}

class _TouristCardState extends State<TouristCard> {
  var isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      tilePadding: const EdgeInsets.all(0),
      childrenPadding: const EdgeInsets.symmetric(horizontal: 17),
      title: Text(widget.touristNumber,
          style: const TextStyle(
              fontSize: 22, fontWeight: FontWeight.w500, color: Colors.black)),
      trailing: Icon(
          isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
          color: const Color.fromRGBO(13, 114, 255, 1),
          size: 30),
      onExpansionChanged: (value) {
        setState(() {
          isExpanded = value;
        });
      },
      children: [
        Form(
          key: widget.formKey,
          child: Column(
            children: [
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Поле заполнено некорректно';
                  }
                  return null;
                },
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    label: Text(
                      'Имя',
                      style: TextStyle(
                          fontSize: 17,
                          color: Color.fromRGBO(169, 171, 183, 1),
                          fontWeight: FontWeight.w400),
                    )),
              ),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Поле заполнено некорректно';
                  }
                  return null;
                },
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    label: Text(
                      'Фамилия',
                      style: TextStyle(
                          fontSize: 17,
                          color: Color.fromRGBO(169, 171, 183, 1),
                          fontWeight: FontWeight.w400),
                    )),
              ),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Поле заполнено некорректно';
                  }
                  return null;
                },
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    label: Text(
                      'Дата рождения',
                      style: TextStyle(
                          fontSize: 17,
                          color: Color.fromRGBO(169, 171, 183, 1),
                          fontWeight: FontWeight.w400),
                    )),
              ),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Поле заполнено некорректно';
                  }
                  return null;
                },
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    label: Text(
                      'Гражданство',
                      style: TextStyle(
                          fontSize: 17,
                          color: Color.fromRGBO(169, 171, 183, 1),
                          fontWeight: FontWeight.w400),
                    )),
              ),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Поле заполнено некорректно';
                  }
                  return null;
                },
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    label: Text(
                      'Номер загранпаспорта',
                      style: TextStyle(
                          fontSize: 17,
                          color: Color.fromRGBO(169, 171, 183, 1),
                          fontWeight: FontWeight.w400),
                    )),
              ),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Поле заполнено некорректно';
                  }
                  return null;
                },
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    label: Text(
                      'Срок действия загранпаспорта',
                      style: TextStyle(
                          fontSize: 17,
                          color: Color.fromRGBO(169, 171, 183, 1),
                          fontWeight: FontWeight.w400),
                    )),
              )
            ],
          ),
        )
      ],
    );
  }
}
