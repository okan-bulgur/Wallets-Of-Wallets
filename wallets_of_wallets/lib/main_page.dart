// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, library_private_types_in_public_api
import 'package:firstly/Wallets/wallet.dart';
import 'package:firstly/data_base_manager.dart';
import 'package:firstly/create_wallet_page.dart';
import 'package:firstly/wallet_page_admin.dart';
import 'package:firstly/wallet_page_member.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'profile_page.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  CarouselController buttonCarouselController = CarouselController();
  final Color customColor = Color(0xFF0A5440);
  int currentIndex = 0;
  Wallet? currentWallet; // Mevcut cüzdanı tutmak için değişken (nullable)
  bool initialLoad = true; // İlk yükleme kontrolü için flag

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Wallets of Wallets',
          style: TextStyle(
              fontSize: 30.0, fontWeight: FontWeight.bold, color: customColor),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(
              Icons.person,
              color: customColor, // Replace with your desired color
              size: 40, // Replace with your desired size
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfilePage(),
                ),
              );
            },
          ),
        ],
      ),
      body: StreamBuilder<List<Wallet>>(
        stream: initialLoad
          ? WalletsTableManager.getWalletsOfUserStream()
          : null, // İlk yüklemede akışı kullan, sonrasında null
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text(''));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No wallets found.'));
          } else {
            List<Wallet> list_of_wallets = snapshot.data!;
            if (initialLoad) {
              // İlk yüklemede currentIndex'i güncelle
              currentWallet = list_of_wallets[currentIndex];
              initialLoad = false; // İlk yükleme tamamlandı
            }
            // Eğer currentIndex geçersizse sıfırla
            if (currentIndex >= list_of_wallets.length) {
              currentIndex = 0;
              currentWallet = list_of_wallets.isNotEmpty ? list_of_wallets[currentIndex] : null;
            } else {
              currentWallet = list_of_wallets[currentIndex];
            }
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CarouselSlider(
                    items: [
                      for (int wallet = 0; wallet < list_of_wallets.length; wallet++)
                        GestureDetector(
                          onLongPress: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text("Leave Wallet"),
                                  content: Text("Are you sure you want to leave this wallet?"),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text("No"),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        await WalletsTableManager.disjoinWallet(context, list_of_wallets[wallet].walletId);
                                        setState(() {
                                          // Cüzdan silindikten sonra currentIndex'i güncelle
                                          currentIndex = 0;
                                          initialLoad = true; // Yeniden yükleme yapılacak
                                        });
                                        Navigator.of(context).pop();
                                      },
                                      child: Text("Yes"),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          onTap: () async {
                            WalletsTableManager.selectedWallet = list_of_wallets[wallet];
                            if (await WalletsTableManager.isUserAdminOfWallet(WalletsTableManager.selectedWallet!.walletId)) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => WalletPageAdmin(),
                                ),
                              );
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => WalletPageMember(),
                                ),
                              );
                            }
                          },
                          child: Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                              color: list_of_wallets[wallet].walletColor as Color?,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Text(
                              list_of_wallets[wallet].walletName,
                              style: TextStyle(
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                    ],
                    carouselController: buttonCarouselController,
                    options: CarouselOptions(
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      reverse: false,
                      enlargeCenterPage: true,
                      onPageChanged: (index, reason) {
                        setState(() {
                          currentIndex = index;
                          currentWallet = list_of_wallets[currentIndex]; // Mevcut cüzdanı güncelle
                        });
                      },
                      scrollDirection: Axis.horizontal,
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 50.0, right: 50.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${currentWallet?.walletName ?? ""}', // Mevcut cüzdanı kullan
                          style: TextStyle(
                            color: customColor,
                          ),
                        ),
                        SizedBox(width: 5.0),
                        Padding(
                          padding: const EdgeInsets.only(left: 50.0, right: 50.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              for (int wallet = 0; wallet < list_of_wallets.length; wallet++)
                                Container(
                                  width: 12.0,
                                  height: 12.0,
                                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: currentIndex == wallet
                                        ? customColor
                                        : Color.fromARGB(255, 255, 255, 255).withOpacity(0.5),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: Offset(0, 3),
                                      )
                                    ],
                                  ),
                                )
                            ],
                          ),
                        ),
                        Text(
                          'ID: ${currentWallet?.walletId ?? ""}', // Mevcut cüzdanı kullan
                          style: TextStyle(
                            color: customColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: FloatingActionButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("Help"),
                      content: Text("* To see your profile/balance click on the button top right.\n* To create/join wallet click on the button bottom right.\n* To view wallet click on the wallet square center of the screen.\n* Press and hold the wallet to leave the wallet."),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text("Close"),
                        ),
                      ],
                    );
                  },
                );
              },
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              child: Icon(
                Icons.help,
                size: 40, // Adjust size of the icon
                color: customColor,
              ),
            ),
          ),
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreateWalletScreen()),
              );
            },
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            child: Icon(
              Icons.add,
              size: 50, // Adjust size of the icon
              color: customColor,
            ),
          ),
        ],
      ),
    );
  }
}
