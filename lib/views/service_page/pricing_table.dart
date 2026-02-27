import 'package:carwash/models/app_state.dart';
import 'package:flutter/material.dart';

class PricingTablePage extends StatefulWidget {
  const PricingTablePage({Key? key}) : super(key: key);

  @override
  State<PricingTablePage> createState() => _PricingTablePageState();
}

class _PricingTablePageState extends State<PricingTablePage> {
  bool _editMode = false;
  final AppState _appState = AppState();

  void _toggleEditMode() => setState(() => _editMode = !_editMode);

  void _editPlan(int index) {
    final plan = _appState.pricingPlans[index];
    final titleCtrl = TextEditingController(text: plan.title);
    final priceCtrl = TextEditingController(text: plan.price);
    final discountCtrl = TextEditingController(text: plan.discount);
    final descCtrl = TextEditingController(text: plan.description);
    bool isPopular = plan.isPopular;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setSheetState) => Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(ctx).viewInsets.bottom,
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
                    const Text(
                      'Narx rejasini tahrirlash',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(ctx),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _sheetField('Sarlavha (masalan: 3회권)', titleCtrl),
                const SizedBox(height: 12),
                _sheetField('Narx (masalan: 117,000원)', priceCtrl),
                const SizedBox(height: 12),
                _sheetField('Chegirma (masalan: 10%)', discountCtrl),
                const SizedBox(height: 12),
                _sheetField('Tavsif (masalan: 월 1회 이용)', descCtrl),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Switch(
                      value: isPopular,
                      onChanged: (val) => setSheetState(() => isPopular = val),
                      activeColor: Colors.red,
                    ),
                    const SizedBox(width: 8),
                    const Text('Mashhur (인기) ko\'rsatish'),
                  ],
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () {
                      _appState.updatePricingPlan(
                        index,
                        PricingPlan(
                          title: titleCtrl.text.trim(),
                          price: priceCtrl.text.trim(),
                          discount: discountCtrl.text.trim(),
                          description: descCtrl.text.trim(),
                          isPopular: isPopular,
                        ),
                      );
                      setState(() {});
                      Navigator.pop(ctx);
                    },
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
        ),
      ),
    );
  }

  void _editTableRow(int index) {
    final row = _appState.serviceTable[index];
    final serviceCtrl = TextEditingController(text: row.service);
    final detailCtrl = TextEditingController(text: row.detail);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  const Text('Satr tahrirlash', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const Spacer(),
                  IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(ctx)),
                ],
              ),
              const SizedBox(height: 16),
              _sheetField('Xizmat nomi', serviceCtrl),
              const SizedBox(height: 12),
              _sheetField('Tafsilot', detailCtrl),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        _appState.removeServiceTableRow(index);
                        setState(() {});
                        Navigator.pop(ctx);
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.red,
                        side: const BorderSide(color: Colors.red),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text("O'chirish", style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        _appState.updateServiceTableRow(
                          index,
                          ServiceTableRow(
                            service: serviceCtrl.text.trim(),
                            detail: detailCtrl.text.trim(),
                          ),
                        );
                        setState(() {});
                        Navigator.pop(ctx);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text('Saqlash', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  void _addTableRow() {
    final serviceCtrl = TextEditingController();
    final detailCtrl = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  const Text('Yangi satr qo\'shish', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const Spacer(),
                  IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(ctx)),
                ],
              ),
              const SizedBox(height: 16),
              _sheetField('Xizmat nomi', serviceCtrl),
              const SizedBox(height: 12),
              _sheetField('Tafsilot', detailCtrl),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    if (serviceCtrl.text.trim().isEmpty) return;
                    _appState.addServiceTableRow(
                      ServiceTableRow(service: serviceCtrl.text.trim(), detail: detailCtrl.text.trim()),
                    );
                    setState(() {});
                    Navigator.pop(ctx);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    elevation: 0,
                  ),
                  child: const Text('Qo\'shish', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sheetField(String label, TextEditingController ctrl, {int maxLines = 1}) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('프리미엄 정기권 요금표'),
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.red.shade700, Colors.red.shade400],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: const Column(
                children: [
                  Icon(Icons.workspace_premium, size: 60, color: Colors.white),
                  SizedBox(height: 16),
                  Text(
                    '아파트 프리미엄 세차',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '정기 구독으로 최대 20% 할인',
                    style: TextStyle(fontSize: 16, color: Colors.white70),
                  ),
                ],
              ),
            ),

            // Edit mode hint
            if (_editMode)
              Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.orange.shade200),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, color: Colors.orange.shade700, size: 18),
                    const SizedBox(width: 8),
                    Text(
                      'Edit rejimida. Tahrirlash uchun bosing.',
                      style: TextStyle(color: Colors.orange.shade800, fontSize: 13),
                    ),
                  ],
                ),
              ),

            // Pricing Cards
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: List.generate(_appState.pricingPlans.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: GestureDetector(
                      onTap: _editMode ? () => _editPlan(index) : null,
                      child: _buildPricingCard(_appState.pricingPlans[index]),
                    ),
                  );
                }),
              ),
            ),

            // Luxury Cars
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '프리미엄 차량 관리',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '모든 고급 차량에 최적화된 서비스',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 24),
                  _buildCarGrid(),
                ],
              ),
            ),

            // Service Table
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text(
                        '서비스 상세 내역',
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87),
                      ),
                      const Spacer(),
                      if (_editMode)
                        GestureDetector(
                          onTap: _addTableRow,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.add, color: Colors.white, size: 16),
                                SizedBox(width: 4),
                                Text('Qo\'shish', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildServiceTable(),
                ],
              ),
            ),

            // Benefits
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '정기권 혜택',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
                    ),
                    const SizedBox(height: 16),
                    _benefitItem(Icons.schedule, '유효기간 6개월'),
                    _benefitItem(Icons.home, '아파트 현장 방문 서비스'),
                    _benefitItem(Icons.verified_user, '전문 세차 기사 파견'),
                    _benefitItem(Icons.local_offer, '정기권 추가 10% 포인트 적립'),
                    _benefitItem(Icons.card_giftcard, '첫 구매 시 무료 실내 살균'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildPricingCard(PricingPlan plan) {
    Color bgColor;
    if (plan.discount == '0%') {
      bgColor = Colors.grey.shade100;
    } else if (plan.discount == '10%') {
      bgColor = Colors.blue.shade50;
    } else if (plan.discount == '15%') {
      bgColor = Colors.orange.shade50;
    } else {
      bgColor = Colors.red.shade50;
    }

    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: plan.isPopular ? Colors.red : Colors.grey.shade200,
          width: plan.isPopular ? 2 : 1,
        ),
        boxShadow: plan.isPopular
            ? [
                BoxShadow(
                  color: Colors.red.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ]
            : [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      plan.title,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: plan.isPopular ? Colors.red : Colors.black87,
                      ),
                    ),
                    if (plan.discount != '0%')
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(20)),
                        child: Text(
                          '${plan.discount} 할인',
                          style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      plan.price,
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: plan.isPopular ? Colors.red : Colors.black,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 6),
                      child: Text('/ 1회', style: TextStyle(fontSize: 16, color: Colors.grey)),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(plan.description, style: const TextStyle(fontSize: 14, color: Colors.grey)),
                if (_editMode)
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Row(
                      children: [
                        Icon(Icons.edit_outlined, color: Colors.red.withOpacity(0.7), size: 14),
                        const SizedBox(width: 4),
                        Text(
                          'Tahrirlash uchun bosing',
                          style: TextStyle(color: Colors.red.withOpacity(0.7), fontSize: 12),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          if (plan.isPopular)
            Positioned(
              top: 16,
              right: 16,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(20)),
                child: const Text(
                  '인기',
                  style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildCarGrid() {
    final cars = [
      {'name': 'Genesis GV80', 'image': 'https://images.unsplash.com/photo-1619405399517-d7fce0f13302?w=400&h=300&fit=crop'},
      {'name': 'Mercedes-Benz GLE', 'image': 'https://images.unsplash.com/photo-1618843479313-40f8afb4b4d8?w=400&h=300&fit=crop'},
      {'name': 'BMW X5', 'image': 'https://images.unsplash.com/photo-1555215695-3004980ad54e?w=400&h=300&fit=crop'},
      {'name': 'Audi Q7', 'image': 'https://images.unsplash.com/photo-1606664515524-ed2f786a0bd6?w=400&h=300&fit=crop'},
      {'name': 'Lexus RX', 'image': 'https://images.unsplash.com/photo-1621135802920-133df287f89c?w=400&h=300&fit=crop'},
      {'name': 'Porsche Cayenne', 'image': 'https://images.unsplash.com/photo-1503376780353-7e6692767b70?w=400&h=300&fit=crop'},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.2,
      ),
      itemCount: cars.length,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade200),
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
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                  child: Image.network(
                    cars[index]['image']!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey.shade200,
                        child: const Icon(Icons.directions_car, size: 40, color: Colors.grey),
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  cars[index]['name']!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black87),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildServiceTable() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: List.generate(_appState.serviceTable.length, (index) {
          final row = _appState.serviceTable[index];
          final isEven = index % 2 == 0;
          return GestureDetector(
            onTap: _editMode ? () => _editTableRow(index) : null,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: isEven ? Colors.grey.shade50 : Colors.white,
                border: _editMode
                    ? Border(bottom: BorderSide(color: Colors.red.withOpacity(0.1)))
                    : null,
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.check_circle,
                    color: _editMode ? Colors.orange : Colors.green,
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      row.service,
                      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black87),
                    ),
                  ),
                  Text(row.detail, style: TextStyle(fontSize: 13, color: Colors.grey.shade600)),
                  if (_editMode)
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Icon(Icons.edit_outlined, size: 14, color: Colors.red.withOpacity(0.6)),
                    ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _benefitItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.red, size: 22),
          const SizedBox(width: 12),
          Text(text, style: const TextStyle(fontSize: 15, color: Colors.black87)),
        ],
      ),
    );
  }
}
