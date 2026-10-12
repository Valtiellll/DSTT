% Bai 1
u1 = [1; 2; -1; 3];
u2 = [2; 1; 0; -2];
u3 = [0; 3; -2; 8];

% Lấy 3 hàng cuối đã biết của vector v
v_biet = [-1; 3; 2]; 
U_biet = [u1(2:4), u2(2:4), u3(2:4)];

% a. Tim x de v bieu dien duoc duoi dang to hop tuyen tinh
c = U_biet \ v_biet;
x = [u1(1), u2(1), u3(1)] * c

% b. Xet tinh doc lap tuyen tinh hay phu thuoc tuyen tinh
U = [u1, u2, u3];
hang_U = rank(U) % Neu hang bang 3, he doc lap tuyen tinh


% Bai 2
syms m
A = [1 2 -1; 2 m 1; 1 0 3];

% a. Tinh dinh thuc theo m va tim m de A kha nghich
detA = det(A)
m_khong_kha_nghich = solve(detA == 0, m)
% Ma tran A kha nghich khi m khac voi gia tri m_khong_kha_nghich

% b. Tinh toan voi m = 3
A_3 = subs(A, m, 3);
A_3 = double(A_3); % Chuyen doi tu kieu symbol sang kieu so

A_chuyen_vi = A_3'
A_nghich_dao = inv(A_3)
C = A_3^2 - 2*A_3 + eye(3)


% Bai 3
A_rand = rand(4,5);

% Luu y: Ma tran 4x5 khong phai ma tran vuong nen khong the tinh dinh thuc.
% Duoi day la ham tinh dinh thuc theo cach truyen thong (Laplace) cho ma tran vuong.

function d = tinh_det(M)
    [hang, cot] = size(M);
    if hang ~= cot
        error('Ma tran phai la ma tran vuong de tinh dinh thuc.');
    end
    
    if hang == 1
        d = M(1,1);
    elseif hang == 2
        d = M(1,1)*M(2,2) - M(1,2)*M(2,1);
    else
        d = 0;
        for j = 1:cot
            % Tao ma tran con bang cach xoa hang 1 va cot j
            ma_tran_con = M(2:end, [1:j-1, j+1:end]);
            d = d + (-1)^(1+j) * M(1,j) * tinh_det(ma_tran_con);
        end
    end
end