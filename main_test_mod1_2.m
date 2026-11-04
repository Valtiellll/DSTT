%% FILE CHẠY THỬ NGHIỆM MODULE 1 + MODULE 2 TRÊN ẢNH THẬT ORL
clear; clc; close all;

% 1. Điền tên thư mục chứa 40 folder (s1 -> s40) mới tải (tôi để là ORL)
thu_muc_anh = 'ORL'; 
k = 50; % Chọn giữ lại 50 nguyên liệu Eigenfaces chủ đạo 

% 2. Gọi Module 1 đọc ảnh thật (thay module1_load_data = tên file phần 1 của Khang) 
[X_train, y_train, X_test, y_test, img_dims] = module1_load_data(thu_muc_anh);

% 3. Gọi Module 2 để chạy PCA
[Omega_train, Omega_test, U_k, mu, eigenvalues, U_full, Omega_train_full, Omega_test_full] = ...
    module2_core_pca(X_train, X_test, k);

% 4. Lưu toàn bộ kết quả thật ra file .mat 
save('module2_output.mat', ...
     'X_train', 'y_train', 'X_test', 'y_test', 'img_dims', ...
     'mu', 'U_k', 'U_full', 'Omega_train', 'Omega_test', ...
     'Omega_train_full', 'Omega_test_full', 'eigenvalues', 'k');

% 5. VẼ THỬ LÊN MÀN HÌNH ĐỂ BẠN KIỂM TRA NGAY KẾT QUẢ THẬT!
figure('Name', 'Kiểm tra kết quả Module 1 & 2', 'Position', [100, 100, 900, 350]);

% Hình bên trái: Khuôn mặt trung bình thật của 280 ảnh
subplot(1, 5, 1);
imshow(reshape(mu, img_dims), []);
title('Khuôn mặt TB (\mu)');

% 4 hình tiếp theo: 4 "Nguyên liệu gốc" (Eigenfaces) quan trọng nhất
for i = 1:4
    subplot(1, 5, i + 1);
    % Dùng dấu [] trong imshow để MATLAB tự căn độ sáng âm/dương của Eigenface cho dễ nhìn
    imshow(reshape(U_k(:, i), img_dims), []);
    title(sprintf('Eigenface %d', i));
end