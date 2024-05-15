import 'package:flutter/material.dart';

class Fav extends StatelessWidget {
  final List<String> likedItems;

  const Fav({super.key, required this.likedItems});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 100),
            const Text(
              'Mes favoris',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                height: 0.05,
                letterSpacing: -0.96,
              ),
            ),
            const SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 38),
              child: likedItems.isEmpty
                  ? const Text(
                      'Aucun favori pour le moment',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'Inter',
                      ),
                    )
                  : Column(
                      children: likedItems.map((item) => Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: ShapeDecoration(
                            color: const Color(0xFFD9D9D9),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 24,
                                  fontFamily: 'Anton',
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: -0.96,
                                ),
                              ),
                              const Row(
                                children: [],
                              ),
                            ],
                          ),
                        ),
                      )).toList(),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}