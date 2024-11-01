import 'dart:io';
import 'package:exerapp/utils/permissions_handler.dart';
import 'package:flutter/material.dart';
import 'package:exerapp/utils/toast.dart';

class SDFileEditorApp extends StatefulWidget {
  const SDFileEditorApp({super.key});

  @override
  SDFileEditorAppState createState() => SDFileEditorAppState();
}

class SDFileEditorAppState extends State<SDFileEditorApp> {
  final TextEditingController _fileNameController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final PermissionHandler _permissionHandler = PermissionHandler();
  bool _isInitialized = false;
  String _baseDirectory = '';

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    if (await _permissionHandler.requestStoragePermissions()) {
      _baseDirectory = '/storage/emulated/0/Download';
      setState(() => _isInitialized = true);
      showToast("Permisos concedidos");
    }
  }

  Future<void> _saveFile() async {
    if (!_isInitialized) {
      showToast("Esperando permisos...");
      return;
    }

    if (_fileNameController.text.isEmpty) {
      showToast("Por favor, ingrese un nombre de archivo");
      return;
    }

    try {
      String fileName = _fileNameController.text;
      if (!fileName.endsWith('.txt')) {
        fileName = '$fileName.txt';
      }

      String filePath = '$_baseDirectory/$fileName';
      File file = File(filePath);
      await file.writeAsString(_contentController.text);
      showToast("Archivo guardado exitosamente");
    } catch (e) {
      showToast("Error al guardar: ${e.toString()}");
    }
  }

  Future<void> _loadFile() async {
    if (!_isInitialized) {
      showToast("Esperando permisos...");
      return;
    }

    if (_fileNameController.text.isEmpty) {
      showToast("Por favor, ingrese un nombre de archivo");
      return;
    }

    try {
      String fileName = _fileNameController.text;
      if (!fileName.endsWith('.txt')) {
        fileName = '$fileName.txt';
      }

      String filePath = '$_baseDirectory/$fileName';
      File file = File(filePath);

      if (await file.exists()) {
        String content = await file.readAsString();
        if (content.isEmpty) {
          showToast("El archivo está vacío");
        } else {
          setState(() => _contentController.text = content);
          showToast("Archivo cargado exitosamente");
        }
      } else {
        showToast("El archivo no existe");
      }
    } catch (e) {
      showToast("Error al cargar: ${e.toString()}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Campo de nombre de archivo
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  child: TextField(
                    controller: _fileNameController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Nombre del archivo',
                      hintStyle: TextStyle(color: Colors.grey[600]),
                      icon: Icon(Icons.file_present,
                          color: Colors.deepPurple[400]),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Área de contenido
              Expanded(
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: TextField(
                      controller: _contentController,
                      maxLines: null,
                      expands: true,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Contenido del archivo...',
                        hintStyle: TextStyle(color: Colors.grey[600]),
                      ),
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Botones
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 45,
                      child: ElevatedButton(
                        onPressed: _loadFile,
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.deepPurple[400],
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.search, size: 20),
                            SizedBox(width: 8),
                            Text(
                              'CONSULTAR',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: SizedBox(
                      height: 45,
                      child: ElevatedButton(
                        onPressed: _saveFile,
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.deepPurple[400],
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.save, size: 20),
                            SizedBox(width: 8),
                            Text(
                              'GUARDAR',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _fileNameController.dispose();
    _contentController.dispose();
    super.dispose();
  }
}
