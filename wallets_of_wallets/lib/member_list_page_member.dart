import 'package:firstly/data_base_manager.dart';
import 'package:firstly/transaction_page_member.dart';
import 'package:firstly/wallet_page_member.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firstly/Wallets/wallet.dart';
import 'package:firstly/main_page.dart';

class MemberListPageMember extends StatefulWidget {
  @override
  _MemberListPageMemberState createState() => _MemberListPageMemberState();
}

class _MemberListPageMemberState extends State<MemberListPageMember> {
  final Color customColor = const Color(0xFF0A5440);
  List<List<Object>> listOfUsers = [];
  late Wallet wallet;

  @override
  void initState() {
    super.initState();
    wallet = WalletsTableManager.selectedWallet!;
    fetchMembersAndAdmins();
  }

  Future<String> getUserName(String userMail) async {
    try {
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userMail)
          .get();
      String name = userSnapshot['name'];
      String surname = userSnapshot['surname'];
      return '$name $surname';
    } catch (e) {
      print("Error getting user name: $e");
      return '';
    }
  }

  Future<void> fetchMembersAndAdmins() async {
    try {
      DocumentSnapshot walletSnapshot = await FirebaseFirestore.instance
          .collection('wallets')
          .doc(wallet.walletId)
          .get();
      List<String> adminList = List<String>.from(walletSnapshot['list_of_admins']);
      List<String> memberList = List<String>.from(walletSnapshot['list_of_members']);

      setState(() {
        listOfUsers = [];
        adminList.forEach((admin) {
          listOfUsers.add([admin, 'Admin']);
        });
        memberList.forEach((member) {
          listOfUsers.add([member, 'Member']);
        });
      });
    } catch (e) {
      print("Error fetching members and admins: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Wallets of Wallets',
          style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            color: customColor,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 30.0),
              Padding(
                padding: const EdgeInsets.only(left: 40.0, right: 40.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          wallet.walletName,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                            color: customColor,
                          ),
                        ),
                        Text(
                          wallet.walletDescription,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                            color: customColor,
                          ),
                        ),
                        Text(
                          'Payment: ₺${wallet.walletPaymentAmount}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                            color: customColor,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'ID: ${wallet.walletId}',
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: customColor,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15.0),
              for (int user = 0; user < listOfUsers.length; user++)
                FutureBuilder<String>(
                  future: getUserName(listOfUsers[user][0] as String),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text("Error: ${snapshot.error}");
                    } else {
                      return Padding(
                        padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: ElevatedButton(
                                  onPressed: () {
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: listOfUsers[user][1] == 'Admin'
                                        ? Color.fromARGB(255, 162, 68, 229)
                                        : Color.fromARGB(255, 35, 147, 157),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                  child: Container(
                                    height: 70.0,
                                    padding: const EdgeInsets.only(
                                      left: 10.0,
                                      right: 10.0,
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          snapshot.data ?? "",
                                          style: TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.normal,
                                            color: Color.fromARGB(255, 6, 7, 6),
                                          ),
                                        ),
                                        Text(
                                          listOfUsers[user][1] as String,
                                          style: TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.normal,
                                            color: Color.fromARGB(255, 6, 6, 6),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 30.0),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.paid, size: 30.0),
            label: 'Payment',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.wallet, size: 30.0),
            label: 'Wallet',
          )
        ],
        selectedItemColor: customColor,
        selectedFontSize: 14.5,
        showUnselectedLabels: true,
        unselectedItemColor: customColor,
        unselectedFontSize: 14.5,
        unselectedLabelStyle: TextStyle(color: customColor),
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MainPage()),
              );
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TransactionPageMember()),
              );
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WalletPageMember()),
              );
              break;
          }
        },
      ),
    );
  }
}
