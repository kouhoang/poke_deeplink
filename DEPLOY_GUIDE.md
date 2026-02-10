# 🚀 Hướng dẫn Deploy Flutter Web lên Vercel

## Phương pháp 1: Deploy qua Vercel Dashboard (Đơn giản nhất - Khuyến nghị)

### Bước 1: Đẩy code lên GitHub

```bash
# Khởi tạo git repository (nếu chưa có)
git init

# Thêm tất cả files
git add .

# Commit
git commit -m "Initial commit - Pokemon app"

# Tạo repository trên GitHub và push
# Truy cập: https://github.com/new
# Sau đó chạy:
git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPO_NAME.git
git branch -M main
git push -u origin main
```

### Bước 2: Import vào Vercel

1. Truy cập [vercel.com](https://vercel.com)
2. Đăng nhập bằng GitHub account
3. Click **"Add New Project"**
4. Chọn repository `poke_deeplink` của bạn
5. Click **"Import"**
6. Vercel sẽ tự động phát hiện file `vercel.json` và cấu hình build
7. Click **"Deploy"**

### Bước 3: Đợi build hoàn thành

- Vercel sẽ tự động:
  - Clone Flutter SDK
  - Build web app
  - Deploy lên CDN
- Thời gian build: ~5-10 phút (lần đầu)
- Bạn sẽ nhận được URL: `https://your-project.vercel.app`

---

## Phương pháp 2: Deploy qua Vercel CLI

### Bước 1: Cài đặt Vercel CLI

```bash
npm install -g vercel
```

### Bước 2: Login vào Vercel

```bash
vercel login
```

### Bước 3: Deploy

```bash
# Deploy (production)
vercel --prod

# Hoặc deploy preview
vercel
```

---

## Phương pháp 3: Build local và deploy (Nhanh hơn)

### Bước 1: Build Flutter web locally

```bash
# Clean build
flutter clean

# Build for web
flutter build web --release --web-renderer canvaskit
```

### Bước 2: Tạo vercel.json đơn giản hơn

Tạo file `vercel-local.json`:

```json
{
  "buildCommand": "echo 'Using pre-built files'",
  "outputDirectory": "build/web",
  "framework": null,
  "routes": [
    {
      "handle": "filesystem"
    },
    {
      "src": "/pokemon/(.*)",
      "dest": "/index.html"
    },
    {
      "src": "/(.*)",
      "dest": "/index.html"
    }
  ]
}
```

### Bước 3: Deploy với config mới

```bash
vercel --prod -c vercel-local.json
```

---

## ⚙️ Cấu hình hiện tại của bạn

File `vercel.json` hiện tại đã được cấu hình để:

- ✅ Tự động clone Flutter SDK
- ✅ Build web với `--release` flag
- ✅ Hỗ trợ routing cho GoRouter (`/pokemon/:id`)
- ✅ Hỗ trợ deep linking với assetlinks.json

---

## 🔧 Tối ưu hóa (Optional)

### 1. Thêm base href vào web/index.html

Đảm bảo file `web/index.html` có:

```html
<base href="/">
```

### 2. Cấu hình web renderer

Trong `vercel.json`, bạn có thể thay đổi build command:

```json
{
  "buildCommand": "flutter/bin/flutter build web --release --web-renderer canvaskit"
}
```

**Web Renderer Options:**
- `canvaskit`: Tốt hơn cho animations, graphics (file size lớn hơn)
- `html`: Nhẹ hơn, tốt cho SEO (mặc định)
- `auto`: Flutter tự chọn

### 3. Tối ưu hóa build size

Thêm vào build command:

```bash
--dart-define=FLUTTER_WEB_USE_SKIA=false --tree-shake-icons
```

---

## 🌐 Custom Domain (Optional)

Sau khi deploy thành công:

1. Vào Vercel Dashboard → Project Settings → Domains
2. Thêm custom domain của bạn
3. Cấu hình DNS theo hướng dẫn của Vercel

---

## 🐛 Troubleshooting

### Lỗi: "Build failed"

```bash
# Thử build local trước để kiểm tra
flutter build web --release

# Nếu thành công, deploy lại
vercel --prod
```

### Lỗi: "Routes not working"

- Đảm bảo `vercel.json` có routes config đúng
- Kiểm tra GoRouter configuration trong code

### Lỗi: "Assets not loading"

- Kiểm tra `<base href="/">` trong `web/index.html`
- Đảm bảo assets được khai báo trong `pubspec.yaml`

---

## 📊 Monitoring

Sau khi deploy:

- **Analytics**: Vercel Dashboard → Analytics
- **Logs**: Vercel Dashboard → Deployments → View Logs
- **Performance**: Vercel Dashboard → Speed Insights

---

## 🔄 Auto Deploy

Nếu deploy qua GitHub:

- Mỗi khi push code lên `main` branch → Vercel tự động deploy
- Pull requests → Tạo preview deployment
- Rollback dễ dàng qua Vercel Dashboard

---

## 📝 Checklist trước khi deploy

- [ ] Code đã được test kỹ
- [ ] Build local thành công: `flutter build web --release`
- [ ] Routes hoạt động đúng
- [ ] Assets load đúng
- [ ] API endpoints đã được cấu hình (nếu có)
- [ ] Environment variables đã được set (nếu cần)
- [ ] `.gitignore` đã loại trừ `build/`, `flutter/`

---

## 🎉 Kết quả

Sau khi deploy thành công, bạn sẽ có:

- ✅ URL public: `https://your-project.vercel.app`
- ✅ HTTPS tự động
- ✅ CDN global
- ✅ Auto-scaling
- ✅ Analytics built-in
- ✅ Zero-downtime deployments

---

## 💡 Tips

1. **Lần deploy đầu tiên sẽ lâu** (~10 phút) vì phải clone Flutter SDK
2. **Các lần sau nhanh hơn** (~2-3 phút) vì Vercel cache SDK
3. **Build local trước** nếu muốn deploy nhanh (Phương pháp 3)
4. **Sử dụng GitHub integration** để có auto-deploy và preview deployments

---

## 📚 Resources

- [Vercel Documentation](https://vercel.com/docs)
- [Flutter Web Deployment](https://docs.flutter.dev/deployment/web)
- [GoRouter Documentation](https://pub.dev/packages/go_router)
