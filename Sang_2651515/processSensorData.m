
function [B, status, valid, V, I, R, P] = processSensorData(A)

[Ax, Ay] = size(A);

% Trích xuất các vector từ CSV
V = A(:, 5);
I = A(:, 6);
heat = A(:, 3);
mode_code = A(:, Ay);

% Xác định các mẫu hợp lệ
valid = mode_code ~= 0;

% Khởi tạo các vector kết quả bằng zeros
R = zeros(Ax, 1);
P = zeros(Ax, 1);

% Tính công suất cho từng mẫu hợp lệ
P(valid) = V(valid) .* I(valid);

% Chỉ tính điện trở khi mẫu hợp lệ và dòng điện khác 0
nonzero_current = valid & (I ~= 0);
R(nonzero_current) = V(nonzero_current) ./ I(nonzero_current);

% Đánh dấu rõ các mẫu không hợp lệ và điện trở không xác định
P(~valid) = NaN;
R(~valid) = NaN;
R(valid & (I == 0)) = NaN;

% Khởi tạo vector trạng thái cho từng mẫu
status = strings(Ax, 1);

% Phân loại trạng thái dựa trên nhiệt độ
for i = 1:Ax
    if ~valid(i)
        status(i) = "INVALID";

    elseif heat(i) >= 33
        status(i) = "HIGH_TEMP";

    elseif heat(i) < 25
        status(i) = "LOW_TEMP";

    else
        status(i) = "NORMAL";
    end
end

% Tạo ma trận B, thêm 2 cột lưu điện trở và công suất
B = [A, zeros(Ax, 2)];

B(:, Ay + 1) = R;
B(:, Ay + 2) = P;

end
