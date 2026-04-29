## ADDED Requirements

### Requirement: Tương tác chạm và hiển thị Crosshair
Hệ thống PHẢI hiển thị một đường cắt dọc (crosshair) tại điểm dữ liệu gần vị trí chạm nhất khi người dùng nhấn và giữ (long press) hoặc vuốt trên biểu đồ giá.

#### Scenario: Người dùng nhấn vào biểu đồ
- **WHEN** Người dùng chạm và giữ vào một vị trí bất kỳ trên biểu đồ LineChart
- **THEN** Hệ thống hiển thị một đường thẳng đứng màu trắng mờ (opacity 0.2) đi qua điểm dữ liệu gần nhất và làm nổi bật (highlight) điểm đó.

### Requirement: Cập nhật Header động theo dữ liệu biểu đồ
Hệ thống PHẢI thay đổi nội dung phần Header (Giá và Thời gian) để khớp với giá trị của điểm dữ liệu đang được người dùng chạm vào trên biểu đồ. Hệ thống KHÔNG ĐƯỢC hiển thị tooltip nổi trên chart để tránh che khuất dữ liệu. Khi người dùng buông tay hoặc di chuyển con trỏ ra khỏi vùng biểu đồ, Header PHẢI quay lại hiển thị giá trị hiện tại của đồng coin. 

**Đặc biệt**: Việc ẩn hoặc hiện dòng thời gian trong Header PHẢI KHÔNG làm thay đổi vị trí hoặc kích thước của widget biểu đồ (Không gây nhảy Layout).

#### Scenario: Cập nhật thông tin khi vuốt biểu đồ
- **WHEN** Người dùng vuốt ngón tay qua lại trên biểu đồ
- **THEN** Phần text giá chính (Primary Price) PHẢI cập nhật theo giá tại điểm chạm, đồng thời hiển thị thêm dòng thời gian cụ thể (ví dụ: 20/04/2026 14:00) ngay bên dưới giá.

### Requirement: Phản hồi rung khi lướt qua các mốc dữ liệu
Hệ thống PHẢI kích hoạt một xung rung nhẹ (Haptic Feedback) mỗi khi tiêu điểm tương tác chuyển đổi từ một điểm dữ liệu sang điểm dữ liệu kế tiếp.

#### Scenario: Phản hồi khi di chuyển tiêu điểm
- **WHEN** Tiêu điểm tương tác nhảy từ index i sang index i+1 trong mảng dữ liệu chart
- **THEN** Thiết bị PHẢI rung nhẹ (Haptic selection click) để phản hồi cho người dùng.
