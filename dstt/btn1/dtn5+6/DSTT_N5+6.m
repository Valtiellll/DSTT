% --- Bài 1 ---
A = randi([-10, 10], 4, 5);
[hang, cot] = size(A);

for i = 1:hang
    for j = 1:cot
        if A(i,j) < 0
            A(i,j) = 0;
        elseif A(i,j) == 0
            continue;
        else
            % Giữ nguyên nếu > 0
        end
    end
end

S = 0;
k = 1;
while k <= 1000
    S = S + 1 / (k^2);
    if S > 1.5
        disp(['Tổng S vượt quá 1.5 tại k = ', num2str(k)]);
        break;
    end
    k = k + 1;
end

% --- Bài 2 (Script chính) ---
x_vec = -5:0.1:5;
[y_vec, max_val_result] = compute_signal(x_vec);
disp(['Giá trị lớn nhất của y là: ', num2str(max_val_result)]);

% --- Bài 3 ---
Grades = [
    8.5, 7.0, 9.0, 6.5, 8.0;
    5.0, 6.5, 4.0, 7.0, 5.5;
    9.0, 9.5, 8.5, 10.0, 9.0;
    6.0, 8.0, 7.5, 7.0, 6.5
];
students = ["SV1", "SV2", "SV3", "SV4"];

% a. Xử lí ma trận
avg_scores = mean(Grades, 2);
sv_gioi_kha = students(avg_scores >= 7.0);
disp('Danh sách sinh viên đạt loại Giỏi/Khá:');
disp(sv_gioi_kha);

% b. Vẽ đồ thị
figure;
bar(avg_scores);
xticklabels(students); % Thiết lập tên hiển thị trục X
xlabel('Sinh viên');
ylabel('Điểm trung bình');
title('Bảng thống kê điểm trung bình học kỳ');
grid on;
legend('Điểm TB');

% --- Hàm cho Bài 2 (Đặt ở cuối script hoặc lưu thành file compute_signal.m) ---
function [y, max_val] = compute_signal(x)
    y = zeros(size(x));
    for i = 1:length(x)
        y(i) = sqrt(abs(x(i))) + sin(x(i)) * exp(-0.1 * x(i));
    end
    max_val = max(y);
end