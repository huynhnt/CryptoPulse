---
name: flutter-clean-feature
description: Tự động khởi tạo cấu trúc thư mục và các file mẫu cho một tính năng mới theo chuẩn Clean Architecture trong Flutter.
---

# Flutter Clean Feature Skill

Sử dụng skill này khi bạn cần bắt đầu xây dựng một tính năng (feature) mới cho ứng dụng CryptoPulse.

## Cấu trúc thư mục mục tiêu
Mỗi tính năng mới sẽ được tạo tại `lib/features/<feature_name>/` với cấu trúc:
- `data/`: Chứa các Model (JSON mapping) và Repository implementation.
- `domain/`: Chứa các Entity (Business object) và Repository interface.
- `presentation/`:
    - `screens/`: Các màn hình chính.
    - `widgets/`: Các UI components dùng riêng cho feature.
    - `providers/`: Riverpod providers.

## Quy trình thực hiện

1. **Phân tích yêu cầu**: Xác định tên tính năng và các thuộc tính chính của dữ liệu.
2. **Tạo thư mục**: Sử dụng lệnh terminal để tạo toàn bộ cấu trúc thư mục trên.
3. **Gen code mẫu**:
    - Tạo `entity.dart` trong `domain`.
    - Tạo `repository.dart` (interface) trong `domain`.
    - Tạo `model.dart` (fromJson/toJson) trong `data`.
    - Tạo `repository_impl.dart` trong `data`.
    - Tạo `provider.dart` trong `presentation/providers`.
4. **Tiêu chuẩn UI**:
    - Luôn sử dụng `package:crypto_pulse/core/constants/app_colors.dart` cho màu sắc.
    - Luôn bọc các widget chính bằng `FadeInSlide` từ `package:crypto_pulse/core/util/animations.dart`.
    - Các màn hình mới phải kế thừa `ConsumerWidget` hoặc sử dụng `Consumer` của Riverpod.

## Ví dụ lệnh tạo nhanh (PowerShell)
```powershell
$f="wallet"; mkdir lib/features/$f/data, lib/features/$f/domain, lib/features/$f/presentation/screens, lib/features/$f/presentation/widgets, lib/features/$f/presentation/providers
```

## Lưu ý
- Luôn sử dụng **Package Import** (`package:crypto_pulse/...`) thay vì đường dẫn tương đối.
- Đảm bảo các file mới được đăng ký hoặc sử dụng đúng trong luồng điều hướng chính.
