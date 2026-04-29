## Why

Tính năng tìm kiếm là một trong những tính năng thiết yếu giúp người dùng nhanh chóng tiếp cận dữ liệu của một đồng tiền điện tử mà họ quan tâm. Hiện tại trang "All Coins" mới chỉ hỗ trợ hiển thị danh sách coin tĩnh. Việc bổ sung một thanh tìm kiếm với khả năng "real-time" (hiển thị kết quả ngay khi người dùng gõ từ khóa) là vô cùng cần thiết, mang lại trải nghiệm người dùng hiện đại, tiết kiệm thời gian và nâng tầm ứng dụng lên tiêu chuẩn chuyên nghiệp.

## What Changes

- Thêm giao diện TextField tìm kiếm vào phía trên danh sách của trang All Coins (hoặc trên AppBar).
- Triển khai cơ chế **Debounce 300ms** khi gõ từ khóa để hạn chế việc gọi API liên tục không cần thiết, giúp tiết kiệm tài nguyên mạng và tăng hiệu năng ứng dụng.
- Tích hợp gọi API `/coins/search?q={keyword}` mà Backend đã hỗ trợ.
- Hiển thị danh sách kết quả tìm kiếm ngay bên dưới ô tìm kiếm, **tái sử dụng hoàn toàn widget `CoinListItem`** hiện có để đảm bảo tính đồng nhất về giao diện (bao gồm các dữ liệu như icon, giá hiện tại, phần trăm thay đổi, và biểu đồ mini).

## Capabilities

### New Capabilities
- `real-time-search`: Tính năng tìm kiếm coin real-time bao gồm cả logic UI (TextField, Debounce) và tích hợp API tìm kiếm.

### Modified Capabilities
<!-- No modified capabilities needed as this is a new sub-feature attached to the existing All Coins screen without modifying its core requirements. -->

## Impact

- **UI**: Thay đổi cấu trúc màn hình All Coins để chứa thêm khu vực tìm kiếm và kết quả.
- **State Management**: Cần quản lý state cho trạng thái đang tìm kiếm (isLoading), danh sách kết quả tìm kiếm, và giá trị từ khóa tìm kiếm (keyword).
- **Network**: Thêm mới request gọi tới endpoint `/coins/search?q={keyword}`.
- **Code Reusability**: Tận dụng tối đa component `CoinListItem` đã được xây dựng trước đó.
