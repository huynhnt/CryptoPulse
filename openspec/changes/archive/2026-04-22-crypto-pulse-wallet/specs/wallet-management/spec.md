## ADDED Requirements

### Requirement: Wallet Summary Display
Màn hình ví phải hiển thị tổng cộng tài sản (Total Balance) được tính bằng USD và danh sách các loại ví (Spot, Funding).

#### Scenario: View Wallet Balance
- **WHEN** Người dùng mở màn hình Wallet Hub.
- **THEN** Hệ thống hiển thị số dư tổng cộng và chi tiết từng loại ví với hiệu ứng FadeIn.

### Requirement: Account Distribution
Hệ thống phải hiển thị tỷ lệ phân bổ tài sản theo từng loại coin trong ví.

#### Scenario: Visual Distribution Graph
- **WHEN** Người dùng xem chi tiết ví.
- **THEN** Hệ thống hiển thị một biểu đồ tròn (Pie Chart) thể hiện tỷ lệ phần trăm giữa các đồng coin.
