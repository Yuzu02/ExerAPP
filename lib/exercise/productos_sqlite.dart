import 'package:exerapp/helpers/database_helper.dart';
import 'package:exerapp/models/exercise/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:exerapp/utils/toast.dart';

class ProductManagerApp extends StatefulWidget {
  const ProductManagerApp({super.key});

  @override
  State<ProductManagerApp> createState() => _ProductManagerAppState();
}

class _ProductManagerAppState extends State<ProductManagerApp> {
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final DatabaseHelper _dbHelper = DatabaseHelper();
  Product? _selectedProduct;

  void _clearFields() {
    _codeController.clear();
    _descriptionController.clear();
    _priceController.clear();
    setState(() => _selectedProduct = null);
  }

  Future<void> _createProduct() async {
    if (!_validateFields()) return;

    try {
      final db = await _dbHelper.database;
      final product = Product(
        code: _codeController.text,
        description: _descriptionController.text,
        price: double.parse(_priceController.text),
      );

      await db.insert('products', product.toMap());
      showToast('Producto creado exitosamente');
      _clearFields();
    } catch (e) {
      showToast('Error al crear el producto: $e');
    }
  }

  Future<void> _readProduct() async {
    if (_codeController.text.isEmpty) {
      showToast('Ingrese un código de producto');
      return;
    }

    try {
      final db = await _dbHelper.database;
      final List<Map<String, dynamic>> maps = await db.query(
        'products',
        where: 'code = ?',
        whereArgs: [_codeController.text],
      );

      if (maps.isNotEmpty) {
        setState(() {
          _selectedProduct = Product.fromMap(maps.first);
          _descriptionController.text = _selectedProduct!.description;
          _priceController.text = _selectedProduct!.price.toString();
        });
        showToast('Producto encontrado');
      } else {
        showToast('Producto no encontrado');
      }
    } catch (e) {
      showToast('Error al buscar el producto: $e');
    }
  }

  Future<void> _updateProduct() async {
    if (!_validateFields() || _selectedProduct == null) {
      showToast('Primero busque un producto');
      return;
    }

    try {
      final db = await _dbHelper.database;
      final product = Product(
        id: _selectedProduct!.id,
        code: _codeController.text,
        description: _descriptionController.text,
        price: double.parse(_priceController.text),
      );

      await db.update(
        'products',
        product.toMap(),
        where: 'id = ?',
        whereArgs: [product.id],
      );
      showToast('Producto actualizado exitosamente');
      _clearFields();
    } catch (e) {
      showToast('Error al actualizar el producto: $e');
    }
  }

  Future<void> _deleteProduct() async {
    if (_selectedProduct == null) {
      showToast('Primero busque un producto');
      return;
    }

    try {
      final db = await _dbHelper.database;
      await db.delete(
        'products',
        where: 'id = ?',
        whereArgs: [_selectedProduct!.id],
      );
      showToast('Producto eliminado exitosamente');
      _clearFields();
    } catch (e) {
      showToast('Error al eliminar el producto: $e');
    }
  }

  bool _validateFields() {
    if (_codeController.text.isEmpty ||
        _descriptionController.text.isEmpty ||
        _priceController.text.isEmpty) {
      showToast('Todos los campos son requeridos');
      return false;
    }
    if (double.tryParse(_priceController.text) == null) {
      showToast('El precio debe ser un número válido');
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Gestión de Productos',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.purple[400],
          elevation: 0,
        ),
        backgroundColor: Colors.grey[100],
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Tarjeta de entrada de datos
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.white,
                          Colors.purple.withOpacity(0.1),
                        ],
                      ),
                    ),
                    child: Column(
                      children: [
                        _buildInputField(
                          controller: _codeController,
                          label: 'Código del Producto',
                          icon: Icons.qr_code,
                          hint: 'Ingrese el código',
                        ),
                        const SizedBox(height: 16),
                        _buildInputField(
                          controller: _descriptionController,
                          label: 'Descripción',
                          icon: Icons.description,
                          hint: 'Ingrese la descripción',
                          maxLines: 2,
                        ),
                        const SizedBox(height: 16),
                        _buildInputField(
                          controller: _priceController,
                          label: 'Precio',
                          icon: Icons.attach_money,
                          hint: 'Ingrese el precio',
                          keyboardType:
                              TextInputType.numberWithOptions(decimal: true),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^\d*\.?\d{0,2}')),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Botones CRUD con diseño mejorado
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 2.5,
                  children: [
                    _buildAnimatedButton(
                      label: 'CREAR',
                      icon: Icons.add_circle_outline,
                      color: Colors.green[400]!,
                      onPressed: _createProduct,
                    ),
                    _buildAnimatedButton(
                      label: 'BUSCAR',
                      icon: Icons.search,
                      color: Colors.blue[400]!,
                      onPressed: _readProduct,
                    ),
                    _buildAnimatedButton(
                      label: 'ACTUALIZAR',
                      icon: Icons.update,
                      color: Colors.orange[400]!,
                      onPressed: _updateProduct,
                    ),
                    _buildAnimatedButton(
                      label: 'ELIMINAR',
                      icon: Icons.delete_outline,
                      color: Colors.red[400]!,
                      onPressed: _deleteProduct,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required String hint,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
    int maxLines = 1,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.purple.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          labelStyle: TextStyle(color: Colors.purple[700]),
          prefixIcon: Icon(icon, color: Colors.purple[400]),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.purple[200]!),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.purple[200]!),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.purple[400]!, width: 2),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }

  Widget _buildAnimatedButton({
    required String label,
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  color,
                  color.withOpacity(0.8),
                ],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: Colors.white, size: 20),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _codeController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    super.dispose();
  }
}
