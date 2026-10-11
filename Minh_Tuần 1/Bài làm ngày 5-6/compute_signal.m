function [y, max_val] = compute_signal(x)
% Hàm nhận vector x, tính y và tìm max_val
% Khởi tạo vector y cùng kích thước với x
n = length(x);
y = zeros(1, n);

% Duyệt qua từng phần tử của x
for i = 1:n
    % Tính y theo công thức y = sqrt(|x|) + sin(x) * e^(-0.1x)
    y(i) = sqrt(abs(x(i))) + sin(x(i)) * exp(-0.1 * x(i));
end

% Tìm giá trị lớn nhất của y
max_val = max(y);
end