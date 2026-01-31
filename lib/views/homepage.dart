import 'package:carwash/models/data_models.dart';
import 'package:carwash/views/service_page/service_list.dart';
import 'package:carwash/views/service_page/pricing_table.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categories = [
      ServiceCategory(
        name: '현장 외부 세차',
        icon: Icons.directions_car_filled,
        services: [
          Service(
            name: '기본 외부 세차',
            price: '100,000원',
            description: '아파트 현장에서 진행되는 기본 외부 세차',
          ),
          Service(
            name: '프리미엄 외부 세차',
            price: '115,000원',
            description: '광택 마무리가 포함된 외부 세차',
          ),
          Service(
            name: '디럭스 외부 세차',
            price: '130,000원',
            description: '휠 및 하부까지 포함된 고급 외부 세차',
          ),
        ],
      ),
      ServiceCategory(
        name: '현장 실내 케어',
        icon: Icons.event_seat,
        services: [
          Service(
            name: '실내 진공 청소',
            price: '100,000원',
            description: '차량 내부 전체 진공 청소',
          ),
          Service(
            name: '실내 딥 클리닝',
            price: '120,000원',
            description: '시트와 바닥을 포함한 실내 집중 클리닝',
          ),
          Service(
            name: '가죽 시트 케어',
            price: '130,000원',
            description: '가죽 시트를 위한 전문 케어 서비스',
          ),
        ],
      ),
      ServiceCategory(
        name: '현장 종합 케어',
        icon: Icons.auto_awesome,
        services: [
          Service(
            name: '익스프레스 종합 케어',
            price: '110,000원',
            description: '외부와 실내를 빠르게 관리하는 서비스',
          ),
          Service(
            name: '풀 패키지 케어',
            price: '130,000원',
            description: '외부 및 실내 전체 관리 서비스',
          ),
          Service(
            name: '도장 광택 케어',
            price: '125,000원',
            description: '차량 도장면 광택 및 컨디션 개선',
          ),
        ],
      ),
      ServiceCategory(
        name: '프리미엄 현장 서비스',
        icon: Icons.workspace_premium,
        services: [
          Service(
            name: '세라믹 보호 코팅',
            price: '130,000원',
            description: '차량 도장면을 보호하는 세라믹 코팅',
          ),
          Service(
            name: '엔진룸 클리닝',
            price: '120,000원',
            description: '엔진룸 안전 클리닝 서비스',
          ),
          Service(
            name: '헤드라이트 복원',
            price: '100,000원',
            description: '탁해진 헤드라이트 투명도 복원',
          ),
        ],
      ),
    ];

    // Category images for network loading
    final categoryImages = [
      'https://images.unsplash.com/photo-1601362840469-51e4d8d58785?w=400&h=400&fit=crop', // 외부 세차
      'https://images.unsplash.com/photo-1607860108855-64acf2078ed9?w=400&h=400&fit=crop', // 실내 케어
      'https://images.unsplash.com/photo-1520340356584-f9917d1eea6f?w=400&h=400&fit=crop', // 종합 케어
      'https://images.unsplash.com/photo-1619642751034-765dfdf7c58e?w=400&h=400&fit=crop', // 프리미엄 서비스
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Car Wash Services'), centerTitle: true),
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
            const SizedBox(height: 24),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.85,
                ),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return _buildCategoryCard(
                    context,
                    categories[index],
                    categoryImages[index],
                  );
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

  Widget _buildCategoryCard(
    BuildContext context,
    ServiceCategory category,
    String imageUrl,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ServiceListPage(category: category),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey[200]!),
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
                      imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.red.withOpacity(0.1),
                          child: Icon(
                            category.icon,
                            size: 50,
                            color: Colors.red,
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
                    // Gradient overlay for better text readability
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
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${category.services.length}개 서비스',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
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
