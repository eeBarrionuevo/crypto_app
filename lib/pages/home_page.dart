import 'dart:convert';

import 'package:crypto_app/models/crypo_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CryptoModel> cryptoList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  Future<void> getData() async {
    String path =
        "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false";
    Uri url = Uri.parse(path);
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      List listData = json.decode(response.body);
      cryptoList = listData.map((e) => CryptoModel.fromJson(e)).toList();
      print(cryptoList);
      setState(() {});
    }
  }

  showDetailModal(BuildContext context, CryptoModel model) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(26.0),
          decoration: BoxDecoration(
            color: Color(0xff1F2032),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Detalle Crypto",
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 6.0,
              ),
              Divider(
                thickness: 0.2,
                color: Colors.white30,
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5.0),
                child: Row(
                  children: [
                    const Text(
                      "Nombre: ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                      ),
                    ),
                    Text(
                      model.name,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 16.0,
                      ),
                    ),
                    const SizedBox(
                      width: 6.0,
                    ),
                    CircleAvatar(
                      radius: 8,
                      backgroundColor: Colors.white10,
                      backgroundImage: NetworkImage(model.image),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5.0),
                child: Row(
                  children: [
                    const Text(
                      "Precio Actual: ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                      ),
                    ),
                    Text(
                      model.currentPrice.toString(),
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5.0),
                child: Row(
                  children: [
                    const Text(
                      "Cap. Mercado: ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                      ),
                    ),
                    Text(
                      model.marketCap.toString(),
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5.0),
                child: Row(
                  children: [
                    const Text(
                      "Volúmen Total: ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                      ),
                    ),
                    Text(
                      model.totalVolume.toString(),
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5.0),
                child: Row(
                  children: [
                    const Text(
                      "Suministro Total: ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                      ),
                    ),
                    Text(
                      model.totalSupply.toString(),
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1F2032),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: const [
                        Text(
                          "Buenas noches",
                          style: TextStyle(
                            color: Colors.white60,
                            fontSize: 20.0,
                          ),
                        ),
                        SizedBox(
                          width: 6.0,
                        ),
                        Text(
                          "Manolo",
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14.0),
                        image: const DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              "https://images.pexels.com/photos/1516680/pexels-photo-1516680.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 24.0,
                ),
                TextField(
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 14.0),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.09),
                    hintText: "Buscar crypto",
                    hintStyle: const TextStyle(
                      color: Colors.white70,
                    ),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.white70,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14.0),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24.0,
                ),
                const Text(
                  "Listado general",
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 24.0,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemCount: cryptoList.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 8.0,
                      ),
                      child: ListTile(
                        onTap: () {
                          showDetailModal(
                            context,
                            cryptoList[index],
                          );
                        },
                        leading: CircleAvatar(
                          backgroundColor: Colors.white10,
                          backgroundImage:
                              NetworkImage(cryptoList[index].image),
                        ),
                        title: Text(
                          "${cryptoList[index].name} (${cryptoList[index].symbol.toUpperCase()})",
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                        subtitle: Row(
                          children: [
                            const Text(
                              "CM: ",
                              style: TextStyle(
                                  color: Colors.white70, fontSize: 14.0),
                            ),
                            Text(
                              cryptoList[index].marketCap.toStringAsFixed(2),
                              style: const TextStyle(
                                  color: Colors.white70, fontSize: 14.0),
                            ),
                          ],
                        ),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${cryptoList[index].currentPrice}",
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                              ),
                            ),
                            const SizedBox(
                              height: 3.0,
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                cryptoList[index].priceChangePercentage24H < 0
                                    ? const Icon(
                                        Icons.trending_down_rounded,
                                        color: Colors.redAccent,
                                      )
                                    : const Icon(
                                        Icons.trending_up_rounded,
                                        color: Colors.greenAccent,
                                      ),
                                const SizedBox(
                                  width: 4.0,
                                ),
                                Text(
                                  "${cryptoList[index].priceChangePercentage24H}",
                                  style: const TextStyle(
                                    color: Colors.white70,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
