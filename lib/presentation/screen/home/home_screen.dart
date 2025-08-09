import 'package:flutter/material.dart';
import 'package:widgets_app/config/menu/menu_items.dart';
import 'package:go_router/go_router.dart';
import 'package:widgets_app/presentation/screen/buttons/buttons_screen.dart';
import 'package:widgets_app/presentation/screen/cards/cards_screen.dart';



class HomeScreen extends StatelessWidget {

  static const String name = 'home_screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter + Material 3'),
      ),
      body: const _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {

    

    return ListView.builder(
      itemCount: appMenuItems.length,
      itemBuilder: (context, index){
        final menuItem = appMenuItems[index];
        return _CustomListTile(menuItem: menuItem);
      }
    );
  }
}

class _CustomListTile extends StatelessWidget {
  const _CustomListTile({
    required this.menuItem,
  });

  final MenuItem menuItem;

  @override
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme;

    return ListTile(
      leading: Icon(menuItem.icon, color: colors.primary),
      trailing: Icon(Icons.arrow_forward_ios_rounded, color: colors.primary,),
      title: Text(menuItem.title),  
      subtitle: Text(menuItem.subTitle),
      onTap: (){
          //* Primer forma - flutter
          // Navigator.of(context).push(
          //   MaterialPageRoute(builder: (context) => const ButtonsScreen()),
          // );
          //* Segunda forma - flutter
          // Navigator.pushNamed(context, menuItem.link);
          //* 3era forma - goRouter
          context.push(menuItem.link);
          //* 4ta forma - goRouter pero para rutas con nombre
          // context.pushNamed(CardsScreen.name);
      },
    );
  }
}