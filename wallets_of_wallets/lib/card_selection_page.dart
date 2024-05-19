import 'package:firstly/Cards/card.dart';
import 'package:firstly/Cards/cardManager.dart';
import 'package:firstly/add_card_page.dart';
import 'package:flutter/material.dart';

class CardSelectionPage extends StatelessWidget {
  final Function(UserCard) onCardSelected;

  const CardSelectionPage({Key? key, required this.onCardSelected});

  @override
  Widget build(BuildContext context) {
    // This is just a sample list of card names. Replace with your actual card data.
    final Color customColor = Color(0xFF0A5440);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Wallets of Wallets',
          style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
              color: customColor),
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
              SizedBox(height: 40.0),
              Center(
                child: Text(
                  'Select a Card',
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    color: customColor,
                  ),
                ),
              ),

              SizedBox(height: 20.0),
              if (CardManager.cards.isEmpty)
                Container(
                  height: MediaQuery.of(context).size.height * 0.6, // Set height to 60% of the screen height
                  child: Center(
                    child: Text(
                      'You should add a card\nwith the + button.',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: customColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              for (int index = 0; index < CardManager.cards.length; index++)
                Padding(
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
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Select a Card'),
                                    content: Text('Are you sure you want to choose ${CardManager.cards[index].cardCardName}?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                          onCardSelected(CardManager.cards[index]);
                                        },
                                        child: Text('Select'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: customColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            child: Container(
                              height: 70.0,
                              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    CardManager.cards[index].cardCardName,
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.white,
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
                ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.add, size: 30.0),
            label: 'Add Card',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.close, size: 30.0),
            label: 'Cancel',
          ),
        ],

        selectedItemColor: customColor, // Set color for selected icon
        selectedFontSize: double.parse('14.5'), // Set font size for selected label

        showUnselectedLabels: true,
        unselectedItemColor: customColor, // Set color for unselected icon
        unselectedFontSize: double.parse('14.5'), // Set font size for unselected label
        unselectedLabelStyle: TextStyle(color: customColor), // Set color for unselected label

        onTap: (index) {
          // Add navigation logic based on the index of tapped item
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddCard()), // Replace MainPage() with your main page widget
            );
          } 
          else if (index == 1) {
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
