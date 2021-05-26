-- vim: ft=mysql

create or replace database letterdb;
use letterdb;

create or replace table department
    ( d_no int not null auto_increment
    , d_name varchar(32) not null
    , primary key (d_no)
);

create or replace table student
    ( s_no int not null auto_increment
    , s_name varchar(32) not null
    , s_sex varchar(8) not null
    , s_age int not null
    , s_dept int not null
    , s_passwd varchar(32) not null
    , primary key (s_no)
    , foreign key (s_dept) references department(d_no)
    , check (s_sex in ('男', '女'))
);

create or replace table administrator
    ( a_no int not null auto_increment
    , a_name varchar(32) not null
    , a_passwd varchar(32) not null
    , primary key (a_no)
);

create or replace table message
    ( m_no int not null auto_increment
    , m_title varchar(32) not null
    , m_content varchar(1024) not null
    , m_sender int not null
    , m_recver int not null
    , primary key (m_no)
    , foreign key (m_sender) references student(s_no)
      on delete cascade on update cascade
    , foreign key (m_recver) references student(s_no)
      on delete cascade on update cascade
);

insert into department values (null, "星系学院");
insert into department values (null, "太空军校");
insert into department values (null, "马克思学院");
insert into department values (null, "量子学院");
insert into department values (null, "巴黎圣母院");
select * from department;

insert into student values (null, "刘孙伟", "男", 19, 1, "liu");
insert into student values (null, "朱丽娟", "女", 95, 1, "zhu");
insert into student values (null, "彭于斌", "女", 19, 4, "pen");
insert into student values (null, "尤阳宇", "男", 19, 2, "you");
insert into student values (null, "马克思", "男", 99, 3, "max");
insert into student values (null, "马舒婷", "女", 36, 5, "shu");
insert into student values (null, "马云", "男", 996, 5, "yun");
select * from student;

insert into message values (null, "SQL", "我讨厌 SQL 语言", 3, 2);
insert into message values (null, "Java", "我讨厌 Java 语言", 1, 2);
insert into message values (null, "JDBC", "我永远喜欢 JDBC", 4, 2);
insert into message values (null, "I love", "不许说 Java 说坏话", 4, 1);
insert into message values (null, "conn", "全世界都在连接数据库", 3, 4);
insert into message values (null, "J2EE", "快来学习 Jawa EE", 2, 1);
insert into message values (null, "FooDoor", "开启辅导员模式", 6, 5);
insert into message values (null, "lover", "和宝宝快乐吃饭ing", 1, 3);
insert into message values (null, "C++", "人参苦短，我用 C++", 4, 5);
insert into message values (null, "MySQL", "MySQL 他不香嘛", 3, 1);
insert into message values (null, "Maria", "MariaDB 是开源版本", 3, 7);
select * from message;

insert into administrator values (null, "彭于斌", "penguin");
insert into administrator values (null, "朱丽娟", "pigious");
select * from administrator;

-- select * from student join department where s_dept = d_no;

-- update student set s_name = '名字', s_age = 32 where s_no = 1 or s_name = '刘孙伟';
-- select * from student;
