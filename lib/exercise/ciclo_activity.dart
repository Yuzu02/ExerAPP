import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LifeCycleExample extends StatefulWidget {
  const LifeCycleExample({super.key});

  @override
  LifeCycleExampleState createState() => LifeCycleExampleState();
}

class LifeCycleExampleState extends State<LifeCycleExample> {
  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  }

  @override
  void initState() {
    super.initState();
    showToast("initState: Widget Inicializado");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    showToast("didChangeDependencies: Dependencias Cambiadas");
  }

  @override
  void didUpdateWidget(covariant LifeCycleExample oldWidget) {
    super.didUpdateWidget(oldWidget);
    showToast("didUpdateWidget: Widget Actualizado");
  }

  @override
  void dispose() {
    showToast("dispose: Widget Destruido");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ciclo de Vida en Flutter")),
      body: const Center(child: Text("Observa los estados en los toasts")),
    );
  }
}
