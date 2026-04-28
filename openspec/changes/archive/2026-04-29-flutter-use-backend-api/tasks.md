# Tasks — flutter-use-backend-api

## Status: ready

---

## Task 1 — Cập nhật logic parse Sparkline trong Model

**File:** `lib/features/dashboard/data/coin_model.dart`

- [x] Sửa đổi hàm `fromJson` để đọc trường `sparkline_in_7d`.
- [x] Thêm logic kiểm tra xem nó là dạng `List` hay là dạng `Map` (có chứa key `price`).
- [x] Đảm bảo cả hai trường hợp đều được parse thành `List<double>` an toàn.

---

## Task 2 — Trỏ endpoint danh sách coin về Backend

**File:** `lib/features/dashboard/data/coin_repository_impl.dart`

- [x] Tạo một biến hoặc const Base URL (ví dụ: `http://localhost:8088`).
- [x] Trong hàm `getTopCoins()`, sửa URL từ `https://api.coingecko.com/api/v3/coins/markets` thành `<Base URL>/coins`.
- [x] Giữ nguyên các query parameters (có thể truyền `page` như backend hỗ trợ).

---

## Task 3 — Trỏ endpoint market chart về Backend

**File:** `lib/features/dashboard/data/coin_repository_impl.dart`

- [x] Trong hàm `getMarketChart()`, sửa URL từ `https://api.coingecko.com/api/v3/coins/$id/market_chart` thành `<Base URL>/coins/$id/chart`.
- [x] Đảm bảo query parameters chứa `days`.

---

## Task 4 — Verify & Test (Thủ công)

- [x] Chạy backend (nếu chưa chạy) trên cổng 8088.
- [x] Build & chạy Flutter app (trên Chrome/Web hoặc Emulator tùy thuộc cấu hình Base URL).
- [x] Kiểm tra danh sách coin load thành công và hiển thị sparkline.
- [x] Kiểm tra màn hình chi tiết coin load chart thành công.
