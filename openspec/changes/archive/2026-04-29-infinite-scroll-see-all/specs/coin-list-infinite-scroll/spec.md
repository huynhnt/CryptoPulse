## ADDED Requirements

### Requirement: Hiển thị tuỳ chọn See All trên màn hình chính
Giao diện màn hình chính SHALL hiển thị tuỳ chọn "See all" cạnh tiêu đề "Market Highlights" cho phép người dùng mở trang danh sách đầy đủ.

#### Scenario: Nhấn nút See All
- **WHEN** người dùng nhấn vào nút "See all"
- **THEN** ứng dụng chuyển sang màn hình hiển thị toàn bộ coin (ví dụ: AllCoinsScreen).

### Requirement: Tự động phân trang với Infinite Scroll
Màn hình danh sách toàn bộ coin SHALL thực hiện việc gọi API trang tiếp theo khi người dùng cuộn đến phần tử gần cuối của danh sách hiện tại.

#### Scenario: Cuộn xuống cuối trang đầu tiên
- **WHEN** người dùng cuộn đến gần cuối danh sách gồm 50 coin đầu tiên
- **THEN** ứng dụng gọi API lấy danh sách với tham số `page=2` và `per_page=50`
- **AND** hiển thị chỉ báo tải (loading indicator) ở dưới cùng trong quá trình đợi dữ liệu.

### Requirement: Gộp dữ liệu phân trang
Danh sách hiển thị trên giao diện SHALL tiếp tục nối thêm các coin mới vào sau các coin hiện có mà không làm tải lại (reload) toàn bộ danh sách.

#### Scenario: Nhận dữ liệu trang tiếp theo thành công
- **WHEN** API trả về danh sách coin của trang tiếp theo
- **THEN** ứng dụng thêm các coin mới này vào đuôi của danh sách hiện có
- **AND** ẩn chỉ báo tải (loading indicator)
- **AND** giữ nguyên vị trí cuộn hiện tại của người dùng.

### Requirement: Quản lý trạng thái kết thúc dữ liệu
Hệ thống SHALL dừng việc gửi yêu cầu API mới nếu trang cuối cùng trả về ít hơn 50 phần tử.

#### Scenario: Tải hết toàn bộ dữ liệu
- **WHEN** API trả về một mảng có số lượng phần tử nhỏ hơn 50
- **THEN** ứng dụng không kích hoạt gọi API thêm khi người dùng tiếp tục cuộn
- **AND** ẩn chỉ báo tải vĩnh viễn ở phần cuối danh sách.
