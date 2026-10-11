% BÀI LÀM NGÀY 1
% BÀI 1:
disp('=== BÀI 1 ===');
A1 = [3 -1; 2 1];
% a. Tính vết tr(A * A^T)
% A' là chuyển vị của A, trace() là hàm tính vết (tổng đường chéo chính), phép %d là ký hiệu đại diện cho một số nguyên, \n là xuống dòng
ans_1a = trace(A1 * A1');
fprintf('1a. Vết tr(A * A^T) = %d\n', ans_1a);
% b. Tính f(A) với f(x) = x^2 - 4x + 5
% Khi thay ma trận vào đa thức, hệ số tự do 5 phải nhân với ma trận đơn vị eye(2)
f_A = A1^2 - 4*A1 + 5*eye(2);
disp('1b. Ma trận f(A):');
disp(f_A);
% BÀI 2: 
disp('=== BÀI 2 ===');
A2 = [2 -1; 1 3];
B2 = [2 3; 1 -2];
I2 = eye(2);
% a/ 3XA + 4A^T = 2B - 2X
% Biến đổi: 3XA + 2X = 2B - 4A^T <=> X*(3A + 2I) = 2B - 4A^T
% => X = (2B - 4A^T) / (3A + 2I) (dùng toán tử chia phải /)
Xa = (2*B2 - 4*A2') / (3*A2 + 2*I2);
disp('2a. Nghiệm X câu a/:');
disp(Xa);
% b/ B(2X - A^T) = 3B^T + 3X
% Biến đổi: 2BX - B*A^T = 3B^T + 3X <=> (2B - 3I)*X = 3B^T + B*A^T
% => X = (2B - 3I) \ (3B^T + B*A^T) (dùng toán tử chia trái "\" theo phép toán khử Gauss)
Xb = (2*B2 - 3*I2) \ (3*B2' + B2*A2');
disp('2a. Nghiệm X câu b/:');
disp(Xb);
% c/ AX - 2XB = 3A^T
% Phương trình dạng Sylvester: A*X + X*(-2B) = 3A^T
% Dùng hàm sylvester(A, B, C) giải A*X + X*B = C
Xc = sylvester(A2, -2*B2, 3*A2');
disp('2a. Nghiệm X câu c/:');
disp(Xc);
% Mục b: Thay A và B bằng ma trận 3x3 ngẫu nhiên
disp('--- Bài 2b: Tính với ma trận ngẫu nhiên 3x3 ---');
A_rand = randi([-5, 5], 3, 3);
B_rand = randi([-5, 5], 3, 3);
I3 = eye(3);
Xa_rand = (2*B_rand - 4*A_rand') / (3*A_rand + 2*I3);
Xb_rand = (2*B_rand - 3*I3) \ (3*B_rand' + B_rand*A_rand');
Xc_rand = sylvester(A_rand, -2*B_rand, 3*A_rand');

disp('Nghiệm Xa ngẫu nhiên:'); disp(Xa_rand);
disp('Nghiệm Xb ngẫu nhiên:'); disp(Xb_rand);
disp('Nghiệm Xc ngẫu nhiên:'); disp(Xc_rand);

% BÀI 3: 
disp('=== BÀI 3 ===');
A3 = [1 0 2; 2 1 1; 0 3 1];
% Tìm ma trận nghịch đảo bằng hàm inv()
inv_A3 = inv(A3);
disp('Ma trận nghịch đảo của A:');
disp(inv_A3);
% Bonus: Gọi thử function random_inv đã viết
disp('Bonus: Ma trận nghịch đảo kích thước 4x4 sinh ngẫu nhiên:');
inv_bonus = random_inv(4);
disp(inv_bonus);

disp('=== HẾT ===');