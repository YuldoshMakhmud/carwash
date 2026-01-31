import 'package:carwash/models/data_models.dart';
import 'package:flutter/material.dart';

class ServiceDetailPage extends StatelessWidget {
  final Service service;

  const ServiceDetailPage({Key? key, required this.service}) : super(key: key);

  // Service images mapped by service name
  final Map<String, String> serviceImages = const {
    '기본 외부 세차':
        'https://images.unsplash.com/photo-1601362840469-51e4d8d58785?w=800&h=600&fit=crop',
    '프리미엄 외부 세차':
        'https://images.unsplash.com/photo-1607860108855-64acf2078ed9?w=800&h=600&fit=crop',
    '디럭스 외부 세차':
        'https://images.unsplash.com/photo-1520340356584-f9917d1eea6f?w=800&h=600&fit=crop',
    '실내 진공 청소':
        'https://images.unsplash.com/photo-1607860108855-64acf2078ed9?w=800&h=600&fit=crop',
    '실내 딥 클리닝':
        'https://images.unsplash.com/photo-1628177142898-93e36e4e3a50?w=800&h=600&fit=crop',
    '가죽 시트 케어':
        'https://images.unsplash.com/photo-1580273916550-e323be2ae537?w=800&h=600&fit=crop',
    '익스프레스 종합 케어':
        'https://images.unsplash.com/photo-1619642751034-765dfdf7c58e?w=800&h=600&fit=crop',
    '풀 패키지 케어':
        'https://images.unsplash.com/photo-1607860108855-64acf2078ed9?w=800&h=600&fit=crop',
    '도장 광택 케어':
        'https://images.unsplash.com/photo-1520340356584-f9917d1eea6f?w=800&h=600&fit=crop',
    '세라믹 보호 코팅':
        'https://images.unsplash.com/photo-1619405399517-d7fce0f13302?w=800&h=600&fit=crop',
    '엔진룸 클리닝':
        'https://images.unsplash.com/photo-1486262715619-67b85e0b08d3?w=800&h=600&fit=crop',
    '헤드라이트 복원':
        'https://images.unsplash.com/photo-1552519507-da3b142c6e3d?w=800&h=600&fit=crop',
  };

  @override
  Widget build(BuildContext context) {
    final imageUrl =
        serviceImages[service.name] ??
        'https://images.unsplash.com/photo-1601362840469-51e4d8d58785?w=800&h=600&fit=crop';

    return Scaffold(
      appBar: AppBar(title: const Text('Service Details')),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              height: 300,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.red.withOpacity(0.1),
                        child: const Icon(
                          Icons.local_car_wash,
                          size: 150,
                          color: Colors.red,
                        ),
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
                  // Gradient overlay
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
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    service.name,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
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
                  const Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    service.description,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Additional service features
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
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 12),
                        _buildFeatureItem(Icons.check_circle, '전문 세차 기사 방문'),
                        _buildFeatureItem(Icons.check_circle, '친환경 세제 사용'),
                        _buildFeatureItem(Icons.check_circle, '고압 세척 장비'),
                        _buildFeatureItem(Icons.check_circle, '만족도 보장'),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),
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
                            'Prices shown are for informational purposes only. This is a catalog app.',
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

  Widget _buildFeatureItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.green, size: 20),
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
