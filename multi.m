% Đường dẫn tới thư mục chứa ảnh
folder = 'images'; % Thay bằng tên hoặc đường dẫn thư mục
files = dir(fullfile(folder, '*.jpg','*.jpg','*.png')); % Lấy tất cả file .jpg trong thư mục
P = length(files); % Số lượng ảnh

% Khởi tạo ma trận dữ liệu X (mỗi cột là 1 ảnh)
X = [];

for k = 1:P
    % Tạo đường dẫn đầy đủ tới từng ảnh và đọc ảnh
    img_path = fullfile(folder, files(k).name);
    img = imread(img_path);
    
    % Nếu là ảnh màu (RGB), chuyển sang ảnh xám (Grayscale)
    if size(img, 3) == 3
        img = rgb2gray(img);
    end
    
    % Chuyển kiểu dữ liệu sang double
    img = double(img);
    
    % Ép ma trận ảnh (M x N) thành vectơ cột ((M*N) x 1) và ghép vào cột thứ k của X
    X(:, k) = img(:);
end

% Kiểm tra kích thước
[M, N] = size(img);
fprintf('Kích thước mỗi ảnh gốc: %d x %d\n', M, N);
fprintf('Số lượng ảnh (P): %d\n', P);
fprintf('Kích thước ma trận dữ liệu X: %d x %d\n', size(X, 1), size(X, 2));

