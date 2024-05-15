import 'dart:ui';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import '../widgets/like_button.dart';
import '../screens/fav.dart';

class Research extends StatefulWidget {
  final Map<String, dynamic>? data;

  const Research({super.key, required this.data});

  @override
  _ResearchState createState() => _ResearchState();
}

class _ResearchState extends State<Research> {
  String price = "N/A";
  Color isOpen = Colors.black;

  @override
  void initState() {
    super.initState();
    if (widget.data != null) {
      setState(() {
        price = getPriceLevel(widget.data);
        isOpen = getIsOpen(widget.data);
      });
    }
  }

  

  String getPriceLevel(Map<String, dynamic>? data) {
    String price;
    if (data?["priceLevel"] != null) {
      switch (data?["priceLevel"]) {
        case "PRICE_LEVEL_INEXPENSIVE":
          price = "€";
          break;
        case "PRICE_LEVEL_MODERATE":
          price = "€€";
          break;
        case "PRICE_LEVEL_EXPENSIVE":
          price = "€€€";
          break;
        default:
          price = "N/A";
      }
    } else {
      price = "N/A";
    }
    return price;
  }
Color getIsOpen(Map<String, dynamic>? data) {
  String couleur;

  if (data?["isOpenNow"] != null) {
    switch (data?["isOpenNow"].toString()) {
      case "true":
        couleur = "vert";
        break;
      case "false":
        couleur = "rouge";
        break;
      default:
        couleur = "";
    }
  } else {
    couleur = "";
  }
  return couleur == 'vert' ? Colors.green : Colors.red;
}

void _launchCaller(String number) async {
    final Uri launchUri = Uri(
      // scheme: 'tel',
      // application telephone indisponible sur emulateur IOS
      scheme: 'sms',
      path: number,
    );
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      throw 'erreur';
    }
  }

  List<String> likedItems = [];

  void _handleLikeToggle(bool isLiked) {
    setState(() {
      if (isLiked) {
        likedItems.add('${widget.data?["displayName"]}'); // Add the item to the list
      } else {
        likedItems.remove('${widget.data?["displayName"]}'); // Remove the item from the list
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Container(
              height: 420,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage("https://via.placeholder.com/602x421"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            const SizedBox(height: 36),
            Container(
              padding: const EdgeInsets.only(
                left: 38,
                right: 38,
              ), // Ajoutez l'espace souhaité à gauche
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/img/pin.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  const SizedBox(width: 4.0), // Ajoutez un espacement entre l'image et le texte
                  Text(
                    '${widget.data?["formattedAddress"]}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      height: 0.09,
                      letterSpacing: -0.52,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.only(
                left: 38,
                right: 38,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${widget.data?["displayName"]}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 36,
                      fontFamily: 'Anton',
                      fontWeight: FontWeight.w400,
                      height: 0.04,
                      letterSpacing: -1.44,
                    ),
                  ),
                   LikeButton(
                    onToggle: (isLiked) {
                      _handleLikeToggle(isLiked);
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 36),
            Container(
              padding: const EdgeInsets.only(
                left: 38,
                right: 38,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const Text(
                        'Note',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w300,
                          height: 0.10,
                          letterSpacing: -0.48,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 5),
                        decoration: ShapeDecoration(
                          color: const Color(0xFFEAEAEA),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                        ),
                        child: Text('${widget.data?["rating"]}/5'),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const Text(
                        'Statut',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w300,
                          height: 0.10,
                          letterSpacing: -0.48,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 5),
                        decoration: ShapeDecoration(
                          color: const Color(0xFFEAEAEA),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                        ),
                        child: Text(
                          isOpen == Colors.green ? 'Ouvert' : 'Fermé',
                          style: TextStyle(
                            color: isOpen,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const Text(
                        'Prix',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w300,
                          height: 0.10,
                          letterSpacing: -0.48,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 5),
                        decoration: ShapeDecoration(
                          color: const Color(0xFFEAEAEA),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                        ),
                        child: Text(price),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            Container(
                padding: const EdgeInsets.only(
                left: 38,
                right: 38,
              ), 
              child:
                ElevatedButton.icon(
                style:ElevatedButton.styleFrom(
                minimumSize: const Size(400, 60),
                backgroundColor:Colors.black,
              ),
              onPressed: () {
                _launchCaller('0617400650');
              },
              label:
                const Text(
                  'Appeler',
                  style:TextStyle(
                    color:Colors.white,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                  )
                ),
              icon:
                const Icon(
                  Icons.call,
                  color: Colors.white,
                )
              ),
              ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.only(
                left: 38,
                right: 38,
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(400, 60),
                  backgroundColor: const Color.fromARGB(255, 3, 2, 2),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Fav(likedItems: likedItems),
                    ),
                  );
                },
                child: const Text(
                  'Voir mes favoris',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
