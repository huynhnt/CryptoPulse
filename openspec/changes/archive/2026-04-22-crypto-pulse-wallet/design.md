## Context

Ứng dụng hiện tại đã có Dashboard theo dõi giá và màn hình chi tiết. Chúng ta cần mở rộng thêm khả năng quản lý tài chính cá nhân thông qua Wallet Hub.

## Goals / Non-Goals

**Goals:**
- Tạo giao diện ví chuyên nghiệp với hiệu ứng Glassmorphism.
- Thiết lập hệ thống State Management bằng Riverpod cho số dư và giao dịch.
- Xây dựng workflow cho các giao dịch Nạp/Rút giả lập.
- Tự động hóa việc tạo folder bằng Skill `flutter-clean-feature`.

**Non-Goals:**
- Chưa kết nối với các ví thực tế (MetaMask, TrustWallet) trong giai đoạn này.
- Chưa thực hiện xác thực sinh trắc học (FaceID/Fingerprint).

## Decisions

- **Architecture**: Sử dụng chuẩn Clean Architecture với các lớp phân tách rõ ràng.
- **UI System**:
    - **Wallet Card**: Sử dụng Gradient tương phản mạnh (Gold/Silver) để phân biệt các loại ví.
    - **Transaction List**: Hiển thị đơn giản với icon phân loại (In/Out).
- **State Management**: Sử dụng `StateNotifierProvider` để quản lý danh sách giao dịch vì dữ liệu này có thể thay đổi thường xuyên.
- **Navigation**: Sử dụng Bottom Navigation Bar hoặc một nút nổi (Floating Action Button) trên Dashboard để truy cập nhanh vào Wallet.

## Risks / Trade-offs

- **Risk**: Mock dữ liệu có thể không phản ánh đúng độ trễ của mạng thực tế. 
- **Trade-off**: Sử dụng `shared_preferences` để lưu lịch sử giao dịch offline thay vì một database phức tạp (như SQLite) để giữ ứng dụng gọn nhẹ.
