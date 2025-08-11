import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SnackbarScreen extends StatelessWidget {
  static const name = 'snackbar_screen';

  const SnackbarScreen({super.key});

  void showCustomSnackbar(BuildContext context) {
    //* Limpiamos los snackbars que queden por mostrarse antes de mostrar el nuevo
    ScaffoldMessenger.of(context).clearSnackBars();
    final snackbar = SnackBar(content: const Text('Hola mundo'), action: SnackBarAction(label: 'OK!', onPressed: (){}), duration: Duration(seconds: 2),);

    ScaffoldMessenger.of(context)
        .showSnackBar(snackbar);
  }

  void openDialog(BuildContext context){
    showDialog(
      context: context,
      barrierDismissible: false, //* no permite al usuario cerrar el diálogo hasta que se escoja cualquiera de las dos acciones
      builder: (context) => AlertDialog(
        title: const Text('¿Estás seguro?'),
        content: const Text('Dolor Lorem do nostrud anim mollit sint elit consectetur nulla. Sit eu culpa excepteur culpa aute consectetur eu non labore laboris incididunt sint. Incididunt incididunt aliquip deserunt non nisi. Minim nisi excepteur occaecat consequat adipisicing deserunt. Lorem do labore qui anim tempor. Mollit irure officia qui id veniam sint.'),
        actions: [
          TextButton(onPressed: () => context.pop(), child: const Text('Cancelar')),
          FilledButton(onPressed: () => context.pop(), child: const Text('Aceptar'))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Snackbars y Diálogos'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FilledButton.tonal(
                onPressed: () {
                  showAboutDialog(context: context, children: [
                    const Text(
                        'Eiusmod fugiat do consectetur pariatur nulla exercitation consectetur et cillum officia amet. Nulla tempor adipisicing sint incididunt nostrud qui sint irure quis pariatur. Do aute cupidatat laborum reprehenderit commodo minim id id tempor sunt nulla ex.Voluptate veniam et ut Lorem quis sunt id duis.')
                  ]);
                },
                child: Text('Licencias usadas')),
            FilledButton.tonal(
                onPressed: () => openDialog(context),
                child: Text('Mostrar diálogo'))
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Mostrar Snackbar'),
        icon: const Icon(Icons.remove_red_eye_outlined),
        onPressed: () => showCustomSnackbar(context),
      ),
    );
  }
}
