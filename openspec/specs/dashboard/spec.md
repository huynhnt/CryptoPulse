# Specification: Real-time Crypto Dashboard

## Objective
Cung cấp cho người dùng cái nhìn tổng quan về thị trường tiền điện tử và giá trị tài sản cá nhân trong thời gian thực với trải nghiệm UI cao cấp.

## Functional Requirements
- **Price Tracking**: Phải hiển thị ít nhất 20 đồng coin đứng đầu thị trường.
- **Real-time Data**: Dữ liệu giá, logo và biến động 24h phải được lấy từ API (CoinGecko).
- **Interactive UI**:
  - Có thể làm mới dữ liệu bằng nút Refresh hoặc kéo để tải lại.
  - Mỗi đồng coin phải hiển thị biểu đồ xu hướng (Sparkline) trong 7 ngày qua.
- **Navigation**: Nhấn vào một đồng coin sẽ mở ra màn hình chi tiết tương ứng.

## Technical Requirements
- **Architecture**: Phải tuân thủ Clean Architecture.
- **State Management**: Sử dụng `flutter_riverpod` để quản lý luồng dữ liệu.
- **Network**: Sử dụng `Dio` với cơ chế xử lý lỗi và timeout.
- **Visuals**: Phải sử dụng bộ màu Dark Theme đã định nghĩa trong `AppColors`.

## UX Constraints
- **Animation**: Mọi thành phần khi xuất hiện phải có hiệu ứng mờ dần và trượt lên.
- **Continuity**: Chuyển cảnh giữa các màn hình phải sử dụng Hero Animation cho Logo.

## ADDED Requirements

### Requirement: Màn hình chi tiết Coin có tính tương tác cao
Màn hình chi tiết đồng coin PHẢI hỗ trợ tương tác động với biểu đồ, cho phép xem giá trị tại thời điểm cụ thể và tích hợp phản hồi xúc giác.

#### Scenario: Truy cập màn hình chi tiết tương tác
- **WHEN** Người dùng nhấn vào một đồng coin từ Dashboard
- **THEN** Màn hình chi tiết mở ra với biểu đồ có khả năng tương tác (vuốt để xem giá) và bộ chọn khung thời gian.
