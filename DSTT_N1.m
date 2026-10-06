 A=[2,-1;1,3]

A =

     2    -1
     1     3

>> 
>> B=[2,3;1,-2]

B =

     2     3
     1    -2

>> I=eye(2)

I =

     1     0
     0     1
// A^-1 là A'; dấu nhân sẽ là *
// disp là lệnh để hiện kết quả của pt
// ta phải gọi X_a vì nếu gọi x không sẽ bị trung với các lệnh khác
// eye(x) là lệnh dùng tạo ma trận đơn vị
>> X_a= (2*B-4*A')/(3*A-2*I)
disp(X_a)

X_a =

   -0.9189   -0.1081
    2.4324   -1.2432

   -0.9189   -0.1081
    2.4324   -1.2432

>> X_b= (A'*B-3*B')/(2*B-3*I)

X_b =

   -0.2632   -0.3684
   -3.2632   -2.3684

>> X_c = sylvester(A, -2*B, 3*A')
#sylvester là định dạng cho PT có dạng AX-XB=C

   -1.6857   -1.0286
   -0.5714    0.9429

>> 