# 🚀 CryptoPulse Dashboard

**CryptoPulse** là một ứng dụng theo dõi tiền điện tử đa nền tảng được xây dựng bằng Flutter và Dart. Ứng dụng tập trung vào trải nghiệm người dùng cao cấp (Premium UI), dữ liệu thời gian thực và kiến trúc mã nguồn sạch (Clean Architecture).

## ✨ Tính năng nổi bật (Giai đoạn 1)

- **Premium Dark UI**: Giao diện chế độ tối hiện đại với phong cách Glassmorphism và Neon Glowing.
- **Real-time Data**: Tích hợp CoinGecko API để cập nhật giá, biểu đồ và thông tin của hơn 100 đồng tiền điện tử hàng đầu.
- **Advanced Animations**:
  - **Staggered Entrance**: Các thành phần giao diện xuất hiện lần lượt với hiệu ứng trượt mờ dần (FadeInSlide).
  - **Hero Transitions**: Hiệu ứng Logo "bay" mượt mà giữa các màn hình.
- **Interactive Charts**: Biểu đồ hình nến mini (Sparklines) ngay trong danh sách và biểu đồ chi tiết (Standard Line Chart) trong màn hình Coin Detail.
- **Smart Search**: Tìm kiếm coin theo tên hoặc ký hiệu (BTC, ETH...) theo thời gian thực.
- **Splash Screen**: Màn hình chào ấn tượng với hiệu ứng Scale và hiệu ứng phát sáng.
- **Professional Formatting**: Hiển thị tiền tệ chuẩn quốc tế sử dụng thư viện `intl`.

## 🏗️ Kiến trúc & Công nghệ

- **Framework**: [Flutter](https://flutter.dev)
- **State Management**: [Riverpod](https://riverpod.dev) (Sử dụng AsyncValue cho dữ liệu API).
- **Architecture**: **Clean Architecture** (phân lớp: Core, Features -> Data, Domain, Presentation).
- **Networking**: [Dio](https://pub.dev/packages/dio) với quản lý Provider tập trung.
- **Design System**: Hệ thống mã màu và Theme tùy chỉnh (`AppColors`, `AppTheme`).
- **Charts**: [fl_chart](https://pub.dev/packages/fl_chart).

## 🚀 Hướng dấn chạy dự án

1. **Yêu cầu**: Đã cài đặt Flutter SDK (3.x trở lên).
2. **Cài đặt thư viện**:
   ```bash
   flutter pub get
   ```
3. **Chạy ứng dụng**:
   ```bash
   flutter run -d chrome  # Hoặc thiết bị của bạn
   ```

## 📂 Cấu trúc thư mục chính

- `lib/core`: Chứa các hằng số, theme, và tiện ích dùng chung (animation, format).
- `lib/features/dashboard`: Quản lý màn hình chính, danh sách coin và các widget liên quan.
- `lib/features/coin_detail`: Quản lý màn hình chi tiết và biểu đồ lớn.
- `openspec/`: Chứa các tài liệu thiết kế (Design), công việc (Tasks) và đặc tả (Specs) theo quy chuẩn OpenSpec.

---
*Dự án đang trong quá trình phát triển và mở rộng.*
