// lib/utils/permissions.dart
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:exerapp/utils/toast.dart';

class PermissionHandler {
  static final PermissionHandler _instance = PermissionHandler._internal();
  factory PermissionHandler() => _instance;
  PermissionHandler._internal();

  Future<bool> requestStoragePermissions() async {
    if (!Platform.isAndroid) return true;

    try {
      final deviceInfo = await DeviceInfoPlugin().androidInfo;
      debugPrint('Android SDK Version: ${deviceInfo.version.sdkInt}');

      if (deviceInfo.version.sdkInt >= 30) {
        return await _requestAndroid11Permissions();
      } else {
        return await _requestLegacyPermissions();
      }
    } catch (e) {
      debugPrint('Error al solicitar permisos: $e');
      showToast("Error al solicitar permisos: $e");
      return false;
    }
  }

  Future<bool> _requestAndroid11Permissions() async {
    debugPrint('Solicitando MANAGE_EXTERNAL_STORAGE');
    final status = await Permission.manageExternalStorage.status;
    debugPrint('Estado inicial de MANAGE_EXTERNAL_STORAGE: $status');

    if (!status.isGranted) {
      final result = await Permission.manageExternalStorage.request();
      debugPrint('Resultado de solicitud MANAGE_EXTERNAL_STORAGE: $result');

      if (!result.isGranted) {
        showToast("Se requieren permisos de almacenamiento");
        await openAppSettings();
        return false;
      }
    }
    return true;
  }

  Future<bool> _requestLegacyPermissions() async {
    debugPrint('Solicitando permisos de almacenamiento básicos');
    final status = await Permission.storage.status;
    debugPrint('Estado inicial de STORAGE: $status');

    if (!status.isGranted) {
      final result = await Permission.storage.request();
      debugPrint('Resultado de solicitud STORAGE: $result');

      if (!result.isGranted) {
        showToast("Se requieren permisos de almacenamiento");
        await openAppSettings();
        return false;
      }
    }
    return true;
  }

  Future<bool> checkStoragePermission() async {
    if (!Platform.isAndroid) return true;

    final deviceInfo = await DeviceInfoPlugin().androidInfo;
    if (deviceInfo.version.sdkInt >= 30) {
      return await Permission.manageExternalStorage.isGranted;
    } else {
      return await Permission.storage.isGranted;
    }
  }

  // Agregar método para permisos de audio
  Future<bool> requestAudioPermissions() async {
    try {
      final microphoneStatus = await Permission.microphone.status;
      debugPrint('Estado inicial del micrófono: $microphoneStatus');

      if (!microphoneStatus.isGranted) {
        final result = await Permission.microphone.request();
        debugPrint('Resultado de solicitud de micrófono: $result');

        if (!result.isGranted) {
          showToast("Se requieren permisos de micrófono para grabar audio");
          await openAppSettings();
          return false;
        }
      }

      // En iOS también necesitamos el permiso de audio
      if (Platform.isIOS) {
        final speechStatus = await Permission.speech.status;
        if (!speechStatus.isGranted) {
          final result = await Permission.speech.request();
          if (!result.isGranted) {
            showToast("Se requieren permisos de audio");
            await openAppSettings();
            return false;
          }
        }
      }

      return true;
    } catch (e) {
      debugPrint('Error al solicitar permisos de audio: $e');
      showToast("Error al solicitar permisos de audio: $e");
      return false;
    }
  }
}
