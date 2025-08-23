import 'package:flutter/material.dart';
import 'package:widgets_app/config/menu/menu_items.dart';
import 'package:go_router/go_router.dart';

class SideMenu extends StatefulWidget {

  final GlobalKey<ScaffoldState> scaffoldKey;

  const SideMenu({super.key, required this.scaffoldKey});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {

  int navDrawerIndex = 0;

  @override
  Widget build(BuildContext context) {

    final hasNotch = MediaQuery.of(context).viewPadding.top > 35;// nos permitirá saber cuánta distancia hay en la parte de arriba del móvil, para identificar notch
    
    return NavigationDrawer(
      selectedIndex: navDrawerIndex,
      onDestinationSelected: (value) {
        setState(() {
          navDrawerIndex=value;
        });

        final menuItem = appMenuItems[value];
        context.push(menuItem.link);
        //*Evitamos que cada que navegamos hacia otra pantalla al regresar, no se visualice el menu abierto
        widget.scaffoldKey.currentState?.closeDrawer();

      },
      children: [

        Padding(
          padding: EdgeInsets.fromLTRB(28, hasNotch ? 0: 20, 16, 10),
          child: Text('Main'),
        ),

        ...appMenuItems
          .sublist(0,3)
          .map((item) => NavigationDrawerDestination(
              icon: Icon(item.icon),
              label: Text(item.title)
            ),
        ),
        const Padding(padding: EdgeInsets.fromLTRB(28, 16, 28, 10),child: Divider(),),

        const Padding(
          padding: EdgeInsets.fromLTRB(28, 10, 16, 10),
          child: Text('More actions'),
        ),
        ...appMenuItems.sublist(3).map(
              (item) => NavigationDrawerDestination(
                  icon: Icon(item.icon), label: Text(item.title)),
            ),
        
        // NavigationDrawerDestination(
        //   icon: const Icon(Icons.add_shopping_cart_rounded),
        //   label: const Text('Otra pantalla'),
        // )
      ],
    );
  }
}