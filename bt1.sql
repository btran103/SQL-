create database Quanlivattu
go

use Quanlivattu
go

create table vattu
(
mavtu char(4) not null,
tenvtu nvarchar(100),
dvtinh nvarchar(100),
phantram int,
constraint pk_vattu primary key (mavtu),
)
go 
create table nhaCC
(
manhacc char(4) not null,
tennhacc nvarchar(100),
diachi nvarchar(200),
dienthoai nvarchar(20),
constraint pk_nhaCC primary key (manhacc),
)
go
create table donDH
(
sodh char(4) not null,
ngaydh datetime,
manhacc char(4),
constraint pk_donDH primary key (sodh),
constraint fk_nhaCC_donDH foreign key (manhacc) references nhaCC(manhacc),
)
drop table donDH
go 
create table ctdonDH
(
sodh char(4) not null,
mavtu char(4),
sldat int, 
constraint pk_ctdonDH primary key (sodh),
constraint fk_vattu_ctdonDH foreign key (mavtu) references vattu(mavtu),
constraint fk_donDH_ctdonDH foreign key (sodh) references ctdonDH(sodh),
)
drop table ctdonDH
go
create table pnhap
(
sopn char(4) not null,
ngaynhap datetime,
sodh char(4),
constraint pk_pnhap primary key (sopn),
constraint fk_donDH_pnhap foreign key (sodh) references donDH(sodh),
)
go
create table ctpnhap
(
sopn char(4) not null,
mavtu char(4),
slnhap int,
dgnhap money,
constraint pk_ctpnhap primary key (sopn),
constraint fk_vattu_ctpnhap foreign key (mavtu) references vattu(mavtu),
constraint fk_pnhap_ctpnhap foreign key (sopn) references pnhap(sopn),
)
go
create table pxuat
(
sopx char(4) not null,
ngayxuat datetime,
tenkh nvarchar(100),
constraint pk_pxuat primary key (sopx),
)
go
create table ctpxuat
(
sopx char(4) not null,
mavtu char(4),
slxuat int,
dgxuat money,
constraint pk_ctpxuat primary key (sopx),
constraint fk_vattu_ctpxuat foreign key (mavtu) references vattu(mavtu),
constraint fk_pxuat_ctpxuat foreign key (sopx) references pxuat(sopx),
)
go
create table tonkho
(
namthang char(6) not null,
mavtu char(4),
sldau int,
tongsln int,
tongslx int,
slcuoi int,
constraint pk_tonkho primary key (namthang),
constraint fk_vattu_tonkho foreign key (mavtu) references vattu(mavtu),
)
go              
alter table vattu
add constraint uni_vatu unique (vatu)
alter table vattu
add constraint chk_vatu check (vatu<=0 and vatu<=100)
alter table vattu
add constraint def_tan default 'tan' for dvtinh
alter table nhaCC
add constraint uni_nhaCC unique (nhacc)
alter table nhaCC
add constraint uni_diachicc unique (diachicc)
alter table nhaCC
add constraint def_sodt default 'chua co' for sodt
alter table donDH
add constraint def_ngaydh default (ngaydh)
alter table ctdonDH
add constraint chk_sldat check (sldat>0)
alter table ctpnhap
add constraint chk_slnhap check (slnhap>0 and dgnhap>0)
alter table ctpxuat
add constraint chk_slxuat check (slxuat>0 and dgxuat>0)
alter table tonkho
add constraint chk_sldau check (sldau>=0)
alter table tonkho
add constraint chk_tongsln check (tongsln>=0)
alter table tonkho
add constraint chk_tongslx check (tongslx>=0)
alter table tonkho
add constraint def_sldau default 0 for sldau
alter table tonkho
add constraint def_tongsln default 0 for tongsln
alter table tonkho
add constraint def_tongslx default 0 for tongslx

insert into vattu values 
('DD01', N'Đầu DVD Hitachi 1 đĩa', N'Bộ', '40'),
('DD02', N'Đầu DVD Hitachi 3 đĩa', N'Bộ', '40'),
('TL15', N'Tủ lạnh Sanyo 150 lit', N'Cái','25'),
('TL90', N'Tủ lạnh Sanyo 90 lit', 'Cái', '20'),
('TV14', N'Tivi Sony 14 inches', 'Cái', '15'),
('TV21', N'Tivi Sony 21 inches', 'Cái', '10'),
('TV29', N'Tivi Sony 29 inches', 'Cái', '10'),
('VD01', N'Đầu VCD Sony 1 đĩa', N'Bộ', '30'),
('VD02', N'Đầu VCD Sony 3 đĩa', N'Bộ', '30');
select * from vattu
delete from vattu

insert into nhaCC values 
('C01', N'Lê Minh Trí', N'54 Hậu Giang Q6 HCM', '8781024'),
('C02',  N'Trần Minh Thạch', N'145 Hùng Vương Mỹ Tho', '7698154'),
('C03', N'Hồng Phương', N'154/85 Lê Lai Q1 HCM', '9600125'),
('C04', N'Nhật Thắng',  N'198/40 Hương Lộ 14 QTB HCM', '8757757'),
('C05', N'Lưu Nguyệt Quế', N'178 Nguyễn Văn Luông Đà Lạt', '7964251'),
('C07', N'Cao Minh Trung', N'125 Lê Quang Sung Nha Trang', N'Chưa có');
select * from nhaCC
delete from nhaCC

insert into donDH values 
('D002', '2007-01-30 12:02:33', 'C01'),
('D003', '2007-02-10 12:02:33', 'C02'),
('D004', '2007-02-17 12:02:33', 'C05'),
('D005', '2007-01-03 12:02:33', 'C02'),
('D006', '2007-02-03 12:02:33', 'C05')
select * from donDH
delete from donDH

insert into ctdonDH values
('D001', 'DD01', '10'),
('D101', 'DD02', '15'),
('D002', 'VD02', '30'),
('D003', 'TV14', '17'),
('D003', 'TV29', '20'),
('D004', 'TL90', '10'),
('D005', 'TV14', '10'),
('D105', 'TV29', '20'),
('D006', 'TV14', '10')
select * from ctdonDH
delete from ctdonDH












