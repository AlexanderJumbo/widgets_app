import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SlideInfo {
  final String title;
  final String caption;
  final String imageUrl;

  SlideInfo(this.title, this.caption, this.imageUrl);
  
}

final slides = <SlideInfo>[
  SlideInfo('Busca la comida', 'Consequat Lorem commodo adipisicing magna.', 'assets/images/1.png'),
  SlideInfo('Entrega rápida', 'Officia duis reprehenderit reprehenderit sunt nostrud ut esse.', 'assets/images/2.png'),
  SlideInfo('Disfruta la comida', 'Labore id quis sint mollit dolore sunt sunt.', 'assets/images/3.png'),
];



class AppTutorialScreen extends StatefulWidget {
  static const name = 'tutorial_screen';

  const AppTutorialScreen({super.key});

  @override
  State<AppTutorialScreen> createState() => _AppTutorialScreenState();
}

class _AppTutorialScreenState extends State<AppTutorialScreen> {

  final PageController pageViewController = PageController();
  bool endReached = false;

  //*Agregar un listener al pageViewController, para determinar cuando llegamos al último slide
  @override
  void initState() {
    super.initState();

    pageViewController.addListener((){
      final page = pageViewController.page ?? 0;
      if(!endReached && page >= (slides.length - 1.5)){
        setState(() {
          endReached = true;
        });
      }
    });
  }

  //* Despúes de llamar a algún listener o controlador, es buena práctica llamar al dispose
  @override
  void dispose() {
    pageViewController.dispose();
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          PageView(
            controller: pageViewController,
            physics: const BouncingScrollPhysics(),
            children: slides.map((slideData) => _Slide(
              title: slideData.title, 
              caption: slideData.caption, 
              imageUrl: slideData.imageUrl
            )).toList()
          ),

          Positioned(right: 20, top: 50, child: TextButton(onPressed: () => context.pop(), child: const Text('Salir'))),
          endReached 
            ?Positioned(right: 30, bottom: 30, child: FadeInRight(from: 15, delay: const Duration(seconds: 1), child: FilledButton(onPressed: () => context.pop(), child: const Text('Comenzar '))))
            : const SizedBox(),

        ],
      ),
    );
  }
}

class _Slide extends StatelessWidget {

  final String title;
  final String caption;
  final String imageUrl;

  const _Slide({
    required this.title, 
    required this.caption, 
    required this.imageUrl
  });


  @override
  Widget build(BuildContext context) {

    final titleStyle = Theme.of(context).textTheme.titleLarge;
    final captioneStyle = Theme.of(context).textTheme.bodySmall;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,//* El mainAxisAlignment es vertical en una columna
          crossAxisAlignment: CrossAxisAlignment.start, //* El crossAxisAlignment es horizontal en una columna
          children: [
            Image(image: AssetImage(imageUrl)),
            const SizedBox(height: 20,),
            Text(title, style: titleStyle,),
            const SizedBox(height: 10,),
            Text(caption, style: captioneStyle)
          ],
        ),
      ), 
    );
  }
}