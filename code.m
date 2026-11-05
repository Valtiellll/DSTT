% Đọc ảnh từ file
img = imread('image1.jpg');

% Nếu là ảnh màu (RGB), chuyển sang ảnh xám (Grayscale)
if size(img, 3) == 3
    img = rgb2gray(img);
end

% Chuyển kiểu dữ liệu sang double để tính toán PCA chính xác
img = double(img);

% Chuyển ma trận ảnh (M x N) thành vectơ cột ((M*N) x 1)
% Toán tử (:) trong MATLAB tự động xếp chồng các cột của ma trận thành 1 vectơ cột
% Hoặc có thể dùng: img_vector = reshape(img, [], 1);
img_vector = img(:);

% Kiểm tra kích thước
[M, N] = size(img);
fprintf('Kích thước ảnh gốc: %d x %d\n', M, N);
fprintf('Kích thước vectơ cột: %d x %d\n', size(img_vector, 1), size(img_vector, 2));