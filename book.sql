create table books (book_id number,book_name varchar2(100) not null,author_name varchar2(100)not null,
price number not null,publisher varchar2(100)not null,version number,category varchar2(50)not null,active number,
constraint book_id_pk primary key(book_id),
constraint price_ck check (price>=0),
constraint book_id_uq unique(book_id,book_name,author_name,version),
constraint active_ck check (active in (0,1))
);
select * from books;
insert into books(book_id,book_name,author_name,price,publisher,version,category,active) values(1,'let us c','Yashavant Kanetkar',299,'millinium',2,'technical',1);
insert into books(book_id,book_name,author_name,price,publisher,version,category,active) values(2,'let us java','Yashavant Kanetkar',399,'millinium',4,'technical',0);
insert into books(book_id,book_name,author_name,price,publisher,version,category,active) values(3,'code complete','steve',896,'jack publications',3,'technical',1);
select * from books order by book_id ASC;
create table orders(order_id number,user_name varchar2(30) not null,book_id number not null,ordered_date timestamp default systimestamp not null,
delivered_date timestamp default systimestamp not null,
total_amt number not null,qty number not null,status varchar2(30)not null,comments varchar2(500) not null,
constraint order_id_pk primary key(order_id),
constraint book_id_fk foreign key(book_id) references books(book_id),
constraint total_amt check (total_amt>=0),
constraint qty_ck check(qty>=1),
constraint status_ck check (status in ('delivered','cancel','shipping','not available')),
constraint order_id_uq unique(user_name,book_id,ordered_date)
);

insert into orders(order_id,user_name,book_id,total_amt,qty,status,comments) values 
(1,'sundar',1,500,2,'delivered','no comments');
insert into orders(order_id,user_name,book_id,total_amt,qty,status,comments) values 
(2,'Moorthi',2,900,5,'cancel','good');
select * from orders;
select *
from books 
inner join orders
on books.book_id= orders.book_id;
