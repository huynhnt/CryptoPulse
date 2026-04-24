## Bối cảnh (Context)

Màn hình chi tiết đồng coin hiện tại (`CoinDetailScreen`) đang được triển khai dưới dạng `StatelessWidget`. Dữ liệu biểu đồ (`sparkline`) được vẽ bằng thư viện `fl_chart` nhưng chưa cấu hình các chức năng tương tác nâng cao. Để đáp ứng yêu cầu về một biểu đồ "Premium" có khả năng cập nhật Header động và phản hồi xúc giác, chúng ta cần một cơ chế quản lý trạng thái tại chỗ mạnh mẽ hơn.

### 5. Ổn định giao diện (Layout Stability)
- **Vấn đề**: Việc thêm/bớt các dòng văn bản (như dòng thời gian khi hover) làm thay đổi chiều cao của Header, gây hiện tượng nhảy (jerkiness) cho biểu đồ bên dưới.
- **Giải pháp**: Luôn dự phòng một khoảng trống cố định cho dòng thời gian. Khi không hover, dòng này sẽ được để trống hoặc ẩn đi nhưng vẫn giữ nguyên diện tích chiếm chỗ trong Layout.

## Mục tiêu (Goals / Non-Goals)

**Mục tiêu:**
- Chuyển đổi màn hình chi tiết sang cơ chế quản lý trạng thái phản hồi nhanh (Stateful).
- Triển khai tương tác chạm (touch interaction) mượt mà với đường cắt (crosshair) chỉ định điểm dữ liệu.
- Đồng bộ hóa dữ liệu biểu đồ với phần hiển thị giá và thời gian trên Header.
- Tích hợp phản hồi rung khi người dùng di chuyển tay trên biểu đồ.

**Ngoài mục tiêu (Non-Goals):**
- Không thay đổi cấu trúc Theme hoặc phối màu tổng thể của ứng dụng.
- Không triển khai các tính năng giao tiếp backend phức tạp trong giai đoạn này (tập trung vào trải nghiệm UI/UX).

## Quyết định kỹ thuật (Decisions)

### 1. Quản lý trạng thái tại màn hình (Local State Management)
- **Quyết định**: Sử dụng `ConsumerStatefulWidget` thay vì `StatelessWidget`.
- **Lý do**: Việc cập nhật Header liên tục khi người dùng vuốt trên biểu đồ yêu cầu tần suất rebuild cao. Việc sử dụng `setState` cục bộ sẽ tối ưu hơn về mặt hiệu suất so với việc đẩy trạng thái lên Global Provider cho các tương tác mang tính "live" như thế này.

### 2. Tương tác và Lưới biểu đồ (Interaction & Grid)
- **Quyết định**: Sử dụng thuộc tính `lineTouchData` và `gridData`.
- **Chi tiết**: 
    - Cấu hình `touchCallback` để xử lý Header động và Crosshair.
    - Kích hoạt `drawHorizontalLine: true` trong `gridData` với kiểu hiển thị nét đứt (dashed line) màu mờ để hỗ trợ theo dõi mức giá đối chiếu mà không gây rối mắt.
    - Vô hiệu hóa `drawVerticalLine` để giữ phong cách tối giản.

### 3. Phản hồi xúc giác (Haptic Feedback)
- **Quyết định**: Tích hợp `HapticFeedback.selectionClick()` từ `package:flutter/services.dart`.
- **Lý do**: Đây là chuẩn UX cho các biểu đồ tài chính cao cấp, tạo cảm giác "cơ học" khi tay người dùng lướt qua các mốc dữ liệu quan trọng.

### 4. Xử lý khung thời gian (Timeframe Logic)
- **Quyết định**: Sử dụng API `market_chart` của CoinGecko thay vì giả lập.
- **Vị trí**: Chuyển `TimeframeSelector` xuống dưới biểu đồ.
- **Phân đoạn**: 1H, 24H, 7D, 1M, 1Y với cách hiển thị nhãn thời gian tương ứng.

### 5. Cải thiện UX & Interaction
- **Tooltip**: Loại bỏ tooltip, hiển thị giá trên Header.
- **Auto-reset**: Giá Header quay về hiện tại khi rời tay khỏi biểu đồ.
- **Dynamic Stats**: Trị giá Cao/Thấp tính toán từ dữ liệu đang hiển thị.
- **Layout Stability**: Giữ khoảng trống cố định cho dòng thời gian để tránh nhảy biểu đồ.

### 6. Định dạng dữ liệu (Data Formatting)
- **Số lượng (Supplies/Volume)**: Sử dụng định dạng phân cách hàng nghìn. Luôn kèm theo ký hiệu Symbol (viết hoa) ở sau giá trị.
- **Giá tiền**: Giữ nguyên định dạng tiền tệ. Áp dụng **Smart Formatting**: Tự động tăng số chữ số thập phân cho các đồng coin có giá trị thấp (< $1) để đảm bảo không bị hiển thị về 0.
- **Trục dọc (Y-axis)**: Hiển thị nhãn giá rút gọn (Compact Formatting) và kèm đơn vị tiền tệ.
    - Ví dụ: `$1.2K` thay vì `$1,200`, `$2.5M` thay vì `$2,500,000`.
    - Đảm bảo độ rộng của cột nhãn (`reservedSize`) được tối ưu hóa sau khi rút gọn.
- **Mật độ lưới**: Khoảng cách đường lưới ngang (`interval`) được tính toán động để chia biểu đồ thành tối đa 5 phần bằng nhau.

## Rủi ro và Đánh giá (Risks / Trade-offs)

- **[Rủi ro] Rate Limit API** → **Giải pháp**: Tích hợp loading indicator.
- **[Rủi ro] Hiệu suất khi Rebuild quá nhanh** → **Giải pháp**: Chỉ gọi `setState` khi `index` thay đổi.
