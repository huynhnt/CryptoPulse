## 1. Network & Service Layer

- [x] 1.1 Thêm endpoint tìm kiếm vào `ApiService` (hoặc module tương đương) để gọi API `/coins/search?q={keyword}`.
- [x] 1.2 Tạo hoặc cập nhật Data Model `Coin` (nếu cần) để đảm bảo mapping đúng dữ liệu trả về từ API search.

## 2. State Management

- [x] 2.1 Cập nhật Provider/Cubit để quản lý các trạng thái: `searchQuery`, `isSearching`, `searchLoading`, `searchResults`, và `searchError`.
- [x] 2.2 Tích hợp logic **Debounce 300ms** vào hàm bắt sự kiện thay đổi từ khóa tìm kiếm (onSearchChanged).

## 3. User Interface (UI)

- [x] 3.1 Bổ sung widget `TextField` hoặc thanh tìm kiếm (Search Bar) ở trang All Coins.
- [x] 3.2 Xử lý hiển thị `CircularProgressIndicator` khi trạng thái là `searchLoading`.
- [x] 3.3 Thay đổi logic render danh sách: nếu `searchQuery` trống, hiển thị danh sách All Coins ban đầu; nếu có `searchQuery`, hiển thị danh sách `searchResults`.
- [x] 3.4 Sử dụng `CoinListItem` để hiển thị danh sách kết quả tìm kiếm.
- [x] 3.5 Hiển thị thông báo "Không tìm thấy kết quả" khi `searchResults` rỗng (nhưng `searchQuery` có dữ liệu và không loading).

## 4. Kiểm thử và Tối ưu

- [x] 4.1 Chạy thử nghiệm gõ phím nhanh để xác nhận tính năng debounce hoạt động đúng (chỉ gọi 1 request sau 300ms).
- [x] 4.2 Kiểm tra UI render đúng (Icon, sparkline, percent change) trên `CoinListItem` trong lúc hiển thị kết quả tìm kiếm.
- [x] 4.3 Đảm bảo hành vi khi xóa trắng thanh tìm kiếm trả về danh sách ban đầu ngay lập tức mà không bị chớp giật.
