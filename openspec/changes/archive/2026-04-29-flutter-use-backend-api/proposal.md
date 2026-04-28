# flutter-use-backend-api

## What & Why

Hiện tại, ứng dụng Flutter (CryptoPulse) đang gọi trực tiếp CoinGecko API để lấy danh sách coin và market chart (trong `CoinRepositoryImpl.dart`). Điều này dẫn đến việc:
1. Client bị phụ thuộc trực tiếp vào CoinGecko (rate limit, cấu trúc dữ liệu).
2. Khi cần thêm logic backend (như auth, favoriting, cache chung) thì khó quản lý.
3. Không thể tích hợp dữ liệu hệ thống nội bộ với dữ liệu coin chung một nguồn.

**Mục tiêu của thay đổi này:**
Trỏ các API calls liên quan đến Coin trong ứng dụng Flutter sang backend nội bộ của chúng ta đang chạy ở `http://localhost:8088`. Backend này đóng vai trò là một middleware/proxy và đã được nâng cấp (trong change `backend-coin-api-enhance`) để trả về đầy đủ `sparkline_in_7d` và hỗ trợ chuẩn format biểu đồ.

## Scope

Thay đổi giới hạn ở Flutter project (`c:\Projects\CryptoPulse`):
- `lib/features/dashboard/data/coin_repository_impl.dart`
- Không thay đổi UI/UX của màn hình Dashboard hay Coin Detail.
- Sử dụng Dio interceptor hoặc Base URL config tĩnh trỏ về `http://localhost:8088`.

## Out of Scope

- Bổ sung xác thực JWT vào các API Coin (sẽ thực hiện trong change khác).
- Cập nhật các feature không liên quan đến Coin (như Wallet, Auth).
- Môi trường Production / cấu hình .env (hiện tại hardcode `localhost` cho môi trường Dev).
