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
    ( r_no int not null auto_increment
    , r_red int not null
    , r_black int not null
    , r_color enum('red', 'black') not null
    , primary key (r_no)
    , foreign key (r_red) references user(u_no)
      on delete cascade on update cascade
    , foreign key (r_black) references user(u_no)
      on delete cascade on update cascade
);

create table motion
    ( m_seq int not null auto_increment
    , m_color enum('red', 'black') not null
    , m_srcXY tinyint not null
    , m_dstXY tinyint not null
    , m_room int not null
    , primary key (m_seq, m_room)
    , foreign key (m_room) references room(r_no)
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

insert into room values (null, 1, 3, 'red');
select * from room;

select * from motion;
