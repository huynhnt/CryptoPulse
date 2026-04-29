# Quy tắc kỹ thuật (Tech Stack Rules)

Quy định về kiến trúc và công nghệ sử dụng trong dự án CryptoPulse.

## 1. Kiến trúc (Architecture)
- Dự án tuân thủ **Clean Architecture** chia làm 3 lớp chính:
    - **Domain**: Entities, Repositories Interfaces, UseCases. (Cấm phụ thuộc vào Flutter hoặc lớp ngoài).
    - **Data**: Repositories Implementations, Models (DTOs), Data Sources.
    - **Presentation**: ViewModels (Providers), Widgets, Screens.

## 2. Quản lý trạng thái (State Management)
- Sử dụng **Flutter Riverpod** (phiên bản ^2.0.0).
- Sử dụng `ConsumerStatefulWidget` cho các tương tác UI phức tạp yêu cầu tần suất rebuild cao (như biểu đồ, animation).
- Sử dụng `Provider` hoặc `StateNotifierProvider` (hoặc `NotifierProvider` của Riverpod 2) cho Global state.

## 3. Tiêu chuẩn UI/UX
- Luôn ưu tiên thiết kế **Premium**, thẩm mỹ cao (Sử dụng Glassmorphism, animations, gradients).
- **Haptic Feedback**: PHẢI tích hợp cho các tương tác quan trọng (như chạm biểu đồ, đổi mục chọn).
- **Responsive**: Đảm bảo app chạy tốt trên cả Mobile và Web.

## 4. Kiểm thử (Testing)
- Khi hoàn thành một tính năng, PHẢI chạy lệnh `flutter test` để kiểm tra các thay đổi không phá vỡ logic cũ.

## 5. Tích hợp API (API Integration)
- Khi phát triển các tính năng gọi API, LUÔN LUÔN tham chiếu tài liệu OpenAPI chính thức của Backend tại đường dẫn: `d:\Working\AI\CryptoPulseBackend\docs\api-backend.json`.
- Sử dụng tài liệu này (có thể mở trực tiếp hoặc import vào Apidog/Postman) để xác nhận chính xác các Endpoints, Parameters, Request Body, và cấu trúc Response Models nhằm đảm bảo đồng bộ hoàn toàn giữa ứng dụng và máy chủ.
