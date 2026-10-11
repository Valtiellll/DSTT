%% ========================================================================
% SCRIPT XỬ LÝ DỮ LIỆU CẢM BIẾN (MAIN.M)
% ========================================================================
clear; clc; close all;

%% 1. XỬ LÝ DỮ LIỆU
disp('--- BƯỚC 1: XỬ LÝ DỮ LIỆU ---');

% Đọc CSV: Dùng readmatrix vì file chủ yếu là số. Hàm sẽ tự động bỏ qua dòng chữ header.
try
    data = readmatrix('sensor_log.csv');
    disp('Đọc file sensor_log.csv thành công!');
catch
    error('LỖI: Không tìm thấy file sensor_log.csv. Hãy đảm bảo file nằm cùng thư mục.');
end

% Kiểm tra kích thước dữ liệu (số hàng, số cột)
[num_rows, num_cols] = size(data);
fprintf('Kích thước dữ liệu: %d mẫu (hàng), %d thuộc tính (cột)\n', num_rows, num_cols);

% Dùng indexing truy xuất các cột cần thiết (dựa theo thứ tự cột của CSV)
% 2: time_s, 3: temp_C, 5: voltage_V, 6: current_A, 7: mode_code
time_s = data(:, 2);
temp_C = data(:, 3);
V = data(:, 5);
I = data(:, 6);
mode_code = data(:, 7);

% Gọi function xử lý để tính toán Công suất, Điện trở và Trạng thái
[P, R, status] = process_sensor_data(V, I, temp_C, mode_code);

% Đánh dấu rõ các mẫu không hợp lệ
invalid_idx = find(mode_code == 0);
fprintf('Phát hiện %d mẫu không hợp lệ (mode_code = 0).\n', length(invalid_idx));
disp('Đã bỏ qua tính toán công suất/điện trở cho các mẫu này (giữ nguyên = 0).');


%% 2. BIỂU DIỄN DỮ LIỆU
disp('--- BƯỚC 2: VẼ ĐỒ THỊ ---');
% Mở figure và chia làm 3 subplot
figure('Name', 'Phân tích Sensor Log', 'Position', [100, 100, 1200, 400]);

% 2.1. Plot: Nhiệt độ theo thời gian
subplot(1, 3, 1);
plot(time_s, temp_C, '-b', 'LineWidth', 1.5);
title('Nhiệt độ theo thời gian');
xlabel('Thời gian (s)');
ylabel('Nhiệt độ (°C)');
grid on;
legend('Nhiệt độ', 'Location', 'best');

% Lọc ra các mẫu hợp lệ để vẽ 2 biểu đồ sau được chuẩn xác
valid_idx = (mode_code ~= 0);

% 2.2. Scatter: Nhiệt độ so với công suất
subplot(1, 3, 2);
scatter(temp_C(valid_idx), P(valid_idx), 30, 'r', 'filled');
title('Nhiệt độ so với Công suất');
xlabel('Nhiệt độ (°C)');
ylabel('Công suất P (W)');
grid on;
legend('Mẫu hợp lệ', 'Location', 'best');

% 2.3. Bar: Công suất trung bình theo mã mẫu
subplot(1, 3, 3);
unique_modes = unique(mode_code(valid_idx)); % Lấy các mã 1, 2, 3... (không trùng)
mean_P = zeros(length(unique_modes), 1);
for k = 1:length(unique_modes)
    % Tính trung bình công suất của các mẫu thuộc mã tương ứng
    mean_P(k) = mean(P(valid_idx & (mode_code == unique_modes(k))));
end
bar(unique_modes, mean_P, 'FaceColor', [0.2 0.6 0.5]);
set(gca, 'XTick', unique_modes); % Chỉ hiện các vạch số nguyên của mã
title('Công suất TB theo mã mẫu');
xlabel('Mã mẫu (Mode Code)');
ylabel('Công suất P (W)');
grid on;

%% 3. XUẤT VÀ NẠP DỮ LIỆU
disp('--- BƯỚC 3: XUẤT FILE & KIỂM TRA ---');
% Ghép vector P và R vào ma trận data ban đầu, sau đó ghi ra CSV mới
processed_data = [data, P, R];
writematrix(processed_data, 'processed_results.csv');
disp('Đã xuất dữ liệu thành công ra file: processed_results.csv');

% Dùng save để lưu các biến kết quả vào file MAT
save('sensor_results.mat', 'processed_data', 'status', 'P', 'R');
disp('Đã lưu các biến kết quả vào: sensor_results.mat');

% Dùng load để nạp lại (Xóa trước để chứng minh nạp thành công)
clear processed_data status P R;
load('sensor_results.mat');
disp('Đã nạp lại thành công các biến từ file sensor_results.mat');

% Dùng readmatrix kiểm tra lại file CSV vừa xuất
check_output = readmatrix('processed_results.csv');
fprintf('Kiểm tra file output: %d hàng, %d cột (Gốc 7 cột + P + R).\n', size(check_output, 1), size(check_output, 2));

disp('=== HOÀN TẤT CHƯƠNG TRÌNH ===');

%% ========================================================================
% ĐỊNH NGHĨA FUNCTION (ĐỂ CUỐI FILE)
% ========================================================================
function [P, R, status] = process_sensor_data(V, I, temp_C, mode_code)
    % GIẢI THÍCH LOGIC XỬ LÝ:
    % 1. Sử dụng hàm zeros để khởi tạo kích thước chuẩn cho vector P và R.
    % 2. Dùng Logical Indexing (valid_idx) để chỉ tính toán trên các mẫu hợp lệ,
    %    tối ưu hiệu suất thay vì dùng vòng lặp for tính toán từng dòng.
    % 3. Phép tính .* và ./ được dùng cho phép tính vector từng phần tử.
    % 4. Dùng vòng lặp và if/else để kiểm tra nhiều điều kiện phân loại trạng thái.
    
    N = length(V);
    
    % Khởi tạo vector P, R (sử dụng zeros) và mảng chuỗi trạng thái
    P = zeros(N, 1);
    R = zeros(N, 1);
    status = strings(N, 1); 
    
    % Lọc mẫu hợp lệ (Logical Indexing)
    valid_idx = (mode_code ~= 0);
    
    % Tính công suất và điện trở cho mẫu hợp lệ (Toán tử ma trận .* và ./)
    P(valid_idx) = V(valid_idx) .* I(valid_idx);
    R(valid_idx) = V(valid_idx) ./ I(valid_idx);
    
    % Phân loại trạng thái (Dùng vòng lặp và if/elseif/else)
    for i = 1:N
        if mode_code(i) == 0
            status(i) = "INVALID";
        elseif temp_C(i) >= 33
            status(i) = "HIGH_TEMP";
        elseif temp_C(i) < 25
            status(i) = "LOW_TEMP";
        else
            status(i) = "NORMAL";
        end
    end
end