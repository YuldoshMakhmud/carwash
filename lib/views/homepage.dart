import 'package:carwash/models/app_state.dart';
import 'package:carwash/views/service_page/service_list.dart';
import 'package:carwash/views/service_page/pricing_table.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _editMode = false;
  final AppState _appState = AppState();

  void _toggleEditMode() => setState(() => _editMode = !_editMode);

  void _editCategory(int index) {
    final cat = _appState.categories[index];
    final nameCtrl = TextEditingController(text: cat.name);
    final imageCtrl = TextEditingController(text: cat.imageUrl);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _CategoryEditSheet(
        nameCtrl: nameCtrl,
        imageCtrl: imageCtrl,
        onSave: () {
          _appState.updateCategory(
            index,
            ServiceCategoryData(
              name: nameCtrl.text.trim(),
              icon: cat.icon,
              imageUrl: imageCtrl.text.trim(),
              services: cat.services,
            ),
          );
          setState(() {});
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Car Wash Services'),
        centerTitle: true,
        actions: [
          TextButton.icon(
            onPressed: _toggleEditMode,
            icon: Icon(
              _editMode ? Icons.check_circle : Icons.edit,
              color: _editMode ? Colors.green : Colors.red,
              size: 18,
            ),
            label: Text(
              _editMode ? 'Tayyor' : 'Edit',
              style: TextStyle(
                color: _editMode ? Colors.green : Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Choose a Category',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Browse our professional car care services',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            if (_editMode)
              Container(
                margin: const EdgeInsets.only(top: 12),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.orange.shade200),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, color: Colors.orange.shade700, size: 16),
                    const SizedBox(width: 8),
                    Text(
                      'Kartani bosib kategoriyani tahrirlang',
                      style: TextStyle(color: Colors.orange.shade800, fontSize: 12),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.85,
                ),
                itemCount: _appState.categories.length,
                itemBuilder: (context, index) {
                  return _buildCategoryCard(context, _appState.categories[index], index);
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const PricingTablePage()),
          );
        },
        backgroundColor: Colors.red,
        icon: const Icon(Icons.workspace_premium, color: Colors.white),
        label: const Text(
          '정기권 요금표',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildCategoryCard(BuildContext context, ServiceCategoryData category, int index) {
    return GestureDetector(
      onTap: () {
        if (_editMode) {
          _editCategory(index);
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ServiceListPage(categoryIndex: index),
            ),
          ).then((_) => setState(() {}));
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _editMode ? Colors.red.withOpacity(0.4) : Colors.grey.shade200,
            width: _editMode ? 1.5 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 3,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      category.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.red.withOpacity(0.1),
                          child: Icon(category.icon, size: 50, color: Colors.red),
                        );
                      },
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          color: Colors.grey.shade200,
                          child: const Center(
                            child: CircularProgressIndicator(color: Colors.red, strokeWidth: 2),
                          ),
                        );
                      },
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.3),
                          ],
                        ),
                      ),
                    ),
                    if (_editMode)
                      Container(
                        color: Colors.black.withOpacity(0.25),
                        child: const Center(
                          child: Icon(Icons.edit, color: Colors.white, size: 28),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      category.name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${category.services.length}개 서비스',
                      style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ======== Category Edit Sheet ========
class _CategoryEditSheet extends StatefulWidget {
  final TextEditingController nameCtrl;
  final TextEditingController imageCtrl;
  final VoidCallback onSave;

  const _CategoryEditSheet({
    required this.nameCtrl,
    required this.imageCtrl,
    required this.onSave,
  });

  @override
  State<_CategoryEditSheet> createState() => _CategoryEditSheetState();
}

class _CategoryEditSheetState extends State<_CategoryEditSheet> {
  String _previewUrl = '';

  @override
  void initState() {
    super.initState();
    _previewUrl = widget.imageCtrl.text;
    widget.imageCtrl.addListener(() {
      setState(() => _previewUrl = widget.imageCtrl.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const Text(
                  'Kategoriyani tahrirlash',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 16),

            if (_previewUrl.isNotEmpty)
              Container(
                height: 150,
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    _previewUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      color: Colors.grey.shade100,
                      child: const Icon(Icons.broken_image, color: Colors.grey, size: 50),
                    ),
                  ),
                ),
              ),

            const Text('Kategoriya nomi', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.black87)),
            const SizedBox(height: 6),
            TextField(
              controller: widget.nameCtrl,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.category_outlined, color: Colors.grey.shade400, size: 20),
                filled: true,
                fillColor: Colors.grey.shade50,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade200),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade200),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.red, width: 2),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              ),
            ),
            const SizedBox(height: 12),

            const Text('Rasm URL', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.black87)),
            const SizedBox(height: 6),
            TextField(
              controller: widget.imageCtrl,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.image_outlined, color: Colors.grey.shade400, size: 20),
                filled: true,
                fillColor: Colors.grey.shade50,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade200),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade200),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.red, width: 2),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              ),
            ),
            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: widget.onSave,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  elevation: 0,
                ),
                child: const Text('Saqlash', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
