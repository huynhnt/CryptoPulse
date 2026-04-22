## Why

Người dùng cần một trung tâm quản lý tài sản (Wallet Hub) để theo dõi số dư, thực hiện các giao dịch cơ bản như nạp tiền, chuyển tiền và xem lịch sử giao dịch. Việc này giúp CryptoPulse chuyển mình từ một ứng dụng theo dõi giá thuần túy thành một hệ sinh thái quản lý tài sản số toàn diện.

## What Changes

Chúng ta sẽ thêm một phân vùng mới "Wallet Hub" vào ứng dụng, bao gồm:
- Giao diện quản lý ví với số dư chi tiết.
- Các chức năng tương tác: Nạp tiền (Deposit), Rút tiền (Withdraw), Chuyển khoản (Transfer).
- Danh sách lịch sử giao dịch gần đây.
- Tích hợp vào thanh điều hướng hoặc Dashboard chính.

## Capabilities

### New Capabilities
- `wallet-management`: Quản lý các tài khoản ví và số dư khả dụng.
- `transaction-processing`: Xử lý logic cho các giao dịch nạp/rút và lưu trữ lịch sử.

### Modified Capabilities
- `dashboard`: Dashboard sẽ được cập nhật để hiển thị tóm tắt thông tin ví (Wallet Summary) ngay cạnh biểu đồ giá.

## Impact

- **UI**: Thêm màn hình `WalletScreen` và các widget giao dịch.
- **State**: Thêm `WalletProvider` để quản lý số dư và lịch sử.
- **Data**: Mock API service cho các giao dịch và lưu trữ local cho lịch sử giao dịch.
