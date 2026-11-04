%% LƯU Ý: KHÔNG CHẠY FILE NÀY, CHẠY FILE main_test_mod1_2.m 

function [Omega_train, Omega_test, U_k, mu, eigenvalues, U_full, Omega_train_full, Omega_test_full] = module2_core_pca(X_train, X_test, k)
%  MODULE 2: CORE PCA & EIGENFACES 
%  Input : X_train, X_test, k
%  Output  : Omega_train, Omega_test, U_k, mu, eigenvalues (và các bản _full)

    % BƯỚC 1: TÍNH KHUÔN MẶT TRUNG BÌNH (mu) & LỌC LẤY "PHẦN NÉT RIÊNG" (A)
    % Cộng trung bình 280 cột của X_train để tìm khuôn mặt chung nhất, 
    % sau đó lấy mặt từng người trừ đi mặt chung để chỉ giữ lại nét khác biệt riêng.
    mu = mean(X_train, 2);          
    
    A_train = X_train - mu;         % Trừ khuôn mặt trung bình cho ảnh trong nhóm train.
    A_test  = X_test - mu;          % Trừ khuôn mặt trung bình cho ảnh trong nhóm test.

    % BƯỚC 2: LẬP MA TRẬN HIỆP PHƯƠNG SAI RÚT GỌN (MẸO A^T * A)
    % Thay vì so sánh từng điểm ảnh với nhau,
    % ta so sánh độ giống nhau giữa bức ảnh với nhau -> bảng L nhỏ gọn.
    L = A_train' * A_train;         

    % BƯỚC 3: TÌM TRỊ RIÊNG (ĐIỂM QUAN TRỌNG) & VECTOR RIÊNG, SẮP XẾP TỪ CAO XUỐNG THẤP
    % Tại sao V trước: Hàm eig() của MATLAB xếp điểm từ nhỏ đến lớn nên phải lật ngược lại.
    [V, D_matrix] = eig(L);
    eigenvalues_raw = diag(D_matrix);                           % Cột điểm số: (số ảnh, 1)
    
    [eigenvalues, sort_idx] = sort(eigenvalues_raw, 'descend'); % Xếp giảm dần
    V = V(:, sort_idx);                                         % Xếp lại cột của V tương ứng

    % BƯỚC 4: TẠO CÁC "NGUYÊN LIỆU GỐC" (EIGENFACES - U) & CHUẨN HÓA ĐỘ DÀI VỀ 1
    % Nhân A_train với V để đưa nguyên liệu từ kích thước từ cột điểm về lại bức ảnh.
    U_full = A_train * V;           
    
    for i = 1:size(U_full, 2)
        do_dai_cot = norm(U_full(:, i));
        if do_dai_cot > 1e-10
            U_full(:, i) = U_full(:, i) / do_dai_cot;
        end
    end

    % Cắt lấy đúng k nguyên liệu quan trọng nhất (k cột đầu tiên)
    U_k = U_full(:, 1:k);          

    % BƯỚC 5: CHIẾU LÊN KHÔNG GIAN ĐẶC TRƯNG 
    % Đo xem mỗi bức ảnh chứa bao nhiêu liều lượng của từng nguyên liệu gốc
    Omega_train_full = U_full' * A_train;   
    Omega_test_full  = U_full' * A_test;    

    Omega_train = Omega_train_full(1:k, :); % Kích thước: k x số ảnh train 
    Omega_test  = Omega_test_full(1:k, :);  % Kích thước: k x số ảnh test 

   
end