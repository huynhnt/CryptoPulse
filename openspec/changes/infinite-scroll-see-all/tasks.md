## 1. Thiết lập UI cơ bản và Điều hướng

- [x] 1.1 Thêm nút/text "See all" vào màn hình Home, ngay cạnh tiêu đề "Market Highlights".
- [x] 1.2 Khởi tạo cấu trúc file và widget cho màn hình mới `AllCoinsScreen` (bao gồm AppBar đơn giản).
- [x] 1.3 Cấu hình điều hướng (Navigation/Router) để chuyển từ màn hình Home sang `AllCoinsScreen` khi nhấn nút "See all".

## 2. Cập nhật Repository / API

- [x] 2.1 Cập nhật interface và logic của `CoinRepository` (hoặc Service tương ứng) để nhận tham số `page` và `per_page` khi lấy danh sách coin.
- [x] 2.2 Đảm bảo mã gọi API sử dụng `per_page=50` cho màn hình AllCoins, và `per_page=10` (hoặc tuỳ chỉnh) cho widget Market Highlights trên Home.

## 3. State Management (Controller/Provider)

- [x] 3.1 Tạo state cho All Coins (ví dụ `AllCoinsState`) chứa `List<Coin> coins`, `int page`, `bool isLoadingMore`, và `bool hasReachedMax`.
- [x] 3.2 Tạo Controller (ví dụ `AllCoinsController`) quản lý state.
- [x] 3.3 Viết hàm `fetchInitialCoins()` để lấy 50 đồng coin đầu tiên (page=1).
- [x] 3.4 Viết hàm `fetchNextPage()` để lấy trang dữ liệu kế tiếp (page++). Xử lý nối mảng dữ liệu, lọc trùng lặp ID (nếu có), ẩn/hiện loading, và đặt `hasReachedMax = true` nếu kết quả trả về nhỏ hơn 50 phần tử.

## 4. Giao diện Cuộn Vô Hạn (Infinite Scroll)

- [x] 4.1 Xây dựng `ListView.builder` (hoặc Sliver) trong `AllCoinsScreen` kết nối với `AllCoinsState` để render danh sách coin.
- [x] 4.2 Khởi tạo và gắn `ScrollController` vào danh sách, lắng nghe sự kiện cuộn xuống cách đáy danh sách một khoảng nhất định (ví dụ 200px).
- [x] 4.3 Gọi hàm `fetchNextPage()` khi bắt được sự kiện cuộn ở bước 4.2.
- [x] 4.4 Hiển thị `CircularProgressIndicator` (hoặc widget loading thân thiện) ở phần tử cuối cùng của danh sách nếu `isLoadingMore` đang bật.

## 5. Hoàn thiện Bottom Navigation Bar

- [x] 5.1 Cập nhật `MainScreen` để nhận tham số `initialIndex` phục vụ việc chuyển đổi tab linh hoạt.
- [x] 5.2 Xử lý sự kiện `onTap` trên Bottom Navigation Bar của `AllCoinsScreen` sử dụng `Navigator.pushAndRemoveUntil` để điều hướng về `MainScreen` với index tương ứng, thay vì dùng `Navigator.pop`.
