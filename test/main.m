clear; clc; close all;

%% 1. XỬ LÝ DỮ LIỆU
% Đọc file CSV: dùng readmatrix vì tự động bỏ qua header và lấy ma trận số
if isfile('sensor_log.csv')
    data = readmatrix('sensor_log.csv');
elseif isfile('sensor_data.csv')
    data = readmatrix('sensor_data.csv');
else
    data = readmatrix(fullfile('test', 'sensor_log.csv'));
end

% Kiểm tra kích thước ma trận dữ liệu
[n_rows, n_cols] = size(data);

% Indexing lấy các cột: 1:id, 2:time, 3:temp, 5:V, 6:I, 7:mode
sample_id = data(:, 1);
time_s    = data(:, 2);
temp_C    = data(:, 3);
V         = data(:, 5);
I         = data(:, 6);
mode_code = data(:, 7);

% Xác định mẫu hợp lệ (mode_code ~= 0) bằng logical indexing
valid = (mode_code ~= 0);

% Gọi hàm tính P, R và phân loại trạng thái
[P, R, status] = process_data(V, I, temp_C, mode_code);


%% 2. BIỂU DIỄN DỮ LIỆU
figure;

% 2.1. Plot: Nhiệt độ theo thời gian
subplot(3, 1, 1);
plot(time_s, temp_C, '-o');
title('Nhiệt độ theo thời gian');
xlabel('Thời gian (s)');
ylabel('Nhiệt độ (°C)');
grid on;
legend('temp\_C');

% 2.2. Scatter: Nhiệt độ so với công suất (chỉ vẽ mẫu hợp lệ)
subplot(3, 1, 2);
scatter(temp_C(valid), P(valid), 'filled');
title('Nhiệt độ so với công suất');
xlabel('Nhiệt độ (°C)');
ylabel('Công suất P (W)');
grid on;
legend('Mẫu hợp lệ');

% 2.3. Bar: Công suất theo mã mẫu
subplot(3, 1, 3);
bar(sample_id, P);
title('Công suất theo mã mẫu');
xlabel('Mã mẫu (sample\_id)');
ylabel('Công suất P (W)');
grid on;
legend('Công suất P');


%% 3. XUẤT VÀ KIỂM TRA DỮ LIỆU
% Xuất dữ liệu số đã xử lý ra CSV
writematrix([data, P, R], 'processed_results.csv');

% Lưu và nạp lại các biến kết quả bằng save và load
save('results.mat', 'P', 'R', 'status');
load('results.mat');

% Kiểm tra lại file CSV đầu ra
out = readmatrix('processed_results.csv');

disp('Đã hoàn thành!');


%% HÀM XỬ LÝ DỮ LIỆU
function [P, R, status] = process_data(V, I, temp, mode)
    % Dùng zeros cấp phát bộ nhớ trước cho vector P, R
    % Dùng .* và ./ vì P, V, I, R là các vector (không dùng * và / của ĐSTT)
    N = length(V);
    P = zeros(N, 1);
    R = zeros(N, 1);
    status = strings(N, 1);

    % Tính P, R cho mẫu hợp lệ (mode ~= 0), mẫu mode == 0 giữ nguyên = 0
    valid = (mode ~= 0);
    P(valid) = V(valid) .* I(valid);
    R(valid) = V(valid) ./ I(valid);

    % Vòng lặp phân loại trạng thái
    for i = 1:N
        if mode(i) == 0
            status(i) = "INVALID";
        elseif temp(i) >= 33
            status(i) = "HIGH_TEMP";
        elseif temp(i) < 25
            status(i) = "LOW_TEMP";
        else
            status(i) = "NORMAL";
        end
    end
end
