import 'package:flutter/material.dart';

class ServiceItem {
  String name;
  String price;
  String description;
  String imageUrl;

  ServiceItem({
    required this.name,
    required this.price,
    required this.description,
    required this.imageUrl,
  });
}

class ServiceCategoryData {
  String name;
  IconData icon;
  String imageUrl;
  List<ServiceItem> services;

  ServiceCategoryData({
    required this.name,
    required this.icon,
    required this.imageUrl,
    required this.services,
  });
}

class PricingPlan {
  String title;
  String price;
  String discount;
  String description;
  bool isPopular;

  PricingPlan({
    required this.title,
    required this.price,
    required this.discount,
    required this.description,
    required this.isPopular,
  });
}

class ServiceTableRow {
  String service;
  String detail;

  ServiceTableRow({required this.service, required this.detail});
}

class AppState extends ChangeNotifier {
  static final AppState _instance = AppState._internal();
  factory AppState() => _instance;
  AppState._internal();

  // ======== Categories & Services ========
  List<ServiceCategoryData> categories = [
    ServiceCategoryData(
      name: '현장 외부 세차',
      icon: Icons.directions_car_filled,
      imageUrl: 'https://images.unsplash.com/photo-1601362840469-51e4d8d58785?w=400&h=400&fit=crop',
      services: [
        ServiceItem(
          name: '기본 외부 세차',
          price: '100,000원',
          description: '아파트 현장에서 진행되는 기본 외부 세차',
          imageUrl: 'https://images.unsplash.com/photo-1601362840469-51e4d8d58785?w=400&h=300&fit=crop',
        ),
        ServiceItem(
          name: '프리미엄 외부 세차',
          price: '115,000원',
          description: '광택 마무리가 포함된 외부 세차',
          imageUrl: 'https://images.unsplash.com/photo-1607860108855-64acf2078ed9?w=400&h=300&fit=crop',
        ),
        ServiceItem(
          name: '디럭스 외부 세차',
          price: '130,000원',
          description: '휠 및 하부까지 포함된 고급 외부 세차',
          imageUrl: 'https://images.unsplash.com/photo-1520340356584-f9917d1eea6f?w=400&h=300&fit=crop',
        ),
      ],
    ),
    ServiceCategoryData(
      name: '현장 실내 케어',
      icon: Icons.event_seat,
      imageUrl: 'https://images.unsplash.com/photo-1607860108855-64acf2078ed9?w=400&h=400&fit=crop',
      services: [
        ServiceItem(
          name: '실내 진공 청소',
          price: '100,000원',
          description: '차량 내부 전체 진공 청소',
          imageUrl: 'https://images.unsplash.com/photo-1607860108855-64acf2078ed9?w=400&h=300&fit=crop',
        ),
        ServiceItem(
          name: '실내 딥 클리닝',
          price: '120,000원',
          description: '시트와 바닥을 포함한 실내 집중 클리닝',
          imageUrl: 'https://images.unsplash.com/photo-1628177142898-93e36e4e3a50?w=400&h=300&fit=crop',
        ),
        ServiceItem(
          name: '가죽 시트 케어',
          price: '130,000원',
          description: '가죽 시트를 위한 전문 케어 서비스',
          imageUrl: 'https://images.unsplash.com/photo-1580273916550-e323be2ae537?w=400&h=300&fit=crop',
        ),
      ],
    ),
    ServiceCategoryData(
      name: '현장 종합 케어',
      icon: Icons.auto_awesome,
      imageUrl: 'https://images.unsplash.com/photo-1520340356584-f9917d1eea6f?w=400&h=400&fit=crop',
      services: [
        ServiceItem(
          name: '익스프레스 종합 케어',
          price: '110,000원',
          description: '외부와 실내를 빠르게 관리하는 서비스',
          imageUrl: 'https://images.unsplash.com/photo-1619642751034-765dfdf7c58e?w=400&h=300&fit=crop',
        ),
        ServiceItem(
          name: '풀 패키지 케어',
          price: '130,000원',
          description: '외부 및 실내 전체 관리 서비스',
          imageUrl: 'https://images.unsplash.com/photo-1607860108855-64acf2078ed9?w=400&h=300&fit=crop',
        ),
        ServiceItem(
          name: '도장 광택 케어',
          price: '125,000원',
          description: '차량 도장면 광택 및 컨디션 개선',
          imageUrl: 'https://images.unsplash.com/photo-1520340356584-f9917d1eea6f?w=400&h=300&fit=crop',
        ),
      ],
    ),
    ServiceCategoryData(
      name: '프리미엄 현장 서비스',
      icon: Icons.workspace_premium,
      imageUrl: 'https://images.unsplash.com/photo-1619642751034-765dfdf7c58e?w=400&h=400&fit=crop',
      services: [
        ServiceItem(
          name: '세라믹 보호 코팅',
          price: '130,000원',
          description: '차량 도장면을 보호하는 세라믹 코팅',
          imageUrl: 'https://images.unsplash.com/photo-1619405399517-d7fce0f13302?w=400&h=300&fit=crop',
        ),
        ServiceItem(
          name: '엔진룸 클리닝',
          price: '120,000원',
          description: '엔진룸 안전 클리닝 서비스',
          imageUrl: 'https://images.unsplash.com/photo-1486262715619-67b85e0b08d3?w=400&h=300&fit=crop',
        ),
        ServiceItem(
          name: '헤드라이트 복원',
          price: '100,000원',
          description: '탁해진 헤드라이트 투명도 복원',
          imageUrl: 'https://images.unsplash.com/photo-1552519507-da3b142c6e3d?w=400&h=300&fit=crop',
        ),
      ],
    ),
  ];

