## Lý do (Why)

Màn hình chi tiết đồng coin hiện tại đang là một biểu đồ tĩnh, thiếu đi sự tương tác chuyên sâu cần thiết cho một ứng dụng tiền điện tử cao cấp. Người dùng có nhu cầu theo dõi chính xác mức giá tại một thời điểm cụ thể, chuyển đổi linh hoạt giữa các khung thời gian và nhận được phản hồi xúc giác (vibration) khi tương tác, tương tự như các nền tảng hàng đầu (ví dụ: CoinGecko). Việc nâng cấp này sẽ biến màn hình chi tiết từ một chế độ xem đơn giản thành một công cụ phân tích thị trường mạnh mẽ.

## Các thay đổi (What Changes)

- **Tâm điểm tương tác (Interactive Crosshair)**: Triển khai đường cắt phản hồi khi chạm trên `LineChart` để hiển thị chính xác giá và thời gian tại điểm đó.
- **Header động (Dynamic Header Overlay)**: Giá và thời gian ở phần đầu màn hình sẽ cập nhật liên tục theo điểm mà người dùng đang chạm trên biểu đồ.
- **Phản hồi xúc giác (Haptic Feedback)**: Tích hợp hiệu ứng rung nhẹ (light impacts) đồng bộ với việc chọn điểm trên biểu đồ khi người dùng vuốt qua các mốc dữ liệu.
- **Bộ chọn khung thời gian (Timeframe Selector)**: Thêm thanh điều hướng cho phép người dùng chuyển đổi các khung hình (1H, 24H, 7D, 1M, 1Y).
- **Nhãn trục ngang (Enhanced Axis Labels)**: Hiển thị ngày/giờ cụ thể ở trục dưới biểu đồ để cung cấp ngữ cảnh thời gian rõ ràng hơn.
- **Định dạng dữ liệu (Data Formatting)**: Chuẩn hóa định dạng giá (tiền tệ, số thập phân) và mốc thời gian (định dạng địa phương) khi tương tác.

## Khả năng (Capabilities)

### Khả năng mới (New Capabilities)
- `premium-chart-interaction`: Logic cốt lõi cho việc dò điểm, hiển thị crosshair và đồng bộ phản hồi xúc giác.
- `market-data-timeframes`: Khả năng tải và hiển thị dữ liệu lịch sử coin cho các khoảng thời gian khác nhau (1H đến 1Y).

### Khả năng thay đổi (Modified Capabilities)
- `dashboard`: Cập nhật logic điều hướng và quản lý trạng thái của màn hình chi tiết để hỗ trợ cập nhật dữ liệu động.

## Ảnh hưởng (Impact)

- **UI Layer**: Chuyển đổi `CoinDetailScreen` từ `StatelessWidget` sang `ConsumerStatefulWidget` để quản lý trạng thái tương tác.
- **Logic biểu đồ**: Cấu hình phức tạp hơn cho `LineTouchData` và `axisTitles` của `fl_chart`.
- **Data Layer**: Mở rộng `CoinRepository` để hỗ trợ fetch dữ liệu theo các khoảng thời gian khác nhau.
- **Services**: Tích hợp thêm `HapticFeedback` từ Flutter Services.
