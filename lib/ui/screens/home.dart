import 'package:flutter/material.dart';
import '../widgets/carousel.dart';
import '../screens/research.dart';
import '../screens/fav.dart';
import '../../services/google_api.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
  const Home({super.key});
}


class _HomeState extends State<Home> {
 int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
  String textOnTop = _currentIndex == 0 ? 'Un petit\n' : 'On va boire\n';
  String textBottom = _currentIndex == 1 ? 'un coup ?' : 'creux ?';
  Map<String, dynamic>? nearbyPlacesData;


    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Carousel(
            onIndexChanged: (index) {
              setState(() {
                _currentIndex = index; // Met à jour l'état avec la nouvelle valeur
              });
            },
            ),
            const SizedBox(height: 20),
            const Text(
              'sélectionnez votre recherche',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFFB0B0B0),
                fontSize: 10,
                fontFamily: 'Ageo Trial',
                fontWeight: FontWeight.w600,
                height: 0,
              ),
            ),
            const SizedBox(height: 46),
             Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: textOnTop,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 32,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  ),
                  TextSpan(
                    text: textBottom,
                    style: const TextStyle(
                      color: Color(0xFFA8A8A8),
                      fontSize: 32,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  ),
                ],
              ),
                textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              style:ElevatedButton.styleFrom(
                minimumSize: Size(308, 60),
                backgroundColor:const Color(0xFFFF2323),
              ),
              onPressed: () async {

                // Appel de la fonction fetchNearbyPlaces()
                Map<String, dynamic> result = await fetchNearbyPlaces();
                // Mettre à jour l'état avec le résultat retourné
                setState(() {
                  nearbyPlacesData = result;
                });
                Navigator.push(context,MaterialPageRoute(builder: (context)=>Research(data: nearbyPlacesData)));

              },
              child: const Text(
                'Commencer',
                style:TextStyle(
                  color:Colors.white,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                )
              ),
            ),
            const SizedBox(height: 7),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>const Fav(likedItems: []),
                  ),
                );
              },
              child: const Text(
                'voir mes favoris',
                style: TextStyle(
                  color: Color(0xFFB0B0B0),
                  fontSize: 10,
                  fontFamily: 'Ageo Trial',
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.underline,
                  decorationThickness: 0.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

