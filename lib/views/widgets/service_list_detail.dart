import 'package:carwash/models/app_state.dart';
import 'package:flutter/material.dart';

class ServiceDetailPage extends StatefulWidget {
  final int categoryIndex;
  final int serviceIndex;

  const ServiceDetailPage({
    Key? key,
    required this.categoryIndex,
    required this.serviceIndex,
  }) : super(key: key);

  @override
  State<ServiceDetailPage> createState() => _ServiceDetailPageState();
}

class _ServiceDetailPageState extends State<ServiceDetailPage> {
  bool _editMode = false;

  void _toggleEditMode() => setState(() => _editMode = !_editMode);

  void _editService() {
    final appState = AppState();
    final service = appState.categories[widget.categoryIndex].services[widget.serviceIndex];
    final nameCtrl = TextEditingController(text: service.name);
    final priceCtrl = TextEditingController(text: service.price);
    final descCtrl = TextEditingController(text: service.description);
    final imageCtrl = TextEditingController(text: service.imageUrl);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _DetailEditSheet(
        nameCtrl: nameCtrl,
        priceCtrl: priceCtrl,
        descCtrl: descCtrl,
        imageCtrl: imageCtrl,
        onSave: () {
          appState.updateService(
            widget.categoryIndex,
            widget.serviceIndex,
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

  @override
  Widget build(BuildContext context) {
    final appState = AppState();
    final service = appState.categories[widget.categoryIndex].services[widget.serviceIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Xizmat tafsiloti'),
        actions: [
          TextButton.icon(
            onPressed: _editMode ? _editService : _toggleEditMode,
            icon: Icon(
              _editMode ? Icons.edit : Icons.edit_outlined,
              color: Colors.red,
              size: 18,
            ),
            label: Text(
              _editMode ? 'Tahrirlash' : 'Edit',
              style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            GestureDetector(
              onTap: _editMode ? _editService : null,
              child: SizedBox(
                width: double.infinity,
                height: 300,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      service.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.red.withOpacity(0.1),
                          child: const Icon(Icons.local_car_wash, size: 150, color: Colors.red),
                        );
                      },
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          color: Colors.grey.shade200,
                          child: Center(
                            child: CircularProgressIndicator(
                              color: Colors.red,
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          ),
                        );
                      },
                    ),
                    // Gradient
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
                    // Edit overlay
                    if (_editMode)
                      Container(
                        color: Colors.black.withOpacity(0.3),
                        child: const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.camera_alt, color: Colors.white, size: 40),
                              SizedBox(height: 8),
                              Text(
                                'Rasmni o\'zgartirish',
                                style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name
                  Text(
                    service.name,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Price
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      service.price,
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Description
                  const Text(
                    'Tavsif',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    service.description,
                    style: const TextStyle(fontSize: 16, color: Colors.grey, height: 1.5),
                  ),
                  const SizedBox(height: 24),

                  // Service inclusions
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey[200]!),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '서비스 포함 사항',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
                        ),
                        const SizedBox(height: 12),
                        _featureItem(Icons.check_circle, '전문 세차 기사 방문'),
                        _featureItem(Icons.check_circle, '친환경 세제 사용'),
                        _featureItem(Icons.check_circle, '고압 세척 장비'),
                        _featureItem(Icons.check_circle, '만족도 보장'),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Edit button in edit mode
                  if (_editMode)
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton.icon(
                        onPressed: _editService,
                        icon: const Icon(Icons.edit, color: Colors.white),
                        label: const Text(
                          'Ma\'lumotlarni tahrirlash',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                          elevation: 0,
                        ),
                      ),
                    ),

                  const SizedBox(height: 16),

                  // Info disclaimer
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.info_outline, color: Colors.grey),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Narxlar ma\'lumot maqsadida ko\'rsatilgan.',
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _featureItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.green, size: 20),
          const SizedBox(width: 12),
          Text(text, style: const TextStyle(fontSize: 15, color: Colors.black87)),
        ],
      ),
    );
  }
}

// ======== Detail Edit Sheet ========
class _DetailEditSheet extends StatefulWidget {
  final TextEditingController nameCtrl;
  final TextEditingController priceCtrl;
  final TextEditingController descCtrl;
  final TextEditingController imageCtrl;
  final VoidCallback onSave;

  const _DetailEditSheet({
    required this.nameCtrl,
    required this.priceCtrl,
    required this.descCtrl,
    required this.imageCtrl,
    required this.onSave,
  });

  @override
  State<_DetailEditSheet> createState() => _DetailEditSheetState();
}

class _DetailEditSheetState extends State<_DetailEditSheet> {
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
                  'Xizmatni tahrirlash',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 8),

            if (_previewUrl.isNotEmpty)
              Container(
                height: 140,
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

            _field('Xizmat nomi', widget.nameCtrl),
            const SizedBox(height: 10),
            _field('Narx (masalan: 100,000원)', widget.priceCtrl),
            const SizedBox(height: 10),
            _field('Tavsif', widget.descCtrl, maxLines: 3),
            const SizedBox(height: 10),
            _field('Rasm URL', widget.imageCtrl),
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
                child: const Text(
                  'Saqlash',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _field(String label, TextEditingController ctrl, {int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.black87)),
        const SizedBox(height: 6),
        TextField(
          controller: ctrl,
          maxLines: maxLines,
          decoration: InputDecoration(
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
