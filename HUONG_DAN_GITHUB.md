# 📚 Hướng dẫn Push Project lên GitHub (Repo mới)

## Bước 1: Tạo Repository mới trên GitHub

### Cách 1: Qua Web Browser (Đơn giản nhất)

1. **Đăng nhập GitHub**
   - Truy cập: https://github.com
   - Đăng nhập vào tài khoản của bạn

2. **Tạo Repository mới**
   - Click vào dấu **+** ở góc trên bên phải
   - Chọn **"New repository"**
   - Hoặc truy cập trực tiếp: https://github.com/new

3. **Điền thông tin Repository**
   - **Repository name**: `poke-deeplink` (hoặc tên bạn muốn)
   - **Description**: `Pokemon web app built with Flutter`
   - **Public** hoặc **Private**: Chọn theo ý bạn
   - ⚠️ **QUAN TRỌNG**: 
     - ❌ **KHÔNG** tick vào "Add a README file"
     - ❌ **KHÔNG** tick vào "Add .gitignore"
     - ❌ **KHÔNG** chọn "Choose a license"
   - Click **"Create repository"**

4. **Copy URL của Repository**
   - Sau khi tạo xong, bạn sẽ thấy URL dạng:
   - `https://github.com/YOUR_USERNAME/poke-deeplink.git`
   - Copy URL này lại (sẽ dùng ở bước sau)

---

## Bước 2: Push Code lên GitHub

### Mở Terminal và chạy các lệnh sau:

```bash
# Di chuyển vào thư mục project
cd /Users/hoangdh1/Documents/poke_deeplink

# Khởi tạo Git repository
git init

# Thêm tất cả files vào staging
git add .

# Commit lần đầu
git commit -m "Initial commit: Pokemon Flutter web app"

# Đổi tên branch thành main (nếu cần)
git branch -M main

# Thêm remote repository (thay YOUR_USERNAME và YOUR_REPO_NAME)
git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPO_NAME.git

# Push code lên GitHub
git push -u origin main
```

### ⚠️ Lưu ý:
- Thay `YOUR_USERNAME` bằng username GitHub của bạn
- Thay `YOUR_REPO_NAME` bằng tên repo bạn vừa tạo (ví dụ: `poke-deeplink`)

---

## Bước 3: Xác nhận đã Push thành công

1. Quay lại trang GitHub repository của bạn
2. Refresh trang (F5)
3. Bạn sẽ thấy tất cả files đã được upload

---

## Bước 4: Deploy lên Vercel

### Cách 1: Tự động qua GitHub Integration (Khuyến nghị)

1. **Truy cập Vercel**
   - Vào: https://vercel.com
   - Click **"Sign Up"** hoặc **"Login"**
   - Chọn **"Continue with GitHub"**

2. **Import Project**
   - Click **"Add New..."** → **"Project"**
   - Chọn repository `poke-deeplink` từ danh sách
   - Click **"Import"**

3. **Configure Project**
   - Vercel sẽ tự động phát hiện file `vercel.json`
   - **Project Name**: Giữ nguyên hoặc đổi tên
   - **Framework Preset**: None (đã có vercel.json)
   - Click **"Deploy"**

4. **Đợi Build**
   - Lần đầu tiên sẽ mất ~5-10 phút
   - Vercel sẽ:
     - Clone Flutter SDK
     - Build web app
     - Deploy lên CDN

5. **Hoàn thành!**
   - Bạn sẽ nhận được URL: `https://your-project.vercel.app`
   - Click vào để xem app của bạn

### Cách 2: Qua Vercel CLI

```bash
# Cài đặt Vercel CLI
npm install -g vercel

# Login vào Vercel
vercel login

# Deploy
vercel --prod
```

---

## 🎯 Tóm tắt các lệnh (Copy & Paste)

```bash
# Bước 1: Khởi tạo Git
cd /Users/hoangdh1/Documents/poke_deeplink
git init
git add .
git commit -m "Initial commit: Pokemon Flutter web app"
git branch -M main

# Bước 2: Thêm remote (THAY ĐỔI URL!)
git remote add origin https://github.com/YOUR_USERNAME/poke-deeplink.git

# Bước 3: Push lên GitHub
git push -u origin main
```

---

## 🔧 Troubleshooting

### Lỗi: "Permission denied"

**Nguyên nhân**: Chưa xác thực với GitHub

**Giải pháp**:
```bash
# Sử dụng GitHub CLI
brew install gh
gh auth login

# Hoặc sử dụng Personal Access Token
# 1. Tạo token tại: https://github.com/settings/tokens
# 2. Chọn: Generate new token (classic)
# 3. Chọn quyền: repo (full control)
# 4. Copy token
# 5. Khi push, nhập token thay vì password
```

### Lỗi: "Repository not found"

**Nguyên nhân**: URL remote sai

**Giải pháp**:
```bash
# Kiểm tra remote hiện tại
git remote -v

# Xóa remote cũ
git remote remove origin

# Thêm lại remote đúng
git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPO_NAME.git
```

### Lỗi: "Updates were rejected"

**Nguyên nhân**: Repository trên GitHub đã có commits

**Giải pháp**:
```bash
# Force push (cẩn thận!)
git push -u origin main --force
```

---

## 📱 Các lệnh Git hữu ích

```bash
# Xem trạng thái
git status

# Xem lịch sử commit
git log --oneline

# Xem remote
git remote -v

# Pull code mới nhất
git pull origin main

# Push code mới
git add .
git commit -m "Your message"
git push
```

---

## 🎉 Sau khi Deploy thành công

### Auto-Deploy
- Mỗi khi bạn push code mới lên GitHub
- Vercel sẽ tự động build và deploy
- Không cần làm gì thêm!

### Update Code
```bash
# 1. Sửa code
# 2. Commit và push
git add .
git commit -m "Update: description of changes"
git push

# 3. Vercel tự động deploy (1-2 phút)
```

### Xem Logs
- Vào Vercel Dashboard
- Click vào project
- Click vào **"Deployments"**
- Click vào deployment mới nhất
- Click **"View Function Logs"**

---

## 💡 Tips

1. **Commit thường xuyên**: Mỗi tính năng mới nên commit 1 lần
2. **Viết commit message rõ ràng**: Ví dụ "Add Pokemon detail screen"
3. **Test local trước**: Chạy `flutter build web --release` để test
4. **Sử dụng branches**: Tạo branch mới cho features lớn
5. **Pull trước khi push**: Nếu làm việc nhóm

---

## 📞 Cần giúp đỡ?

- GitHub Docs: https://docs.github.com
- Vercel Docs: https://vercel.com/docs
- Flutter Web Deployment: https://docs.flutter.dev/deployment/web

---

**Chúc bạn deploy thành công! 🚀**
