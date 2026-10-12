% Bai 1
A = [1 2; 3 5];
B = [2 1; 1 1];
C = [1 0; 0 1];
D = [5 3; 11 8];

% AXB + C = D => AXB = D - C => X = inv(A) * (D - C) * inv(B)
X = inv(A) * (D - C) * inv(B)

% Bai 2
A2 = [2 -1 1; 1 0 2; 1 4 -2];

% a. Tim nghich dao cua ma tran tren
A2_inv = inv(A2)

% b. Lam cau a nhung khong dung inv() va rref()
A2_inv_alt = A2 \ eye(3)

% Bai 3
v1 = [1; 2; 0; 1];
v2 = [2; 1; 3; 0];
v3 = [0; 1; -1; 2];

% a. Xet tinh DLTT/PTTT khi m = 1
m_a = 1;
v4_a = [1; 0; 1; m_a];
M_a = [v1, v2, v3, v4_a];
det_M_a = det(M_a)
% Ket luan: Vi det_M_a = 12 khac 0, he vector doc lap tuyen tinh (DLTT).

% b. Tim m de he vector phu thuoc tuyen tinh (PTTT)
syms m
v4_b = [1; 0; 1; m];
M_b = [v1, v2, v3, v4_b];
m_phu_thuoc = solve(det(M_b) == 0, m)

% c. Lam cau b trong MATLAB nhung khong dung ham det()
% V1, v2, v3 doc lap tuyen tinh. He PTTT khi v4 la to hop tuyen tinh cua v1, v2, v3.
% Giai he 3 phuong trinh dau de tim he so to hop tuyen tinh (c)
V = [v1, v2, v3];
M_3 = V(1:3, :); 
b_3 = [1; 0; 1]; 

c = M_3 \ b_3;

% The cac he so c1, c2, c3 vao phuong trinh thu 4 de tim m
m_khong_det = V(4, :) * c