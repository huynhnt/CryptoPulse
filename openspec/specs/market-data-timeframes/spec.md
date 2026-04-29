## ADDED Requirements

### Requirement: Bộ chọn khung thời gian linh hoạt
Hệ thống PHẢI cung cấp giao diện cho phép người dùng chọn các khung thời gian: 1H (1 giờ), 24H (24 giờ), 7D (7 ngày), 1M (1 tháng), 1Y (1 năm).

#### Scenario: Chuyển đổi khung thời gian
- **WHEN** Người dùng nhấn vào nút "24H" trên thanh điều hướng khung thời gian
- **THEN** Biểu đồ PHẢI được vẽ lại chỉ với dữ liệu của 24 giờ gần nhất, và nhãn trục ngang PHẢI cập nhật định dạng hiển thị giờ (ví dụ: 14:00, 16:00).

### Requirement: Định dạng nhãn trục ngang (Bottom Axis Labels)
Hệ thống PHẢI hiển thị các nhãn thời gian ở trục ngang dựa trên khung thời gian đang chọn để người dùng dễ dàng định vị mốc thời gian.

#### Scenario: Hiển thị ngày cho khung 7D
- **WHEN** Khung thời gian đang chọn là 7D
- **THEN** Trục ngang PHẢI hiển thị ít nhất 5-7 mốc ngày (ví dụ: Thứ 2, Thứ 3 hoặc 18 Apr, 19 Apr) cách đều nhau.
