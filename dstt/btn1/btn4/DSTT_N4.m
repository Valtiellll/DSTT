% Bai 1a
A = randi([1, 10], 4, 4);
trace_A = 0;
for i = 1:4
    for j = 1:4
        if i == j
            trace_A = trace_A + A(i,j);
        end
    end
end
disp('Trace cua ma tran A la:');
disp(trace_A);

% Bai 1b
A_1b = [0.5 0.2; 0.1 0.8];
k = 1;
A_k = A_1b;
while A_k(1,1) >= 0.1
    k = k + 1;
    A_k = A_1b^k;
end
disp('Gia tri k nho nhat la:');
disp(k);

% Bai 2a
% He phuong trinh:
% 2x - y = 1
% x + 2y = 8
A_2 = [2 -1; 1 2];
B_2 = [1; 8];
X = A_2 \ B_2; 
x_giao = X(1);
y_giao = X(2);
disp('Giao diem M co toa do:');
disp([x_giao, y_giao]);

% Bai 2b
x_val = -2:0.1:5;
% Rut y theo x tu phuong trinh
y1 = 2*x_val - 1;
y2 = (8 - x_val)/2;

figure;
plot(x_val, y1, 'b-', 'LineWidth', 1.5); % d1 la duong lien xanh
hold on;
plot(x_val, y2, 'r--', 'LineWidth', 1.5); % d2 la duong net dut do
plot(x_giao, y_giao, 'ko', 'MarkerFaceColor', 'k', 'MarkerSize', 8); % Giao diem M cham tron den

xlabel('Truc x');
ylabel('Truc y');
title('Do thi giao diem cua d1 va d2');
legend('d1: 2x - y = 1', 'd2: x + 2y = 8', 'Giao diem M');
grid on;
hold off;