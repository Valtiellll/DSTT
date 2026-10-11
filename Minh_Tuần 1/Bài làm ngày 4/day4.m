% BÀI 1: BÀI TẬP LOOP
% ------------------------------------------------------------------------
disp('=== BÀI 1 ===');

% a. Dùng 2 vòng for tính trace(A) với A = randi([1, 10], 4, 4)
A_rand = randi([1, 10], 4, 4);
[rows, cols] = size(A_rand);
trace_val = 0;

for i = 1:rows
    for j = 1:cols
        if i == j
            trace_val = trace_val + A_rand(i, j); % Cộng dồn các phần tử trên đường chéo chính
        end
    end
end
disp('1a. Ma trận A khởi tạo ngẫu nhiên:');
disp(A_rand);
fprintf('    Vết của ma trận (tính bằng 2 vòng for): %d\n', trace_val);
fprintf('    Kiểm tra lại bằng hàm trace(A): %d\n\n', trace(A_rand));

% b. Tìm k nhỏ nhất để A^k(1,1) < 0.1
A_pow = [0.5, 0.2; ...
    0.1, 0.8];
k = 1;
A_k = A_pow; % Khởi tạo A^1

% Vòng lặp while chạy chừng nào phần tử (1,1) vẫn >= 0.1
while A_k(1, 1) >= 0.1
    k = k + 1;
    A_k = A_pow^k; 
end

fprintf('1b. Số k nhỏ nhất để phần tử A^k(1,1) < 0.1 là: k = %d\n', k);
fprintf('    Kiểm tra giá trị A^%d(1,1) = %f\n\n', k, A_k(1,1));


%% ------------------------------------------------------------------------
% BÀI 2: BÀI TẬP PLOT
% ------------------------------------------------------------------------
disp('=== BÀI 2 ===');

% Hệ phương trình:
% d1: 2x - y = 1
% d2: x + 2y = 8
A_sys = [2, -1; ...
    1,  2];
B_sys = [1; 8];

% a. Tìm giao điểm của 2 đường thẳng (Tìm X để A_sys * X = B_sys)
X = A_sys \ B_sys; % Giải hệ bằng toán tử \
fprintf('2a. Tọa độ giao điểm M(x, y) là: x = %.2f, y = %.2f\n', X(1), X(2));

% b. Vẽ đồ thị
% Rút y theo x để vẽ:
% d1: y = 2x - 1
% d2: y = (8 - x) / 2
x_vals = linspace(0, 5, 100);
y1 = 2 * x_vals - 1;
y2 = (8 - x_vals) / 2;

figure('Name', 'Giao diem 2 duong thang d1 va d2');
% d1: đường liền xanh (-b)
plot(x_vals, y1, '-b', 'LineWidth', 1.5); hold on;
% d2: đường nét đứt đỏ (--r)
plot(x_vals, y2, '--r', 'LineWidth', 1.5);
% M: chấm tròn đen (ko) với MarkerFaceColor làm đặc ruột
plot(X(1), X(2), 'ko', 'MarkerFaceColor', 'k', 'MarkerSize', 7);
hold off;

% Format đồ thị theo yêu cầu đề bài
grid on;
title('Đồ thị giao điểm của hai đường thẳng d_1 và d_2');
xlabel('Trục x');
ylabel('Trục y');
legend('Đường thẳng d_1', 'Đường thẳng d_2', 'Giao điểm M', 'Location', 'best');

disp('=== HẾT ===');