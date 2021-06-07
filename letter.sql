-- vim: ft=mysql

create database letterdb;
use letterdb;

create table user
    ( u_no int not null auto_increment
    , u_name varchar(64) not null
    , u_sex enum('M', 'F') not null
    , u_passwd varchar(64) not null
    , u_regdate char(10) default null
    , u_point int default 0
    , u_round int default 0
    , primary key (u_no)
    , unique (u_name)
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

create table Administrator
    ( name varchar(64) not null
    , password varchar(64) not null
    , primary key (name)
);

insert into user values (null, "刘孙伟", "M", "liu", null, 6, 8);
insert into user values (null, "朱丽娟", "F", "zhu", null, 0, 13);
insert into user values (null, "彭于斌", "F", "pen", null, 4, 10);
insert into user values (null, "尤阳宇", "M", "you", null, 1, 2);
insert into user values (null, "马克思", "M", "max", null, 0, 0);
insert into user values (null, "马舒婷", "F", "shu", null, 0, 1);
insert into user values (null, "马云", "M", "yun", null, 1, 8);
select * from user;

insert into Administrator values ("彭于斌", "sir");
