--1 Liệt kê các hóa đơn của khách hàng, thông tin hiển thị gồm: mã user, tên user, mã hóa đơn
SELECT u.user_id, u.user_name, o.order_id  
FROM orders o, users u
WHERE o.user_id = u.user_id
--2 Liệt kê số lượng các hóa đơn của khách hàng: mã user, tên user, số đơn hàng
SELECT u.user_id, u.user_name, COUNT(o.order_id) AS total_orders  
FROM orders o, users u  
WHERE o.user_id = u.user_id  
GROUP BY u.user_id, u.user_name;
--3 Liệt kê thông tin hóa đơn: mã đơn hàng, số sản phẩm
SELECT od.order_id, COUNT(od.product_id) AS total_products  
FROM order_details od  
GROUP BY od.order_id
--4 Liệt kê thông tin mua hàng của người dùng: mã user, tên user, mã đơn hàng, tên sản phẩm. Lưu ý: gôm nhóm theo đơn hàng, tránh hiển thị xen kẻ các đơn hàng với nhau
SELECT u.user_id, u.user_name, o.order_id, GROUP_CONCAT(p.product_name SEPARATOR ', ') AS products  
FROM users u  
JOIN orders o ON u.user_id = o.user_id  
JOIN order_details od ON o.order_id = od.order_id  
JOIN products p ON od.product_id = p.product_id  
GROUP BY u.user_id, u.user_name, o.order_id  
ORDER BY o.order_id;
--5 Liệt kê 7 người dùng có số lượng đơn hàng nhiều nhất, thông tin hiển thị gồm: mã user, tên user, số lượng đơn hàng
SELECT u.user_id, u.user_name, COUNT(o.order_id) AS total_orders  
FROM users u  
JOIN orders o ON u.user_id = o.user_id  
GROUP BY u.user_id, u.user_name  
ORDER BY total_orders DESC  
LIMIT 7
--6 Liệt kê 7 người dùng mua sản phẩm có tên: Samsung hoặc Apple trong tên sản phẩm, thông tin hiển thị gồm: mã user, tên user, mã đơn hàng, tên sản phẩm
SELECT DISTINCT u.user_id, u.user_name, o.order_id, p.product_name  
FROM users u  
JOIN orders o ON u.user_id = o.user_id  
JOIN order_details od ON o.order_id = od.order_id  
JOIN products p ON od.product_id = p.product_id  
WHERE p.product_name LIKE '%Samsung%' OR p.product_name LIKE '%Apple%'  
LIMIT 7;
--7 Liệt kê danh sách mua hàng của user bao gồm giá tiền của mỗi đơn hàng, thông tin hiển thị gồm: mã user, tên user, mã đơn hàng, tổng tiền
SELECT u.user_id, u.user_name, o.order_id AS, o.total_amount
FROM 
    users u
JOIN 
    orders o ON u.user_id = o.user_id;
--8 Liệt kê danh sách mua hàng của user bao gồm giá tiền của mỗi đơn hàng, thông tin hiển thị gồm: mã user, tên user, mã đơn hàng, tổng tiền. Mỗi user chỉ chọn ra 1 đơn hàng có giá tiền lớn nhất.
SELECT 
    u.user_id, u.user_name, o.order_id, o.total_amount
FROM 
    users u
JOIN 
    orders o ON u.user_id = o.user_id
WHERE 
    o.total_amount = (
        SELECT MAX(o2.total_amount)
        FROM orders o2
        WHERE o2.user_id = u.user_id
    );
--9 Liệt kê danh sách mua hàng của user bao gồm giá tiền của mỗi đơn hàng, thông tin hiển thị gồm: mã user, tên user, mã đơn hàng, tổng tiền, số sản phẩm. Mỗi user chỉ chọn ra 1 đơn hàng có giá tiền nhỏ nhất.
SELECT 
	u.user_id, u.user_name, o.order_id AS, o.total_amount AS, COUNT(od.product_id) AS 'So San Pham'
FROM 
    users u
JOIN 
    orders o ON u.user_id = o.user_id
JOIN 
    order_details od ON o.order_id = od.order_id
WHERE 
    o.total_amount = (
        SELECT MIN(o2.total_amount)
        FROM orders o2
        WHERE o2.user_id = u.user_id
    )
GROUP BY 
    u.user_id, u.user_name, o.order_id, o.total_amount;
--10 Liệt kê danh sách mua hàng của user bao gồm giá tiền của mỗi đơn hàng, thông tin hiển thị gồm: mã user, tên user, mã đơn hàng, tổng tiền, số sản phẩm. Mỗi user chỉ chọn ra 1 đơn hàng có số sản phẩm là nhiều nhất.
SELECT 
	u.user_id, u.user_name, o.order_id, o.total_amount, COUNT(od.product_id)
FROM 
    users u
JOIN 
    orders o ON u.user_id = o.user_id
JOIN 
    order_details od ON o.order_id = od.order_id
GROUP BY 
    u.user_id, u.user_name, o.order_id, o.total_amount
HAVING 
    COUNT(od.product_id) = (
        SELECT COUNT(od2.product_id)
        FROM order_details od2
        JOIN orders o2 ON od2.order_id = o2.order_id
        WHERE o2.user_id = u.user_id
        GROUP BY o2.order_id
        ORDER BY COUNT(od2.product_id) DESC
        LIMIT 1
    );