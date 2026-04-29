## Why

Người dùng cần có khả năng xem toàn bộ danh sách các đồng coin thay vì chỉ hiển thị một số lượng giới hạn trên màn hình "Market Highlights". Việc hỗ trợ xem tất cả các đồng coin giúp ứng dụng cung cấp đủ thông tin thị trường. Đồng thời, áp dụng cơ chế cuộn vô hạn (infinite scroll) sẽ giúp người dùng duyệt danh sách mượt mà, không làm nặng ứng dụng khi tải nhiều dữ liệu cùng lúc.

## What Changes

- Thêm action (nút bấm hoặc text "See all") ở màn hình chính bên cạnh tiêu đề "Market Highlights".
- Tạo một màn hình (Screen) mới để hiển thị toàn bộ danh sách coin.
- Tích hợp cơ chế cuộn vô hạn (Infinite Scroll) trong màn hình mới để tự động tải thêm dữ liệu khi người dùng cuộn đến cuối danh sách.
- Tích hợp gọi API Backend lấy danh sách coin, cập nhật logic gọi với tham số `per_page=50` và biến `page` tăng dần.

## Capabilities

### New Capabilities
- `coin-list-infinite-scroll`: Khả năng hiển thị danh sách tất cả đồng coin với cơ chế cuộn vô hạn (Infinite scroll), tự động phân trang khi gọi API.

### Modified Capabilities


## Impact

- **UI/Components**: Cập nhật trang `HomeScreen` (thêm nút See all), tạo trang mới `AllCoinsScreen` hoặc tương tự.
- **State Management**: Cần quản lý state danh sách coin đã load (tích lũy), số trang hiện tại `page`, cờ `hasReachedMax` và `isLoadingMore`.
- **API Client**: Service gọi API backend sẽ cần hỗ trợ truyền `page` và `per_page`.
