--ตัวอย่างสร้างตารางร้านพิซซ่าและดึงข้อมูลด้วย SQL

create table customers (
  customer_id int NOT NULL,
  firstname text,
  lastname text,
  gender text
);

create table orders (
  order_id int,
  menu_id int,
  menu_desc text,
  qty int,
  price int,
  customer_id int  
);

create table menu (
  menu_id int,
  menu_desc text,
  menu_type text,
  price int
);

--Insert Data
insert into customers
values (1, 'Jason', 'Bourne', 'M'),
(2, 'Math', 'Bourne', 'F'),
(3,'Ami','Fuua','M');

insert into orders
  values ( 1, 1, 'Pizza', 1, 300, 1),
  (1, 2, 'Hamburger', 2, 100, 2),
  (2, 3, 'French Fries', 3, 30, 3),
  (3, 3, 'French Fries', 2, 30, 2);


insert into menu 
values ( 1, 'Pizza', 'Food', 300),
(2, 'Hamburger', 'Food', 100),
(3, 'French Fries', 'Snack', 30);

-- Query Data
--1. join table ชื่อลูกค้าที่สั่งอาหารและจำนวนที่สั่ง
.mode box
select c.firstname,c.lastname,o.menu_desc,o.qty
from orders as o
  join customers as c on o.customer_id = c.customer_id; 

--2. sub query อยากทราบว่าลูกค้าเพศชายสั่งอะไร และราคาเท่าไหร่
.mode box
select cus_m.gender, order_all.menu_desc,cus_m.firstname,cus_m.lastname, order_all.price
from (select * from customers where gender='M') as cus_m
join (select * from orders ) as order_all
on cus_m.customer_id = order_all.customer_id;

--3. aggeregate function ผลรวมที่ลูกค้าสั่งจำนวนและราคาทั้งหมดเท่าไหร่ เรียงชื่อ,สกุล
.mode box
select c.firstname || ' ' || c.lastname as name,
  count(o.menu_desc) as total_order,
  sum(o.price) as total_price
from customers as c
join orders as o on c.customer_id = o.customer_id
join menu m on o.menu_id = m.menu_id

group by c.firstname || ' ' || c.lastname
order by 1;
