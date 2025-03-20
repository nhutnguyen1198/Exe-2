--câu 1 lấy danh sách người dùng theo thứ tự tên theo Alphabet(A->Z)
SELECT *
FROM Users
ORDER BY user_name ASC;
--câu 2 lấy ra 07 người dùng theo thứ tự tên Alphabet(A->Z)
SELECT *
FROM Users
ORDER BY user_name ASC LIMIT 7;
--câu 3 lây ra danh sách người dùng theo thứ tự tên theo Alphebet(A->Z), trong đó tên người dùng có chữ a
SELECT *
FROM Users
WHERE user_name like '%a%'
ORDER BY user_name ASC ;
--câu 4 lấy ra danh sách người dùng trong đó tên người dùng bắt đầu bằng chứ m
SELECT *
FROM Users
WHERE user_name like 'm%';
--câu 5 lấy ra danh sách người dùng trong đó tên người dùng kết thúc bằng chữ i
SELECT *
FROM Users
WHERE user_name like '%i';
--câu 6 lấy ra danh sách người dùng trong đó email người dùng là Gmail
SELECT *
FROM Users
WHERE user_email like '%@gmail.com';
--câu 7 lấy danh sách người dùng trong đó email người dùng là Gmail, tên người dùng bắt đầu bằng chữ m
SELECT *
FROM Users
WHERE user_email like '%@gmail.com' && user_name LIKE 'm%';
--câu 8 lấy danh sách người dùng trong đó email người dùng là Gmail, tên người dùng có chữ i và tên người dùng có chiều dài lớn hơn 5
SELECT *
FROM Users
WHERE user_email LIKE '%@gmail.com'
  AND user_name LIKE '%i%' 
  AND CHAR_LENGTH(user_name) > 5;
--câu 9 lấy ra danh sách người dùng trong đó tên người dùng có chữ a, chiều dài từ 5 đến 9,dùng dịch vụ Gmail trong tên email có chữ I
SELECT * FROM users 
WHERE user_name LIKE '%a%' 
AND CHAR_LENGTH(user_name) BETWEEN 5 AND 9
AND user_email LIKE '%@gmail.com'
AND SUBSTRING_INDEX(user_email, '@', 1) LIKE '%I%';
--câu 10 lấy ra danh sách người dùng trong đó tên người dùng có chữ a, chiều dài từ 5 đến 9 hoặc tên người dùng có chữ i, chiều dài nhỏ hơn 9 hoặc email dùng dịch vụ Gmail, trong tên email có chữ i
SELECT * FROM users 
WHERE (user_name LIKE '%a%' 
AND CHAR_LENGTH(user_name) BETWEEN 5 AND 9)
OR (user_name LIKE '%i%' AND CHAR_LENGTH(user_name) < 9)
OR (user_email LIKE '%@gmail.com'
AND SUBSTRING_INDEX(user_email, '@', 1) LIKE '%I%');
