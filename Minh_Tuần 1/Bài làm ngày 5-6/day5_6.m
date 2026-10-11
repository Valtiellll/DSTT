% BÀI 1: 
% ------------------------------------------------------------------------
disp('=== BÀI 1 ===');

% Nhiệm vụ 1: Xử lý ma trận A
A = randi([-10, 10], 4, 5);
disp('Ma trận A ban đầu:');
disp(A);

[rows, cols] = size(A);
for i = 1:rows
    for j = 1:cols
        if A(i, j) < 0
            A(i, j) = 0;
        elseif A(i, j) == 0
            continue;
        else % A(i, j) > 0
            % Giữ nguyên
        end
    end
end
disp('Ma trận A sau khi xử lý (thay số âm bằng 0):');
disp(A);

% Nhiệm vụ 2: Vòng lặp while tính tổng chuỗi S = sum(1/k^2)
S = 0;
k = 1;
while k <= 1000
    S = S + 1/(k^2);
    if S > 1.5
        fprintf('Tổng S đã vượt quá 1.5 tại bước k = %d. Giá trị S = %f\n', k, S);
        break;
    end
    k = k + 1;
end
if k > 1000
    fprintf('Đã đạt giới hạn 1000 bước lặp. Giá trị S = %f\n', S);
end


% BÀI 2: 
% ------------------------------------------------------------------------
disp('=== BÀI 2 ===');

% Tạo vector x từ -5 đến 5, bước nhảy 0.1
x_vec = -5:0.1:5;

% Gọi hàm compute_signal
[y_vec, max_y] = compute_signal(x_vec);

fprintf('Giá trị lớn nhất của tín hiệu y (max_val) là: %f\n', max_y);


% BÀI 3: LOGICAL INDEXING VỚI BẢNG ĐIỂM
% ------------------------------------------------------------------------
disp('=== BÀI 3 ===');

Grades = [
    8.5, 7.0, 9.0, 6.5, 8.0;
    5.0, 6.5, 4.0, 7.0, 5.5;
    9.0, 9.5, 8.5, 10.0, 9.0;
    6.0, 8.0, 7.5, 7.0, 6.5
    ];
students = ["SV1", "SV2", "SV3", "SV4"];

% a. Tính điểm trung bình của từng sinh viên (theo hàng)
avg_scores = mean(Grades, 2);

disp('Điểm trung bình của các sinh viên:');
for i = 1:length(students)
    fprintf('%s: %.2f\n', students(i), avg_scores(i));
end

% b. Sử dụng Logical Indexing tìm sinh viên đạt loại Giỏi/Khá (avg_scores >= 7.0)
logic_idx = avg_scores >= 7.0; % Tạo mảng logic
good_students = students(logic_idx); % Trích xuất tên dựa trên logic_idx

disp('Danh sách sinh viên đạt loại Giỏi/Khá (Điểm TB >= 7.0):');
disp(good_students);

disp('=== HẾT ===');