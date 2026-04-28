# Design — flutter-use-backend-api

## Architecture Overview

Ứng dụng Flutter sẽ thay đổi Endpoint từ `api.coingecko.com` sang `localhost:8088`.
Trong quá trình này, `CoinRepositoryImpl` sẽ đóng vai trò tích hợp với backend của chúng ta.
Backend vẫn sẽ tuân thủ phần lớn cấu trúc response của CoinGecko, nhưng do ta đã deserialize và serialize lại trong Entity `Coin.java` ở backend, một số field (cụ thể là `sparkline_in_7d`) sẽ có sự khác biệt nhỏ về cấu trúc.

## Chi tiết thay đổi

### 1. Thay đổi Base URL
- Trong `CoinRepositoryImpl.dart`, thay thế host `https://api.coingecko.com/api/v3/coins/markets` bằng `http://localhost:8088/coins`.
- Tương tự cho `getMarketChart`, thay host sang `http://localhost:8088/coins/$id/chart`.

**Lưu ý về Platform**:
- Đối với Android Emulator, `localhost` trỏ về thiết bị ảo, nên cần dùng `10.0.2.2`.
- Đối với iOS Simulator và Web, `localhost` vẫn là `localhost`.
- Giải pháp: Khai báo một Base URL tĩnh dựa trên `kIsWeb` và `Platform` hoặc tạm thời hardcode `localhost` nếu chỉ dùng cho Web, nhưng tốt nhất nên khai báo hằng số để dễ đổi.

### 2. Cập nhật Model Parsing (`CoinModel.fromJson`)
**Vấn đề Sparkline**:
- CoinGecko trả về: `"sparkline_in_7d": { "price": [1.0, 2.0] }`
- Backend Spring Boot trả về: `"sparkline_in_7d": [1.0, 2.0]` (do đã qua `SparklineDeserializer`).

**Giải pháp**: Cập nhật `CoinModel.fromJson` trong Flutter để handle an toàn cả 2 định dạng (tương thích ngược nếu sau này cần trỏ lại CoinGecko):
```dart
dynamic sparklineData = json['sparkline_in_7d'];
List<double>? parsedSparkline;

if (sparklineData != null) {
  if (sparklineData is List) {
    parsedSparkline = sparklineData.map((e) => (e as num).toDouble()).toList();
  } else if (sparklineData is Map && sparklineData['price'] != null) {
    parsedSparkline = (sparklineData['price'] as List).map((e) => (e as num).toDouble()).toList();
  }
}
```

### 3. Params của Market Chart
Backend của chúng ta có định dạng `/coins/$id/chart?days=$days` thay vì `/coins/$id/market_chart`.
Cần đổi endpoint trong hàm `getMarketChart()` thành `/coins/$id/chart`.

## Files sẽ thay đổi

| File | Thay đổi |
|---|---|
| `lib/features/dashboard/data/coin_repository_impl.dart` | Đổi các URL CoinGecko thành Backend URL, sửa đường dẫn path của chart API |
| `lib/features/dashboard/data/coin_model.dart` | Cập nhật logic parse `sparkline_in_7d` để nhận giá trị dạng `List` |
