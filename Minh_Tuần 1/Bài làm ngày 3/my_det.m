function d = my_det(A)
% Hàm tính định thức bằng vòng lặp (khai triển Laplace theo hàng 1)
[r, c] = size(A);
if r ~= c
    disp('  -> LỖI: Ma trận không vuông! Định thức không xác định. Trả về NaN.');
    d = NaN;
    return;
end
% Điều kiện dừng đệ quy
if r == 1
    d = A(1, 1);
elseif r == 2
    d = A(1,1)*A(2,2) - A(1,2)*A(2,1);
else
    d = 0;
    for j = 1:c
        subA = A;
        subA(1, :) = []; % Khử hàng 1
        subA(:, j) = []; % Khử cột j
        % Cộng dồn phần bù đại số
        d = d + ((-1)^(1+j)) * A(1, j) * my_det(subA);
    end
end
end