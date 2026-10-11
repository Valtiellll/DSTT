function inv_M = random_inv(n)
    % Hàm sinh ma trận ngẫu nhiên n x n và trả về ma trận nghịch đảo 
    % Input: n (kích thước ma trận n x n)
    % Output: inv_M (ma trận nghịch đảo)
    % Sinh ma trận số nguyên ngẫu nhiên trong khoảng [-10, 10]
    M = randi([-10, 10], n, n);
    % Kiểm tra ma trận có khả nghịch không ( hay định thức khác 0)
    while det(M) == 0
        M = randi([-10, 10], n, n);
    end
    % Tính ma trận nghịch đảo
    inv_M = inv(M);
end