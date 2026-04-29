## Context

Dự án Frontend CryptoPulse hiện đang có trang "All Coins" hiển thị danh sách các coin (thường là top market cap). Backend đã triển khai thành công API `/coins/search?q={keyword}` (trả về danh sách `Coin`). Để hoàn thiện tính năng, Frontend cần có thanh tìm kiếm cho phép người dùng gõ từ khóa. Yêu cầu quan trọng là phải có kỹ thuật "Debounce" để giảm thiểu số lượng API calls liên tục, và tận dụng triệt để widget `CoinListItem` đã có để giữ giao diện thống nhất.

## Goals / Non-Goals

**Goals:**
- Tích hợp ô nhập liệu (Search Bar) tại trang All Coins.
- Gọi API backend (sử dụng package `http` hoặc `dio` có sẵn trong dự án) khi từ khóa thay đổi với thời gian chờ (debounce) 300ms.
- Tự động hiển thị kết quả hoặc hiển thị lại danh sách gốc khi từ khóa rỗng.
- Hiển thị loading state (CircularProgressIndicator) khi đang chờ kết quả.
- Tái sử dụng widget `CoinListItem` để hiển thị danh sách kết quả.

**Non-Goals:**
- Không thay đổi thiết kế cốt lõi của ứng dụng (Bottom Nav Bar, App Bar hiện tại).
- Không thực hiện tính năng phân trang (Pagination) cho danh sách kết quả tìm kiếm (Backend đang giới hạn trả về top 10).

## Decisions

**Decision 1: Áp dụng cơ chế Debounce 300ms**
- **Tại sao?** Khi người dùng gõ phím nhanh, mỗi ký tự thay đổi sẽ tạo ra một sự kiện. Việc trì hoãn 300ms trước khi thực hiện logic tìm kiếm giúp tránh spam request lên server, giảm thiểu băng thông và tiết kiệm chi phí.
- **Cách làm:** Sử dụng `Timer` từ dart `dart:async` hoặc thông qua package `rxdart` (nếu đang dùng Bloc/Cubit) hoặc một mixin đơn giản. Ở đây, một Timer có thể tự cancel và khởi tạo lại là giải pháp nhẹ và đủ tốt nếu dùng Provider/StatefulWidget. Do dự án có thể đang dùng Bloc/Cubit (theo chuẩn Clean Architecture), sẽ cân nhắc sử dụng transformer `debounceTime` của rxdart hoặc debounce của bloc_concurrency.

**Decision 2: UI State Management**
- Quản lý các trạng thái: `initial` (chưa tìm kiếm), `loading` (đang gọi API), `success` (có dữ liệu kết quả), `empty` (không tìm thấy), `error` (lỗi).
- Widget chính sẽ kiểm tra nếu ô tìm kiếm rỗng thì hiển thị list "All Coins" mặc định, nếu có chữ thì chuyển sang hiển thị list kết quả từ API `/coins/search`.

**Decision 3: Tái sử dụng `CoinListItem`**
- Do kết quả Backend trả về cùng chung mô hình `Coin` với danh sách All Coins (có đủ giá, phần trăm, và sparkline), việc ánh xạ trực tiếp và dùng `ListView.builder` chứa các `CoinListItem` là hoàn toàn tương thích và tiết kiệm công sức.

## Risks / Trade-offs

- **Risk:** Cảm giác giật lag khi chuyển đổi giữa List mặc định và List kết quả.
  - **Mitigation:** Đảm bảo thời gian delay UI ở mức tối thiểu, sử dụng `AnimatedSwitcher` nếu cần để transition mượt mà hơn.
- **Risk:** Debounce quá dài làm ứng dụng có vẻ chậm chạp.
  - **Mitigation:** Chọn mức 300-500ms là mức tiêu chuẩn (sweet spot) được khuyến nghị cho tìm kiếm real-time.
