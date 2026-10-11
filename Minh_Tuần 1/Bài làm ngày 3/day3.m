% BÀI 1: KHÔNG GIAN R4 - TỔ HỢP TUYẾN TÍNH
% ------------------------------------------------------------------------
disp('=== BÀI 1 ===');
u1 = [1; 2; -1; 3];
u2 = [2; 1; 0; -2];
u3 = [0; 3; -2; 8];

% a. Biện luận theo x để v là tổ hợp tuyến tính của {u1, u2, u3}
syms x
v = [x; -1; 3; 2];

% Ghép thành ma trận mở rộng M = [u1, u2, u3, v] kích thước 4x4
M = [u1, u2, u3, v];
det_M = det(M);
fprintf('1a. Định thức của ma trận hệ số mở rộng det(M) = %s\n', char(det_M));

% Để v là THTT của {u1, u2, u3}, hệ phương trình phải có nghiệm
% Tức là rank(U) = rank([U, v]), đồng nghĩa det(M) phải bằng 0
x_sol = solve(det_M == 0, x);
if isempty(x_sol)
    disp('  => KẾT LUẬN: Phương trình det(M) = 0 vô nghiệm.');
    disp('  => Không tồn tại giá trị nào của x để v là tổ hợp tuyến tính của {u1, u2, u3}.');
else
    fprintf('  => KẾT LUẬN: Giá trị của x là: %s\n', char(x_sol));
end

% b. Xét tính ĐLTT hay PTTT của bộ {u1, u2, u3}
U_b = [u1, u2, u3];
rank_U = rank(U_b);
fprintf('\n1b. Hạng của ma trận U = [u1, u2, u3] là: %d\n', rank_U);
if rank_U == 3
    disp('  => KẾT LUẬN: Bộ 3 vector {u1, u2, u3} ĐỘC LẬP TUYẾN TÍNH.');
else
    disp('  => KẾT LUẬN: Bộ 3 vector {u1, u2, u3} PHỤ THUỘC TUYẾN TÍNH.');
end


% BÀI 2: 
% ------------------------------------------------------------------------
disp('=== BÀI 2 ===');
syms m
A2 = [1 2 -1; 2 m 1; 1 0 3];

% a. Tính định thức det(A) và tìm m để A khả nghịch
det_A2 = det(A2);
fprintf('2a. Định thức của A theo m: det(A) = %s\n', char(det_A2));

m_singular = solve(det_A2 == 0, m);
fprintf('    A khả nghịch khi det(A) ~= 0 => m KHÁC %s\n', char(m_singular));

% b. Với m = 3
m_val = 3;
A3 = double(subs(A2, m, m_val)); % Thay m = 3 và ép kiểu số thực
disp('2b. Thay m = 3, ta có ma trận A:');
disp(A3);

A3_T = A3';
disp('    Ma trận chuyển vị A^T:');
disp(A3_T);

A3_inv = inv(A3);
disp('    Ma trận nghịch đảo A^(-1):');
disp(A3_inv);

% Tính C = A^2 - 2A + I3
C = A3^2 - 2*A3 + eye(3);
disp('    Ma trận C = A^2 - 2A + I_3:');
disp(C);


% BÀI 3: 
% ------------------------------------------------------------------------
disp('=== BÀI 3 ===');
% Đề yêu cầu tạo ma trận 4x5 và tính định thức.
% NHƯNG: Chỉ ma trận vuông mới có định thức! 
disp('Khởi tạo ma trận A ngẫu nhiên kích thước 4x5:');
A_4x5 = randi([-5, 5], 4, 5);
disp(A_4x5);

disp('Thử gọi hàm my_det cho ma trận 4x5:');
det_4x5 = my_det(A_4x5);

disp('---');
disp('Để test xem hàm my_det hoạt động đúng thuật toán, ta trích xuất ma trận con 4x4:');
A_4x4 = A_4x5(:, 1:4);
det_4x4_custom = my_det(A_4x4);
det_4x4_matlab = det(A_4x4);

fprintf(' -> Định thức tính bằng hàm my_det (for loop): %d\n', det_4x4_custom);
fprintf(' -> Định thức tính bằng hàm det() của MATLAB: %d\n', det_4x4_matlab);

disp('=== HẾT ===');