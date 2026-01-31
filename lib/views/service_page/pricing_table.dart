import 'package:flutter/material.dart';

class PricingTablePage extends StatelessWidget {
  const PricingTablePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('프리미엄 정기권 요금표'), centerTitle: true),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Section
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
              child: Column(
                children: [
                  const Icon(
                    Icons.workspace_premium,
                    size: 60,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    '아파트 프리미엄 세차',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '정기 구독으로 최대 20% 할인',
                    style: TextStyle(fontSize: 16, color: Colors.white70),
                  ),
                ],
              ),
            ),

            // Pricing Cards
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  _buildPricingCard(
                    '1회권',
                    '130,000원',
                    '0%',
                    '할인 없음',
                    Colors.grey.shade100,
                    false,
                  ),
                  const SizedBox(height: 16),
                  _buildPricingCard(
                    '3회권',
                    '117,000원',
                    '10%',
                    '월 1회 이용',
                    Colors.blue.shade50,
                    false,
                  ),
                  const SizedBox(height: 16),
                  _buildPricingCard(
                    '6회권',
                    '110,500원',
                    '15%',
                    '2주 1회 이용',
                    Colors.orange.shade50,
                    true,
                  ),
                  const SizedBox(height: 16),
                  _buildPricingCard(
                    '12회권',
                    '104,000원',
                    '20%',
                    '주 1회 이용 추천',
                    Colors.red.shade50,
                    true,
                  ),
                ],
              ),
            ),

            // Luxury Car Section
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '프리미엄 차량 관리',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
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

            // Service Details Table
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '서비스 상세 내역',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildServiceTable(),
                ],
              ),
            ),

            // Benefits Section
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 16,
              ),
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
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildBenefitItem(Icons.schedule, '유효기간 6개월'),
                    _buildBenefitItem(Icons.home, '아파트 현장 방문 서비스'),
                    _buildBenefitItem(Icons.verified_user, '전문 세차 기사 파견'),
                    _buildBenefitItem(Icons.local_offer, '정기권 추가 10% 포인트 적립'),
                    _buildBenefitItem(Icons.card_giftcard, '첫 구매 시 무료 실내 살균'),
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

  Widget _buildPricingCard(
    String title,
    String price,
    String discount,
    String description,
    Color backgroundColor,
    bool isPopular,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isPopular ? Colors.red : Colors.grey.shade200,
          width: isPopular ? 2 : 1,
        ),
        boxShadow: isPopular
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
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: isPopular ? Colors.red : Colors.black87,
                      ),
                    ),
                    if (discount != '0%')
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '$discount 할인',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      price,
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: isPopular ? Colors.red : Colors.black,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 6.0),
                      child: Text(
                        '/ 1회',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ),
          if (isPopular)
            Positioned(
              top: 16,
              right: 16,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  '인기',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildCarGrid() {
    final cars = [
      {
        'name': 'Genesis GV80',
        'image':
            'https://images.unsplash.com/photo-1619405399517-d7fce0f13302?w=400&h=300&fit=crop',
      },
      {
        'name': 'Mercedes-Benz GLE',
        'image':
            'https://images.unsplash.com/photo-1618843479313-40f8afb4b4d8?w=400&h=300&fit=crop',
      },
      {
        'name': 'BMW X5',
        'image':
            'https://images.unsplash.com/photo-1555215695-3004980ad54e?w=400&h=300&fit=crop',
      },
      {
        'name': 'Audi Q7',
        'image':
            'https://images.unsplash.com/photo-1606664515524-ed2f786a0bd6?w=400&h=300&fit=crop',
      },
      {
        'name': 'Lexus RX',
        'image':
            'https://images.unsplash.com/photo-1621135802920-133df287f89c?w=400&h=300&fit=crop',
      },
      {
        'name': 'Porsche Cayenne',
        'image':
            'https://images.unsplash.com/photo-1503376780353-7e6692767b70?w=400&h=300&fit=crop',
      },
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
                        child: const Icon(
                          Icons.directions_car,
                          size: 40,
                          color: Colors.grey,
                        ),
                      );
                    },
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        color: Colors.grey.shade200,
                        child: const Center(
                          child: CircularProgressIndicator(
                            color: Colors.red,
                            strokeWidth: 2,
                          ),
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
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
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
        children: [
          _buildTableRow('외부 세차', '프리미엄 거품 세정', true),
          _buildTableRow('휠 클리닝', '전용 약품 사용', false),
          _buildTableRow('유리막 제거', '특수 약제 처리', true),
          _buildTableRow('도어 틈새 세척', '디테일 케어', false),
          _buildTableRow('왁스 코팅', '광택 마무리', true),
          _buildTableRow('하부 세척', '고압 분사', false),
        ],
      ),
    );
  }

  Widget _buildTableRow(String service, String detail, bool isEven) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: isEven ? Colors.grey.shade50 : Colors.white,
      ),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Colors.green, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              service,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),
          Text(
            detail,
            style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }

  Widget _buildBenefitItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.red, size: 22),
          const SizedBox(width: 12),
          Text(
            text,
            style: const TextStyle(fontSize: 15, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}
