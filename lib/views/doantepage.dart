import 'package:flutter/material.dart';
import 'package:projectakhir/views/homepage.dart';

class DonatePage extends StatefulWidget {
  @override
  _DonatePageState createState() => _DonatePageState();
}

class _DonatePageState extends State<DonatePage> {
  String selectedCurrency = 'IDR'; // Mata uang yang dipilih
  List<double> price=[
    10000,
    50000,
    100000,
  ];

  Map<String, double> exchangeRates = {
    'IDR': 1, // Rupiah
    'USD': 0.000067, // Dolar Amerika
    'JPY': 0.0092, // Yen Jepang
    'PHP': 0.0033, // Peso
  };

  double calculateTotalPrice(int index) {
    return price[index] * exchangeRates[selectedCurrency]!;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff21254A),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(49, 39, 79, 1),
          title: Text('Donate Page', style: TextStyle(
            color: Colors.white
          ),),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Pilih Jumlah Donasi:',
              style: TextStyle(fontSize: 18,color: Colors.white),
            ),
            SizedBox(height: 10),
            Column(
              children: [
                SizedBox(height: 20,),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromRGBO(49, 39, 79, 1),
                  ),
                  onPressed: () {
                    double totalPrice = calculateTotalPrice(0);
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Pembayaran'),
                        content: Text(
                            'Total harga: ${totalPrice.toStringAsFixed(2)} $selectedCurrency'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              showDialog(context: context, builder:(context) =>
                              AlertDialog(
                                title: Text('Terima Kasih Telah Berdonasi',),
                                icon: Icon(Icons.verified),
                                actions: [
                                  TextButton(onPressed: (){

                                    Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) {
                                        return HomePage(signOut: () {});
                                      }),
                                    );
                                  }, child: Text('Ok'))
                                ],
                              ));
                            },
                            child: Text('Bayar'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('Tutup'),
                          ),
                        ],
                      ),
                    );
                  },
                  child: Text('Donasi - Rp.10.000', style: TextStyle(
                      color: Colors.white
                  ),),
                ),
                //
                SizedBox(height: 20,),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromRGBO(49, 39, 79, 1),
                  ),
                  onPressed: () {
                    double totalPrice = calculateTotalPrice(1);
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Pembayaran'),
                        content: Text(
                            'Total harga: ${totalPrice.toStringAsFixed(2)} $selectedCurrency'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              showDialog(context: context, builder:(context) =>
                                  AlertDialog(
                                    title: Text('Terima Kasih Telah Berdonasi'),
                                    icon: Icon(Icons.verified),
                                    actions: [
                                      TextButton(onPressed: (){

                                        Navigator.of(context).push(
                                          MaterialPageRoute(builder: (context) {
                                            return HomePage(signOut: () {});
                                          }),
                                        );
                                      }, child: Text('Ok'))
                                    ],
                                  ));
                            },
                            child: Text('Bayar'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('Tutup',),
                          ),
                        ],
                      ),
                    );
                  },
                  child: Text('Donasi - Rp.50.000', style: TextStyle(
                      color: Colors.white
                  ),),
                ),
                //
                SizedBox(height: 20,),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromRGBO(49, 39, 79, 1),
                  ),
                  onPressed: () {
                    double totalPrice = calculateTotalPrice(2);
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Pembayaran'),
                        content: Text(
                            'Total harga: ${totalPrice.toStringAsFixed(2)} $selectedCurrency'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              showDialog(context: context, builder:(context) =>
                                  AlertDialog(
                                    title: Text('Terima Kasih Telah Berdonasi'),
                                    icon: Icon(Icons.verified),
                                    actions: [
                                      TextButton(onPressed: (){

                                        Navigator.of(context).push(
                                          MaterialPageRoute(builder: (context) {
                                            return HomePage(signOut: () {});
                                          }),
                                        );
                                      }, child: Text('Ok'))
                                    ],
                                  ));
                            },
                            child: Text('Bayar', ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('Tutup'),
                          ),
                        ],
                      ),
                    );
                  },
                  child: Text('Donasi - Rp.100.000', style: TextStyle(
                      color: Colors.white
                  ),),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Pilih Mata Uang:', style: TextStyle(
                color: Colors.white,
              fontSize: 18
            ),
            ),
            DropdownButton<String>(
              dropdownColor: Color.fromRGBO(49, 39, 79, 1),
              value: selectedCurrency,
              onChanged: (String? newValue) {
                setState(() {
                  selectedCurrency = newValue!;
                });
              },
              items: exchangeRates.keys
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value,style: TextStyle(
                      color: Colors.white
                  ),),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}