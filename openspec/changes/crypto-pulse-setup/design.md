# Design: CryptoPulse Dashboard

## Architecture
Chúng ta sẽ sử dụng cấu trúc **Clean Architecture** (Feature-driven) để đảm bảo tính dễ bảo trì:

```
lib/
├── core/
│   ├── constants/      # App colors, sizes, strings
│   ├── theme/          # Dark theme configuration
│   └── util/           # Formatters, common widgets
├── features/
│   ├── dashboard/      # Main screen features
│   │   ├── data/       # API services, models
│   │   ├── domain/     # Entities, use cases
│   │   └── presentation/ # Widgets, riverpod providers, screens
│   └── coin_detail/    # Detail screen features
└── main.dart
```

## UI/UX Design System
- **Colors**:
  - `background`: #0B0E11 (Deep Black)
  - `onBackground`: #FFFFFF
  - `primary`: #00FF41 (Matrix Green) - dùng cho các chỉ số tăng
  - `secondary`: #FF3B30 (Alert Red) - dùng cho các chỉ số giảm
  - `surface`: #1E2329 (Grey Surface) - dùng cho các cards
- **Key UI Elements**:
  - **Glassmorphism Cards**: Nền thẻ hơi mờ với hiệu ứng blur.
  - **Neon Glowing Charts**: Biểu đồ có hiệu ứng phát sáng mờ.
  - **Haptic Feedback**: Rung nhẹ khi chuyển đổi giữa các tab hoặc nhấn vào coin.

## External Services
- **CoinGecko API**: 
  - Endpoint: `https://api.coingecko.com/api/v3`
  - Auth: No API key needed for basic usage.
- **Dio**: Thư viện HTTP client để gọi API.
- **Riverpod**: Quản lý State tập trung.
