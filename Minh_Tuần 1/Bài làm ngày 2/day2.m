% BÀI 1: 
% ------------------------------------------------------------------------
disp('=== BÀI 1 ===');
A = [1 2; 3 5];
B = [2 1; 1 1];
C = [1 0; 0 1];
D = [5 3; 11 8];

% Biến đổi toán học:
% AXB + C = D <=> AXB = D - C <=> X = A^(-1) * (D - C) * B^(-1)
% Trong MATLAB: kết hợp toán tử chia trái \ và chia phải /
X1 = (A \ (D - C)) / B;
disp('Ma trận nghiệm X:');
disp(X1);


% BÀI 2: 
% ------------------------------------------------------------------------
disp('=== BÀI 2 ===');
A2 = [2 -1 1; 1 0 2; 1 4 -2];

% a. Dùng hàm inv() mặc định
inv_A2 = inv(A2);
disp('2a. Ma trận nghịch đảo dùng inv():');
disp(inv_A2);

% b. (Nâng cao) Không dùng inv() và rref(): Triển khai 2 phương pháp
disp('2b. (Nâng cao) Tìm nghịch đảo không dùng inv() và rref():');

% Phương pháp 1: Khử Gauss giải hệ A * X = I qua toán tử chia trái \
inv_A_pp1 = A2 \ eye(3);
disp('  + Phương pháp 1 (Toán tử chia trái \):');
disp(inv_A_pp1);

% Phương pháp 2: Tự dựng ma trận phụ hợp đại số (Adjugate matrix) bằng vòng lặp
% Công thức: A^(-1) = (1 / det(A)) * C^T
[n, ~] = size(A2);
C_mat = zeros(n, n);
for i = 1:n
    for j = 1:n
        subA = A2;
        subA(i, :) = []; % Khử hàng i
        subA(:, j) = []; % Khử cột j
        C_mat(i, j) = ((-1)^(i + j)) * det(subA); % Phần bù đại số C_ij
    end
end
inv_A_pp2 = (C_mat') / det(A2);
disp('  + Phương pháp 2 (Ma trận phụ hợp Adjugate):');
disp(inv_A_pp2);


% BÀI 3:
% ------------------------------------------------------------------------
disp('=== BÀI 3 ===');
v1 = [1; 2; 0; 1];
v2 = [2; 1; 3; 0];
v3 = [0; 1; -1; 2];

% a. Xét tính ĐLTT / PTTT khi m = 1
m_a = 1;
v4_a = [1; 0; 1; m_a];
V_a = [v1, v2, v3, v4_a]; 

det_val = det(V_a);
fprintf('3a. Khi m = 1:\n  det(V) = %d\n', det_val);
if det_val ~= 0
    disp('  => Kết luận: Họ vector ĐỘC LẬP TUYẾN TÍNH (ĐLTT).');
else
    disp('  => Kết luận: Họ vector PHỤ THUỘC TUYẾN TÍNH (PTTT).');
end

% b. Tìm m để họ vector PTTT (dùng syms và det = 0)
syms m
v4_sym = [1; 0; 1; m];
V_sym = [v1, v2, v3, v4_sym];

pt = det(V_sym) == 0;
m_pttt = solve(pt, m);
if isempty(m_pttt)
    disp('3b. Tìm m để PTTT (dùng hàm det): m = [] (Không tồn tại m)');
    disp('    -> Giải thích: det(V) = -4 với mọi m. Do det(V) khác 0, họ luôn ĐLTT.');
else
    fprintf('3b. m = %s\n', char(m_pttt));
end

% c. (Nâng cao) Tìm m để PTTT nhưng KHÔNG dùng hàm det()
disp('3c. (Nâng cao) Tìm m để PTTT không dùng det():');

% Phương pháp: Phân tích LU (Khử Gauss về dạng tam giác)
% Nếu PTTT thì phần tử chéo cuối cùng của U phải bằng 0
[~, U_mat] = lu(V_sym);
m_pp = solve(U_mat(4, 4) == 0, m);
if isempty(m_pp)
    disp('  + Phương pháp phân tích tam giác LU: m = [] (Không tồn tại m)');
    disp('  + Giải thích: Hệ vô nghiệm. Các vector độc lập tuyến tính với mọi m.');
end

disp('=== HẾT ===');