create database Quanlykhachsan

use Quanlykhachsan

create table khachsan(
maks int not null,
tenks nvarchar(50),
diachi nvarchar(200),
dientich float,
tenGDKS nvarchar(50),
constraint pk_khachsan primary key (maks),
)
create table phong(
maphong int not null,
maks int,
dientich float,
loai nvarchar(20),
tang int,
constraint pk_phong primary key(maphong),
constraint fk_khachsan_phong foreign key (maks) references khachsan(maks),
)
create table nhatkydatphong(
madatphong int not null,
maphong int not null,
checkin datetime, 
checkout datetime,
soluong int,
constraint pk_nhatkydatphong primary key (madatphong,maphong),
constraint fk_phong_nhatkydatphong foreign key (maphong) references phong(maphong),
)

--Tao cac rang buoc
--Truong maphong,maks kieu so thu tu tang(identity)
select * from khachsan order by maks asc
select * from phong order by maphong asc
--loai phong chi co PRO,VIP,GOLD
select distinct loai from phong
