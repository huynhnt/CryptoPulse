## Context

Hiện tại, trang Home của ứng dụng chỉ hiển thị một danh sách giới hạn các đồng coin trong phần "Market Highlights". Để người dùng có thể theo dõi thị trường đầy đủ, cần thiết phải có một trang hiển thị tất cả các đồng coin. Số lượng coin rất lớn, do đó việc tải toàn bộ cùng lúc là không khả thi. Cần áp dụng cơ chế cuộn vô hạn (infinite scroll) để vừa tải dữ liệu theo từng trang nhỏ (50 items/trang), vừa duy trì hiệu năng ổn định, mượt mà trên ứng dụng Flutter.

## Goals / Non-Goals

**Goals:**
- Hiển thị nút/action "See all" ở màn hình chính.
- Mở một màn hình mới hiển thị tất cả đồng coin khi người dùng nhấn "See all".
- Cuộn xuống dưới màn hình sẽ tự động kích hoạt lời gọi API để lấy trang dữ liệu tiếp theo.
- Giữ vững trải nghiệm người dùng với các thông báo "Loading..." thân thiện khi đang fetch data thêm.

**Non-Goals:**
- Không hỗ trợ tìm kiếm trên trang "Tất cả đồng coin" trong thay đổi này.
- Không hỗ trợ bộ lọc và sắp xếp nâng cao trong thay đổi này (sẽ dành cho ticket khác).

## Decisions

- **State Management**: Sử dụng mô hình state hiện tại của dự án để lưu trữ danh sách tích luỹ (`List<Coin>`), trạng thái tải trang tiếp theo (`isLoadingMore`), và trạng thái hết dữ liệu (`hasReachedMax`).
- **Scroll Controller**: Gắn một `ScrollController` vào `ListView` / `SliverList` ở frontend. Bắt sự kiện cuộn đến khoảng cách nhất định (ví dụ: cách đáy 200px) thì sẽ kích hoạt `fetchNextPage()`.
- **API Fetching**: Frontend gọi hàm repository với `page` tăng dần và `per_page = 50`. Nếu danh sách trả về nhỏ hơn 50, hệ thống đánh dấu `hasReachedMax = true` và ẩn loading indicator dưới cùng vĩnh viễn.
- **Bottom Navigation Bar**: `AllCoinsScreen` cần có thanh Menu (BottomNavigationBar) giống như `MainScreen` để duy trì trải nghiệm người dùng. Khi nhấn vào các tab trên `AllCoinsScreen`, ứng dụng phải thay thế Navigator stack bằng `MainScreen` với `initialIndex` tương ứng thông qua `Navigator.pushAndRemoveUntil`, giúp tránh lỗi chồng chéo màn hình hoặc back nhầm.

## Risks / Trade-offs

- **Risk: Thao tác cuộn quá nhanh gây gọi API liên tục (Race condition)** -> Mitigation: Khoá hàm gọi API bằng cờ `isLoadingMore`. Nếu đang tải trang, mọi sự kiện cuộn xuống đáy sẽ bị bỏ qua cho đến khi fetch thành công hoặc lỗi.
- **Risk: Dữ liệu bị trùng lặp do thay đổi thứ hạng (rank) theo thời gian thực** -> Mitigation: Vì API Backend được cache trong 1 phút, nguy cơ này sẽ giảm bớt. Frontend cũng có thể duyệt để không thêm item nếu ID đã tồn tại trong danh sách.
