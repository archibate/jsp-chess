-- vim: ft=mysql

create database letterdb;
use letterdb;

create table user
    ( u_no int not null auto_increment
    , u_name varchar(64) not null
    , u_sex enum('男', '女') not null
    , u_age int not null
    , u_passwd varchar(64) not null
    , primary key (u_no)
);

create table room
    ( r_owner int not null
    , r_guest int default null
    , r_ownerColor enum('red', 'black') not null default 'red'
    , r_color enum('red', 'black') not null default 'red'
    , r_state char(64) not null default '0010203040506070800312234363728309192939495969798906172646667786'
    , primary key (r_owner)
    , foreign key (r_owner) references user(u_no)
      on delete cascade on update cascade
    , foreign key (r_guest) references user(u_no)
      on delete cascade on update cascade
);

insert into user values (null, "刘孙伟", "男", 19, "liu");
insert into user values (null, "朱丽娟", "女", 95, "zhu");
insert into user values (null, "彭于斌", "女", 19, "pen");
insert into user values (null, "尤阳宇", "男", 19, "you");
insert into user values (null, "马克思", "男", 99, "max");
insert into user values (null, "马舒婷", "女", 36, "shu");
insert into user values (null, "马云", "男", 996, "yun");
select * from user;
