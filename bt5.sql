create database Quanlybenhnhan

use Quanlybenhnhan

create table phong(
maphong char(20) not null,
tenphong nvarchar(50) null,
makhoa char(20) null,
constraint pk_phong primary key(maphong),
)

create table benhnhan(
mabn char(20) not null,
hoten nvarchar(50) null,
gioitinh bit null,
cmnd int null,
ngaysinh date null,
diachi nvarchar(50) null,
constraint pk_benhnhan primary key (mabn),
)
create table giuongbenh
(
magiuong char(20) not null,
trangthai nvarchar(50) null,
maphong char(20) not null,
mabn char(20) not null,
constraint pk_giuongbenh primary key (magiuong,maphong,mabn),
constraint fk_phong_giuongbenh foreign key (maphong) references phong(maphong),
constraint fk_benhnhan_giuongbenh foreign key (mabn) references benhnhan(mabn),
)



insert into phong values 
('PCC1','Phau thuat','KH02'),
('PCC10','Nhi2','KH10'),
('PCC11',N'Chờ sinh','KH09'),
('PCC12',N'Hậu sản','KH09'),
('PCC2','Hoi suc 01','KH01'),
('PCC3','Phau thuat 02','KH04'),
('PCC4','Benh 01','KH03'),
('PCC5','Benh 02','KH01'),
('PCC6','Benh 03','KH02'),
('PCC7','Benh 04','KH02'),
('PCC8','Benh 05','KH05'),
('PCC9','Nhi1','KH10');
select * from phong
delete from phong

insert into benhnhan values 
('BN01','Nguyen An',1,'12 Dinh Tien Hoang','1976-01-04',12345678),
('BN010','Ngo Truc',0,'Daklak','1997-09-12',124567),
('BN02','Nguyen Ba',1,'Dong Nai','1976-01-04',12345578),
('BN03','Nguyen Canh',1,'Binh Duong','1979-11-04',19845678),
('BN04','Nguyen Dung',0,'Nha Trang','1986-01-08',98735678),
('BN05','Nguyen Em',1,'Vung Tau','1979-01-09',4387678),
('BN06','Le An',0,'Binh Dinh','1987-09-04-',098745),
('BN07','Ho Nguyet',1,'Quang Ngai','1967-03-06',0876897),
('BN08','Tran Phong',1,'Phu Yen','1985-05-03',0754867),
('BN09','Dao Tam',1,'Gia Lai','1990-05-09',086476);
select * from benhnhan




