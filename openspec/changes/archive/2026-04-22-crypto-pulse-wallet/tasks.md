## 1. Foundation & Skill Execution

- [x] 1.1 Sử dụng Skill `flutter-clean-feature` để khởi tạo thư mục `lib/features/wallet`.
- [x] 1.2 Tạo Entity `WalletAccount` và `Transaction` trong lớp Domain.
- [x] 1.3 Định nghĩa `WalletRepository` interface.

## 2. Model & Data Source

- [x] 2.1 Triển khai `WalletModel` với hỗ trợ JSON mapping.
- [x] 2.2 Triển khai `WalletRepositoryImpl` với dữ liệu mock và lưu trữ local (`shared_preferences`).

## 3. State Management (Riverpod)

- [x] 3.1 Tạo `WalletProvider` để quản lý số dư và danh sách giao dịch.
- [x] 3.2 Viết logic cho các function xử lý nạp/rút tiền.

## 4. UI Implementation (Premium Style)

- [x] 4.1 Xây dựng `WalletScreen` với hiệu ứng FadeInSlide.
- [x] 4.2 Thiết kế `WalletCard` phong cách Glassmorphism.
- [x] 4.3 Xây dựng `TransactionHistoryList` với các icon phân loại trực quan.
- [x] 4.4 Tích hợp điều hướng từ Dashboard sang Wallet Hub.
