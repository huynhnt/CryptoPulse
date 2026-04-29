## 1. Chuẩn bị và Refactor cơ bản

- [x] 1.1 Chuyển đổi `CoinDetailScreen` từ `StatelessWidget` sang `ConsumerStatefulWidget`.
- [x] 1.2 Khai báo các trạng thái cục bộ: `hoveredPrice`, `hoveredDate` và `selectedTimeframe`.
- [x] 1.3 Import thư viện `package:flutter/services.dart` để sử dụng HapticFeedback.

## 2. Logic tương tác biểu đồ (Chart Interaction)

- [x] 2.1 Cấu hình `LineTouchData` cho `LineChart` để bật tính năng cảm ứng.
- [x] 2.2 Triển khai `touchCallback` để bắt index điểm dữ liệu khi người dùng chạm vào biểu đồ.
- [x] 2.3 Xây dựng logic chuyển đổi từ index sang mốc thời gian (DateTime) dựa trên khung thời gian đang chọn.
- [x] 2.4 Cập nhật `hoveredPrice` và `hoveredDate` trong `setState` khi di chuyển tiêu điểm.

## 3. Header động và Phản hồi xúc giác

- [x] 3.1 Cập nhật Widget hiển thị giá để ưu tiên hiển thị `hoveredPrice` nếu đang tương tác.
- [x] 3.2 Thêm Widget hiển thị thời gian (`Text`) ngay dưới giá, cập nhật theo `hoveredDate`.
- [x] 3.3 Gọi `HapticFeedback.selectionClick()` trong callback tương tác khi phát hiện index thay đổi.

## 4. Bộ chọn khung thời gian và Nhãn trục

- [x] 4.1 Xây dựng Widget `TimeframeSelector` với các nút 1H, 24H, 7D, 1M, 1Y.
- [x] 4.2 Cấu hình `titlesData` (trục ngang) để hiển thị mốc ngày/giờ chuẩn xác và thẩm mỹ.
- [x] 4.3 Cấu hình `titlesData` (trục ngang) hiển thị HH:mm hoặc dd/MM tùy khung thời gian.

## 5. Tinh chỉnh UX & Dữ liệu thực tế (Refinement)

- [x] 5.1 Loại bỏ Tooltip nổi trên biểu đồ và thay bằng hệ thống Crosshair + Header động.
- [x] 5.2 Implement logic tự động reset giá Header về giá hiện tại khi kết thúc tương tác hoặc rời con trỏ.
- [x] 5.3 Di chuyển `TimeframeSelector` xuống dưới biểu đồ để tối ưu layout.
- [x] 5.4 Nâng cấp `CoinRepository` để fetch dữ liệu thật từ API `market_chart` thay vì dùng sparkline tĩnh.
- [x] 5.5 Cập nhật các hàng thông số (Stat Rows) Cao nhất/Thấp nhất động theo dữ liệu đang hiển thị trên chart.
- [x] 5.6 Fix lỗi "nhảy" biểu đồ khi hover: Đảm bảo dòng thời gian luôn chiếm một khoảng trống cố định (sử dụng Visibility hoặc Opacity).
- [x] 5.7 Định dạng số cho "Tổng cung": Sử dụng NumberFormat phân cách hàng nghìn và thêm đơn vị (Symbol) viết hoa.
- [x] 5.8 Hiển thị đường lưới ngang (Horizontal Grid Lines) dạng nét đứt (dashed) mờ để hỗ trợ đối chiếu giá.
- [x] 5.9 Triển khai Smart Price Formatting: Hiển thị nhiều số thập phân hơn cho coin giá trị thấp.
- [x] 5.10 Kích hoạt Nhãn trục dọc (Left Titles) để cung cấp mốc giá đối chiếu cho đường lưới.
- [x] 5.11 Tối ưu mật độ lưới: Cấu hình `interval` để chỉ hiển thị từ 3-5 vùng giá đối chiếu trên trục dọc.
- [x] 5.12 Định dạng nhãn trục dọc rút gọn (Compact Formatting): Thêm ký hiệu `$`, rút gọn hàng nghìn thành `K` và triệu thành `M`.