  // ======== Pricing Plans ========
  List<PricingPlan> pricingPlans = [
    PricingPlan(
      title: '1회권',
      price: '130,000원',
      discount: '0%',
      description: '할인 없음',
      isPopular: false,
    ),
    PricingPlan(
      title: '3회권',
      price: '117,000원',
      discount: '10%',
      description: '월 1회 이용',
      isPopular: false,
    ),
    PricingPlan(
      title: '6회권',
      price: '110,500원',
      discount: '15%',
      description: '2주 1회 이용',
      isPopular: true,
    ),
    PricingPlan(
      title: '12회권',
      price: '104,000원',
      discount: '20%',
      description: '주 1회 이용 추천',
      isPopular: true,
    ),
  ];

  // ======== Service Table ========
  List<ServiceTableRow> serviceTable = [
    ServiceTableRow(service: '외부 세차', detail: '프리미엄 거품 세정'),
    ServiceTableRow(service: '휠 클리닝', detail: '전용 약품 사용'),
    ServiceTableRow(service: '유리막 제거', detail: '특수 약제 처리'),
    ServiceTableRow(service: '도어 틈새 세척', detail: '디테일 케어'),
    ServiceTableRow(service: '왁스 코팅', detail: '광택 마무리'),
    ServiceTableRow(service: '하부 세척', detail: '고압 분사'),
  ];

  // ======== Methods ========
  void updateCategory(int index, ServiceCategoryData updated) {
    categories[index] = updated;
    notifyListeners();
  }

  void updateService(int catIndex, int svcIndex, ServiceItem updated) {
    categories[catIndex].services[svcIndex] = updated;
    notifyListeners();
  }

  void updatePricingPlan(int index, PricingPlan updated) {
    pricingPlans[index] = updated;
    notifyListeners();
  }

  void updateServiceTableRow(int index, ServiceTableRow updated) {
    serviceTable[index] = updated;
    notifyListeners();
  }

  void addServiceTableRow(ServiceTableRow row) {
    serviceTable.add(row);
    notifyListeners();
  }

  void removeServiceTableRow(int index) {
    serviceTable.removeAt(index);
    notifyListeners();
  }

  void addService(int catIndex, ServiceItem service) {
    categories[catIndex].services.add(service);
    notifyListeners();
  }

  void removeService(int catIndex, int svcIndex) {
    categories[catIndex].services.removeAt(svcIndex);
    notifyListeners();
  }
}
