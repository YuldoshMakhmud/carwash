import 'package:carwash/models/app_state.dart';
import 'package:carwash/views/widgets/service_list_detail.dart';
import 'package:flutter/material.dart';

class ServiceListPage extends StatefulWidget {
  final int categoryIndex;

  const ServiceListPage({Key? key, required this.categoryIndex}) : super(key: key);

  @override
  State<ServiceListPage> createState() => _ServiceListPageState();
}

class _ServiceListPageState extends State<ServiceListPage> {
  bool _editMode = false;

  void _toggleEditMode() => setState(() => _editMode = !_editMode);

  void _editService(int svcIndex) {
    final appState = AppState();
    final service = appState.categories[widget.categoryIndex].services[svcIndex];
    final nameCtrl = TextEditingController(text: service.name);
    final priceCtrl = TextEditingController(text: service.price);
    final descCtrl = TextEditingController(text: service.description);
    final imageCtrl = TextEditingController(text: service.imageUrl);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _EditServiceSheet(
        nameCtrl: nameCtrl,
        priceCtrl: priceCtrl,
        descCtrl: descCtrl,
        imageCtrl: imageCtrl,
        onSave: () {
          appState.updateService(
            widget.categoryIndex,
            svcIndex,
            ServiceItem(
              name: nameCtrl.text.trim(),
              price: priceCtrl.text.trim(),
              description: descCtrl.text.trim(),
              imageUrl: imageCtrl.text.trim(),
            ),
          );
          setState(() {});
          Navigator.pop(context);
        },
      ),
    );
  }

  void _addService() {
    final appState = AppState();
    final nameCtrl = TextEditingController();
    final priceCtrl = TextEditingController();
    final descCtrl = TextEditingController();
    final imageCtrl = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _EditServiceSheet(
        nameCtrl: nameCtrl,
        priceCtrl: priceCtrl,
        descCtrl: descCtrl,
        imageCtrl: imageCtrl,
        isNew: true,
        onSave: () {
          if (nameCtrl.text.trim().isEmpty) return;
          appState.addService(
            widget.categoryIndex,
            ServiceItem(
              name: nameCtrl.text.trim(),
              price: priceCtrl.text.trim(),
              description: descCtrl.text.trim(),
              imageUrl: imageCtrl.text.trim().isEmpty
                  ? 'https://images.unsplash.com/photo-1601362840469-51e4d8d58785?w=400&h=300&fit=crop'
                  : imageCtrl.text.trim(),
            ),
          );
          setState(() {});
          Navigator.pop(context);
        },
      ),
    );
  }

  void _deleteService(int svcIndex) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Xizmatni o\'chirish'),
        content: const Text('Bu xizmatni o\'chirmoqchimisiz?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Bekor')),
          ElevatedButton(
            onPressed: () {
              AppState().removeService(widget.categoryIndex, svcIndex);
              setState(() {});
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            child: const Text('O\'chirish'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final appState = AppState();
    final category = appState.categories[widget.categoryIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text(category.name),
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
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: category.services.length,
        itemBuilder: (context, index) {
          return _buildServiceCard(context, category.services[index], index);
        },
      ),
      floatingActionButton: _editMode
          ? FloatingActionButton.extended(
              onPressed: _addService,
              backgroundColor: Colors.red,
              icon: const Icon(Icons.add, color: Colors.white),
              label: const Text(
                'Xizmat qo\'shish',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            )
          : null,
    );
  }

  Widget _buildServiceCard(BuildContext context, ServiceItem service, int index) {
    return GestureDetector(
      onTap: _editMode
          ? () => _editService(index)
          : () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ServiceDetailPage(
                    categoryIndex: widget.categoryIndex,
                    serviceIndex: index,
                  ),
                ),
              );
            },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
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
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                bottomLeft: Radius.circular(16),
              ),
              child: SizedBox(
                width: 120,
                height: 100,
                child: Image.network(
                  service.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.red.withOpacity(0.1),
                      child: const Icon(Icons.local_car_wash, size: 50, color: Colors.red),
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
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            service.name,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        if (_editMode)
                          GestureDetector(
                            onTap: () => _deleteService(index),
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Colors.red.withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.delete_outline, color: Colors.red, size: 18),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      service.price,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (!_editMode)
              const Padding(
                padding: EdgeInsets.only(right: 16.0),
                child: Icon(Icons.chevron_right, color: Colors.grey),
              ),
            if (_editMode)
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Icon(Icons.edit_outlined, color: Colors.red.withOpacity(0.6), size: 20),
              ),
          ],
        ),
      ),
    );
  }
}

// ======== Edit Service Bottom Sheet ========
class _EditServiceSheet extends StatefulWidget {
  final TextEditingController nameCtrl;
  final TextEditingController priceCtrl;
  final TextEditingController descCtrl;
  final TextEditingController imageCtrl;
  final VoidCallback onSave;
  final bool isNew;

  const _EditServiceSheet({
    required this.nameCtrl,
    required this.priceCtrl,
    required this.descCtrl,
    required this.imageCtrl,
    required this.onSave,
    this.isNew = false,
  });

  @override
  State<_EditServiceSheet> createState() => _EditServiceSheetState();
}

class _EditServiceSheetState extends State<_EditServiceSheet> {
  String _previewImageUrl = '';

  @override
  void initState() {
    super.initState();
    _previewImageUrl = widget.imageCtrl.text;
    widget.imageCtrl.addListener(() {
      setState(() => _previewImageUrl = widget.imageCtrl.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
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
                Text(
                  widget.isNew ? 'Yangi xizmat qo\'shish' : 'Xizmatni tahrirlash',
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Image preview
            if (_previewImageUrl.isNotEmpty)
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
                    _previewImageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      color: Colors.grey.shade100,
                      child: const Icon(Icons.broken_image, color: Colors.grey, size: 50),
                    ),
                  ),
                ),
              ),

            _sheetField('Xizmat nomi', widget.nameCtrl, Icons.text_fields),
            const SizedBox(height: 12),
            _sheetField('Narx', widget.priceCtrl, Icons.attach_money),
            const SizedBox(height: 12),
            _sheetField('Tavsif', widget.descCtrl, Icons.description_outlined, maxLines: 3),
            const SizedBox(height: 12),
            _sheetField('Rasm URL', widget.imageCtrl, Icons.image_outlined),
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
                child: Text(
                  widget.isNew ? 'Qo\'shish' : 'Saqlash',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _sheetField(String label, TextEditingController ctrl, IconData icon, {int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.black87)),
        const SizedBox(height: 6),
        TextField(
          controller: ctrl,
          maxLines: maxLines,
          decoration: InputDecoration(
            prefixIcon: maxLines == 1 ? Icon(icon, color: Colors.grey.shade400, size: 20) : null,
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
      ],
    );
  }
}
