import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class InfiniteScrollScreen extends StatefulWidget {
  static const name = 'infinite_screen';

  const InfiniteScrollScreen({super.key});

  @override
  State<InfiniteScrollScreen> createState() => _InfiniteScrollScreenState();
}

class _InfiniteScrollScreenState extends State<InfiniteScrollScreen> {

  List<int> imagesIds = [1,2,3,4,5];
  final ScrollController scrollController = ScrollController();
  bool isLoading = false;
  bool isMounted = true;

  @override
  void initState() {
    super.initState();
    scrollController.addListener((){
      // scrollController.position.pixels //* posición actual
      // scrollController.position.maxScrollExtent //* posición max a la que se puede extender, es decir, el final de la pantalla
      if((scrollController.position.pixels + 500) >= scrollController.position.maxScrollExtent) {
        //load next page
        loadNextPage();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    isMounted = false;//* en el dispose se evalúa el componente que ya no existe o va a ser destruido
    super.dispose();
  }

  Future loadNextPage() async {
    if(isLoading) return;
    isLoading = true;
    setState(() {});
    await Future.delayed(const Duration(seconds: 2));
    addFiveImages();
    isLoading = false;
    //*Si no está montado el widget/componente entonces evitamos actualizar con las nuevas imágenes para evitar que la app se rompa
    if( !isMounted ) return;
    setState(() {});

    //* Efecto de movimiento de scroll, para dar a enteder al usuario que todavía hay imágenes que cargar
    moveScrollToBottom();
  }

  Future<void> onRefresh() async {
    isLoading = true;
    setState(() {});
    await Future.delayed(const Duration(seconds: 3 ));
    
    if(!isMounted) return; //*si el componente no está montado, no hacemos nada 

    isLoading = false;
    final lastId = imagesIds.last;
    imagesIds.clear();
    imagesIds.add(lastId + 1);
    addFiveImages();
    setState(() {});
  }

  void moveScrollToBottom(){
    //* si el usuario no ha llegado hasta el final de la pantalla, entonces no hacer el efecto de movimiento de scroll
    if(scrollController.position.pixels + 150 <= scrollController.position.maxScrollExtent)return;

    scrollController.animateTo(
      scrollController.position.pixels + 120, 
      duration: const Duration(microseconds: 300), 
      curve: Curves.fastOutSlowIn
    );

  }

  void addFiveImages(){
    final lastId = imagesIds.last;
    imagesIds.addAll(
      [1,2,3,4,5].map((e) => lastId + e)
    );
  } 


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: MediaQuery.removePadding(//* para que el contenido de la app tape tanto la parte de la barra notificaciones como los botones de abajo
        context: context,
        removeTop: true,
        removeBottom: true,
        child: RefreshIndicator(
          onRefresh: onRefresh,
          edgeOffset: 10,
          strokeWidth: 2,
          child: ListView.builder(
            controller: scrollController,
            itemCount: imagesIds.length,
            itemBuilder: (context, index) {
              return FadeInImage(
                fit: BoxFit.cover,
                width: double.infinity,
                height: 300,
                placeholder: const AssetImage('assets/images/jar-loading.gif'), 
                image: NetworkImage('https://picsum.photos/id/${ imagesIds[index] }/500/300')
              );
            },
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () => context.pop(),
        // child: CircularProgressIndicator(),
        child: isLoading ? 
        SpinPerfect(
          infinite: true,
          child: const Icon(Icons.refresh_rounded)
        )
        : FadeIn(child: const Icon(Icons.arrow_back_ios_new_outlined)),
      ),
    );
  }
}
