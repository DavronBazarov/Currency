import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'class_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

Color _iconColor = Colors.black;

class _HomePageState extends State<HomePage> {
  Icon _unFold = const Icon(
    Icons.unfold_less,
    color: Colors.black,
    size: 30,
  );

  @override
  initState() {
    super.initState();
    getData();
  }

  getData() async {
    const String url = "https://nbu.uz/uz/exchange-rates/json/";
    final response = await http.get(Uri.parse(url));
    final body = jsonDecode(response.body);
    if (body is List) {
      return body.map((e) => Currency.fromJson(e)).toList();
    } else {
      return [].cast<Currency>();
    }
  }

  bool _moreInfo = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFECF0F1),
      appBar: AppBar(
        backgroundColor: const Color(0xFFECF0F1),
        leading: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: _iconColor,
              size: 25,
            )),
        title: const Text(
          "Exchange Rates",
          style: TextStyle(
              color: Colors.black, fontSize: 24, fontWeight: FontWeight.w300),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.calculate_outlined,
                color: _iconColor,
                size: 28,
              )),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search,
                color: _iconColor,
                size: 28,
              )),
        ],
      ),
      body: FutureBuilder(
        future: getData(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          List<Currency> data = snapshot.data!;
          return ListView.builder(
              itemCount: data.length,
              itemBuilder: (_, index) {
                if (data[index].nbuBuyPrice!.isEmpty) {
                  data[index].nbuBuyPrice = '-  -  -';
                  data[index].nbuCellPrice = '-  -  -';
                }
                return itemBuilder(
                  code: data[index].code,
                  cbPrice: data[index].cbPrice,
                  nbuBuyPrice: data[index].nbuBuyPrice,
                  nbuCellPrice: data[index].nbuCellPrice,
                );
              });
        },
      ),
    );
  }

  Widget itemBuilder({String? code, cbPrice, nbuBuyPrice, nbuCellPrice}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          child: Container(
            height: 150,
            width: double.infinity,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, top: 10),
              child: Column(
                children: [
                  Row(
                    children: [
                      Image.asset(
                        "assets/$code.png",
                        height: 28,
                        width: 28,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "$code",
                        style: const TextStyle(fontSize: 18),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.55,
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.notifications_active_outlined,
                            color: Colors.black38,
                            size: 28,
                          )),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        height: 70,
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                const Text(
                                  "MB",
                                  style: TextStyle(color: Colors.black38),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  cbPrice,
                                  style: const TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                const Text(
                                  "SOTIB OLISH",
                                  style: TextStyle(color: Colors.black38),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  nbuBuyPrice,
                                  style: const TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                const Text(
                                  "SOTISH",
                                  style: TextStyle(color: Colors.black38),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  nbuCellPrice,
                                  style: const TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )),
    );
  }
}
