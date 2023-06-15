import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
   
  const NavBar({super.key, required this.icon, required this.onPressed, required this.isHome});

  final IconData icon;
  final VoidCallback onPressed;
  final bool isHome;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      child: isHome ? HomeNav(iconRight: icon, onPressed: onPressed) : ScreenNav(iconRight: icon, onPressed: onPressed),
    );
  }
}

class HomeNav extends StatelessWidget {
  const HomeNav({
    super.key,
    required this.onPressed,
    required this.iconRight,
  });

  final VoidCallback onPressed;
  final IconData iconRight;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 10.0),
          child: const CircleAvatar(
            backgroundImage: AssetImage('assets/icon.png'),
          ),
        ),
        
        const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
            Padding(
              padding: EdgeInsets.symmetric(vertical: 18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  
                  Text(
                    ' Clínica ',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    'Melendres',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
          ],
        ),
        IconButton(
          onPressed: onPressed,
          icon: Icon(iconRight),
        ),
        
      ],
    );
  }
}

class ScreenNav extends StatelessWidget {
  const ScreenNav({
    super.key,
    required this.onPressed,
    required this.iconRight,
  });

  final VoidCallback onPressed;
  final IconData iconRight;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: onPressed,
          icon: Icon(iconRight),
        ),
        
        const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
            Padding(
              padding: EdgeInsets.symmetric(vertical: 18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  
                  Text(
                    ' Clínica ',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    'Melendres',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
          ],
        ),
        

        Container(
          margin: const EdgeInsets.only(left: 10.0),
          child: const CircleAvatar(
            backgroundImage: AssetImage('assets/icon.png'),
          ),
        ),
        
      ],
    );
  }
}
