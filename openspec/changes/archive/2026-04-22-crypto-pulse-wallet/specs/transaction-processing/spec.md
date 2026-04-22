## ADDED Requirements

### Requirement: Mock Transaction Flow
Người dùng có thể thực hiện giao dịch nạp tiền hoặc chuyển tiền giả lập để thay đổi số dư trong app.

#### Scenario: Succesful Deposit
- **WHEN** Người dùng nhập số tiền và nhấn "Confirm Deposit".
- **THEN** Số dư ví tăng lên tương ứng và một bản ghi mới xuất hiện trong Transaction History.

### Requirement: Transaction History Persistence
Toàn bộ lịch sử giao dịch phải được lưu trữ cục bộ để người dùng có thể xem lại sau khi khởi động lại app.

#### Scenario: View Past Transactions
- **WHEN** Người dùng cuộn xuống phần History.
- **THEN** Hệ thống hiển thị danh sách các giao dịch sắp xếp theo thời gian mới nhất lên đầu.
