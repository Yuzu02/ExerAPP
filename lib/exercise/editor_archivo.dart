import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:exerapp/utils/permissions_handler.dart';
import 'package:exerapp/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class FileEditorApp extends StatefulWidget {
  const FileEditorApp({super.key});

  @override
  FileEditorAppState createState() => FileEditorAppState();
}

class FileEditorAppState extends State<FileEditorApp> {
  final TextEditingController _textController = TextEditingController();
  late String _filePath;
  bool _isInitialized = false;
  final PermissionHandler _permissionHandler = PermissionHandler();

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    if (await _permissionHandler.requestStoragePermissions()) {
      await _initializeFile();
    }
  }

  Future<void> _saveToFile() async {
    if (!_isInitialized) {
      if (Platform.isAndroid) {
        if (!await _permissionHandler.checkStoragePermission()) {
          if (await _permissionHandler.requestStoragePermissions()) {
            await _initializeFile();
          }
          return;
        }
      }
      await _initializeFile();
    }

    try {
      File file = File(_filePath);
      await file.writeAsString(_textController.text);
      showToast("Archivo guardado exitosamente");
    } catch (e) {
      showToast("Error al guardar: ${e.toString()}");
    }
  }

  Future<void> _initializeFile() async {
    try {
      Directory? directory;
      if (Platform.isAndroid) {
        final deviceInfo = await DeviceInfoPlugin().androidInfo;

        if (deviceInfo.version.sdkInt >= 30) {
          // Para Android 11 y superior
          directory = Directory('/storage/emulated/0/Download');
          debugPrint('Usando directorio: ${directory.path}');
        } else {
          // Para Android 10 y anterior
          directory = await getExternalStorageDirectory();
          debugPrint('Usando directorio: ${directory?.path}');
        }

        if (directory != null && !await directory.exists()) {
          debugPrint('Creando directorio');
          await directory.create(recursive: true);
        }
      } else {
        directory = await getApplicationDocumentsDirectory();
      }

      if (directory == null) {
        throw Exception('No se pudo obtener el directorio');
      }

      _filePath = '${directory.path}/mi_archivo.txt';
      debugPrint('Ruta del archivo: $_filePath');

      File file = File(_filePath);

      if (await file.exists()) {
        debugPrint('Archivo existente encontrado');
        String content = await file.readAsString();
        setState(() {
          _textController.text = content;
          _isInitialized = true;
        });
        showToast("Archivo cargado exitosamente");
      } else {
        debugPrint('Creando nuevo archivo');
        await file.create(recursive: true);
        setState(() {
          _isInitialized = true;
        });
        showToast("Nuevo archivo creado");
      }
    } catch (e) {
      debugPrint('Error en _initializeFile: $e');
      showToast("Error de inicialización: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editor de Texto'),
        backgroundColor: Colors.blue,
        actions: [
          // Agregar botón para solicitar permisos manualmente
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () async {
              if (await _permissionHandler.requestStoragePermissions()) {
                await _initializeFile();
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.blue.shade200),
                ),
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: _textController,
                  maxLines: null,
                  expands: true,
                  style: const TextStyle(fontSize: 16),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Escribe aquí...',
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveToFile,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                textStyle:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('GUARDAR'),
            ),
          ],
        ),
      ),
    );
  }
}
