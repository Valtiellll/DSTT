
clear;
clc;
close all;

% Lưu dữ liệu file thành ma trận A, check kích thước để kiểm tra đúng
% format
A = readmatrix("sensor_log.csv");
[Ax, Ay] = size(A);

if isempty(A) || Ay < 7
    error("Du lieu rong hoac CSV khong du so cot.");
end

% Đọc file processSensorData trước để hiểu rõ hơn phần code dưới đây
% Dùng function riêng để giải bài
[B, status, valid, V, I, R, P] = processSensorData(A);

% Lưu các mẫu hợp lệ vào 4 vector V I R P; P sẽ dùng để vẽ biểu đồ
V = V(valid);
I = I(valid);
R = R(valid);
P = P(valid);

% Trích xuất thời gian, nhiệt và các mẫu hợp lệ
time = A(valid, 2);
heat = A(valid, 3);
status_valid = status(valid);

% Gom công suất theo mức nhiệt độ tương ứng để tiện kiểm tra kết quả
LOW_TEMP = P(status_valid == "LOW_TEMP");
NORMAL = P(status_valid == "NORMAL");
HIGH_TEMP = P(status_valid == "HIGH_TEMP");

% Hiển thị kết quả
disp(B);

% Plot 1: nhiệt độ theo thời gian
figure;
plot(time, heat, "-o", "DisplayName", "Nhiet do");
title("Nhiet do theo thoi gian");
xlabel("Thoi gian");
ylabel("Nhiet do (do C)");
legend("show", "Location", "best");
grid on;

% Scatter: nhiệt độ so với công suất
figure;
scatter(heat, P, "filled", "DisplayName", "Mau hop le");
title("Nhiet do so voi cong suat");
xlabel("Nhiet do (do C)");
ylabel("Cong suat (W)");
legend("show", "Location", "best");
grid on;

% Bar: công suất theo mã mẫu
figure;
bar(A(valid, 1), P, "DisplayName", "Cong suat");
title("Cong suat theo ma mau");
xlabel("Ma mau");
ylabel("Cong suat (W)");
legend("show", "Location", "best");
grid on;

% Xuất dữ liệu đã xử lí
writematrix(B, "processed_results.csv");

% Đọc lại để kiểm tra file CSV đầu ra
B_check = readmatrix("processed_results.csv");

disp("Du lieu da doc lai tu CSV:");
disp(B_check);