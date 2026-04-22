# Proposal: CryptoPulse Dashboard Setup

## Overview
Xây dựng một ứng dụng Dashboard tiền điện tử hiện đại, đa nền tảng (Android/iOS) sử dụng Flutter. Ứng dụng tập trung vào trải nghiệm người dùng cao cấp (Premium UI) với dữ liệu thời gian thực.

## Problem Statement
Người dùng cần một công cụ theo dõi giá coin và quản lý danh mục đầu tư (Portfolio) có giao diện đẹp, trực quan và tốc độ phản hồi nhanh.

## Proposed Solution
Dự án sẽ sử dụng:
- **Framework**: Flutter (Dart)
- **State Management**: Riverpod (cho tính an toàn và quản lý luồng dữ liệu bất đồng bộ)
- **UI/UX**: Dark Mode chủ đạo, Glassmorphism, và các biểu đồ tương tác mượt mà.
- **Data Source**: CoinGecko API (Miễn phí và ổn định).

## Scope
- Khởi tạo project Flutter chuẩn.
- Cấu hình cấu trúc thư mục Clean Architecture.
- Cài đặt các thư viện cần thiết (Riverpod, Fl_chart, Dio, Google Fonts).
- Xây dựng màn hình Home (Dashboard) và màn hình Detail (Coin Chart).

## Success Criteria
- Ứng dụng chạy mượt mà trên cả Android và iOS.
- Dữ liệu giá coin được cập nhật từ API.
- Giao diện đạt chuẩn "Premium UI" như đã thảo luận.
