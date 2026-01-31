import 'package:carwash/models/data_models.dart';
import 'package:carwash/views/widgets/service_list_detail.dart';
import 'package:flutter/material.dart';

class ServiceListPage extends StatelessWidget {
  final ServiceCategory category;

  const ServiceListPage({Key? key, required this.category}) : super(key: key);

  // Service images mapped by service name
  final Map<String, String> serviceImages = const {
    '기본 외부 세차':
        'https://images.unsplash.com/photo-1601362840469-51e4d8d58785?w=400&h=300&fit=crop',
    '프리미엄 외부 세차':
        'https://images.unsplash.com/photo-1607860108855-64acf2078ed9?w=400&h=300&fit=crop',
    '디럭스 외부 세차':
        'https://images.unsplash.com/photo-1520340356584-f9917d1eea6f?w=400&h=300&fit=crop',
    '실내 진공 청소':
        'https://images.unsplash.com/photo-1607860108855-64acf2078ed9?w=400&h=300&fit=crop',
    '실내 딥 클리닝':
        'https://images.unsplash.com/photo-1628177142898-93e36e4e3a50?w=400&h=300&fit=crop',
    '가죽 시트 케어':
        'https://images.unsplash.com/photo-1580273916550-e323be2ae537?w=400&h=300&fit=crop',
    '익스프레스 종합 케어':
        'https://images.unsplash.com/photo-1619642751034-765dfdf7c58e?w=400&h=300&fit=crop',
    '풀 패키지 케어':
        'https://images.unsplash.com/photo-1607860108855-64acf2078ed9?w=400&h=300&fit=crop',
    '도장 광택 케어':
        'https://images.unsplash.com/photo-1520340356584-f9917d1eea6f?w=400&h=300&fit=crop',
    '세라믹 보호 코팅':
        'https://images.unsplash.com/photo-1619405399517-d7fce0f13302?w=400&h=300&fit=crop',
    '엔진룸 클리닝':
        'https://images.unsplash.com/photo-1486262715619-67b85e0b08d3?w=400&h=300&fit=crop',
    '헤드라이트 복원':
        'https://images.unsplash.com/photo-1552519507-da3b142c6e3d?w=400&h=300&fit=crop',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(category.name)),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: category.services.length,
        itemBuilder: (context, index) {
          return _buildServiceCard(context, category.services[index]);
        },
      ),
    );
  }

  Widget _buildServiceCard(BuildContext context, Service service) {
    final imageUrl =
        serviceImages[service.name] ??
        'https://images.unsplash.com/photo-1601362840469-51e4d8d58785?w=400&h=300&fit=crop';

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ServiceDetailPage(service: service),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
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
                  imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.red.withOpacity(0.1),
                      child: const Icon(
                        Icons.local_car_wash,
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
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      service.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      service.price,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(right: 16.0),
              child: Icon(Icons.chevron_right, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
