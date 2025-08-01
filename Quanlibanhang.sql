CREATE DATABASE QLBANHANG

USE QLBANHANG
CREATE TABLE khachhang(
   Makh CHAR(10) NOT NULL,
   CONSTRAINT pk_khachhang PRIMARY KEY(Makh),
   hoten NVARCHAR(60) NOT NULL,
   diachi	NVARCHAR(100) NULL,
   sodt CHAR(11) NULL,
   ngaysinh DATE NULL,
   doanhso FLOAT NULL,
)

CREATE TABLE nhanvien(
 manv CHAR(10) NOT NULL,
 CONSTRAINT pk_nhanvien PRIMARY KEY(manv),
 hoten NVARCHAR(60) NOT NULL,
 ngaysinh DATE NULL ,
 gioitinh BIT NULL,
 ngaylamviec DATE NULL,
 sodt CHAR(11) NULL,
 email CHAR(30) NULL,
)


CREATE TABLE sanpham(
 masp CHAR(10) NOT NULL,
 CONSTRAINT pk_sanpham PRIMARY KEY(masp),
 tensp NVARCHAR(50) NOT NULL,
 dvt NVARCHAR(30) NULL,
 nuocsx NVARCHAR(50) NULL,
 gia FLOAT NOT NULL,
 soluong FLOAT NOT NULL,
)


CREATE TABLE hoadon(
 soHD CHAR(10) NOT NULL,
 CONSTRAINT pk_hoadon PRIMARY KEY(soHD),
 ngayHD DATE NOT NULL,
 makh CHAR(10) NOT NULL,
 CONSTRAINT fk_makh FOREIGN KEY(makh)
 REFERENCES khachhang(makh),
 manv CHAR(10) NOT NULL,
 CONSTRAINT fk_manv FOREIGN KEY(manv)
 REFERENCES nhanvien(manv),
 trigia FLOAT NULL,
)

CREATE TABLE CTHD(
 sohd CHAR(10) NOT NULL,
 masp CHAR(10) NOT NULL,
 CONSTRAINT pk_CTHD PRIMARY KEY(sohd,masp),
 CONSTRAINT fk_sohd FOREIGN KEY(sohd)
 REFERENCES hoadon(soHD),
 CONSTRAINT fk_masp FOREIGN KEY(masp)
 REFERENCES sanpham(masp),
 soluong FLOAT NOT NULL,
 giaban FLOAT NOT NULL,
)


1. Thêm các ràng buộc:
  a. Bảng Nhanvien: ngaysinh chỉ nhận nhân viên trên 18 tuổi trở lên.
ALTER TABLE nhanvien
ADD CONSTRAINT chk_ngaysinh CHECK (YEAR(GETDATE())-YEAR(ngaysinh)>=18)
  b. Bảng Khachhang: trường sodt (số điện thoại) không được trùng dữ liệu
ALTER TABLE khachhang
ADD CONSTRAINT uni_sodt UNIQUE(sodt)
  c. Bảng Sanpham: trường soluong >=50
ALTER TABLE sanpham
ADD CONSTRAINT chk_soluong CHECK (soluong>=50)

2. Nhập dữ liệu cho các bảng trên đảm bảo thỏa các điều kiện của câu lệnh select
ở những bài thực hành sau.

3. Cập nhật Giá tăng lên 10% cho những sản phẩm có số lượng <20
--C1
UPDATE SANPHAM
SET GIA =GIA+(GIA*0.1)
WHERE SOLUONG<20
 --C2
UPDATE SANPHAM
SET GIA = GIA * 1.1
WHERE SOLUONG < 20;

4. Thêm ràng buộc trường Soluong>0
ALTER TABLE sanpham
ADD CONSTRAINT ck_soluong CHECK (soluong > 0);

5. Thêm trường MAIL vào bảng KHACHHANG với ràng buộc duy nhất
ALTER TABLE khachhang
ADD MAIL CHAR(30) NOT NULL
CONSTRAINT unique_mail UNIQUE (MAIL)

6. Xóa trường MAIL vừa tạo.

ALTER TABLE KHACHHANG
drop CONSTRAINT unique_mail

ALTER TABLE KHACHHANG
DROP COLUMN MAIL

7. Nhập dữ liệu theo mẫu sau

INSERT INTO NHANVIEN (MANV, HOTEN, NGAYSINH, GIOITINH, NGAYLAMVIEC, SODT, EMAIL)
VALUES
('NV001', N'Trần Thiên Thạch', '2002-02-12', 0, '2022-03-17', '01234576', 'Lasothidaolop 12c6@gmail.com'),
('NV002', N'Mai Nguyễn Anh Kiệt', '2002-12-11', 0, '2022-03-17', '345467343', 'mainguyenanhkiet0167@gmail.com'),
('NV003', N'Trần Lê Văn', '2002-12-11', 0, '2003-09-20', '345293477', 'levanhcb@gmail.com'),
('NV004', N'Trần Đinh Thị Kim Yến', '2003-09-23', 1, '2022-03-17', '328379251', 'tranthikimyen1111@gmail.com'),
('NV005', N'Lê Anh Tú', '2003-02-02', 0, '2022-03-12', '3925007007', 'cntt44dleanhtu0605@gmail.com'),
('NV006', N'Nguyễn Quang Dũng', '2002-02-06', 0, '2022-03-11', '395089035', 'cntt44quangdung0624@gmail.com'),
('NV007', N'Đặng Văn Dương', '2002-06-06', 0, '2022-03-23', '358036264', 'duongmap0396@gmail.com'),
('NV008', N'Hà Vĩ Quang', '2003-10-12', 0, '2022-05-12', '349324229', 'Cnttk44dhavi0631@gmail.com'),
('NV009', N'Hồ Xuân Hậu', '2003-09-24', 0, '2022-03-17', '369380853', 'Hoxuanhau0634@gmail.com'),
('NV010', N'Bùi Mai Hiên', '2003-07-07', 1, '2022-03-17', '865183128', 'cntt44dbuimaihien@gmail.com'),
('NV011', N'Nguyên Trọng', '2001-07-07', 1, '2022-03-17', '865183128', 'cntt43dbuimaihien@gmail.com'),
('NV012', N'Hồ Văn Nam', '1995-07-08', 1, '2003-09-10', '8651831288', 'cntt42dbuimaihien@gmail.com'),
('NV013', N'Hồ Hà', '1995-07-07', 1, '2005-10-20', '8651831888', 'cntt41dbuimaihien@gmail.com'),
('NV014', N'Nguyễn Hiền', '1995-07-07', 1, '2005-10-20', '8651831888', 'cntt41dbuimaihien@gmail.com');
select * from NHANVIEN

INSERT INTO KHACHHANG (MAKH, HOTEN, DIACHI, SODT, NGAYSINH, DOANHSO)
VALUES
('KH01', N'NGUYỄN VĂN AN', N'HÙNG VƯƠNG, GIA LAI', '01234567', '1999-02-14', 10),
('KH02', N'NGUYỄN ANH TÀI', N'TRẦN VĂN ƠN, BÌNH ĐỊNH', '01234523', '1989-05-21', 8),
('KH03', N'NGUYỄN ĐẶNG TRƯỞNG THÀNH', N'PHÚ HÒA, ĐỒNG THÁP', '01235667', '1990-03-12', 2),
('KH04', N'NGUYỄN THỊ THU', N'PHÚ THỌ', '012467567', '1989-04-13', 5),
('KH05', N'NGUYỄN MINH TUẤN', N'LAI CHU', '01214567', '1969-05-10', 7),
('KH06', N'TRẦN LẺ TUẤN VŨ', N'SAPA', '01254567', '1999-06-11', 11),
('KH07', N'NGUYỄN HOÀI LINH', N'HÀ NỘI', '01424567', '2000-07-21', 21),
('KH08', N'NGUYỄN THU SƯƠNG', N'TP HCM', '0104567', '2002-08-24', 22),
('KH09', N'ĐẶNG VĂN LINH', N'CẦN THƠ', '01098567', '2001-09-23', 11),
('KH10', N'NGUYỄN HÙNG DŨNG', N'ĐIỆN BIÊN', '09894567', '1994-10-14', 9);
select * from KHACHHANG


INSERT INTO SANPHAM (MASP, TENSP, DVT, NUOCSX, GIA, SOLUONG)
VALUES
('SP01', N'NƯỚC HOA', N'Chai', N'VIỆT NAM', 100, 55),
('SP02', 'OSHI', N'Thùng', N'HÀ LAN', 100, 120),
('SP03', N'NƯỚC LỌC', N'Thùng', N'VIỆT NAM', 150, 230),
('SP04', 'COCA COLA', 'Chai', N'HÀN QUỐC', 200, 150),
('SP05', 'PANADOL', N'Viên', 'CAMPUCHIA', 20000, 1250),
('SP06', N'ĐƯỜNG', 'Kg', N'VIỆT NAM', 20000, 90),
('SP07', N'ẨM TRÀ', N'Bộ', N'VIỆT NAM', 20000, 1230),
('SP08', N'QUẠT', N'Cái', N'VIỆT NAM', 20000, 131),
('SP09', N'MŨ', N'Cái', N'TRUNG QUỐC', 20000, 122),
('SP10', N'ÁO', N'Cái', N'ẤN ĐỘ', 20000, 736),
('SP11', N'SỮA', N'Thùng', N'ẤN ĐỘ', 20000, 736);
select * from SANPHAM

INSERT INTO HOADON (SOHD, NGAYHD, MAKH, MANV, TRIGIA)
VALUES
('HD01', '2022-02-02', 'KH01', 'NV001', 100000),
('HD02', '2022-02-12', 'KH02', 'NV002', 200000),
('HD03', '2022-02-12', 'KH03', 'NV003', 300000),
('HD04', '2022-02-18', 'KH03', 'NV004', 400000),
('HD05', '2022-02-18', 'KH04', 'NV005', 500000),
('HD06', '2022-02-20', 'KH05', 'NV006', 600000),
('HD07', '2022-02-22', 'KH06', 'NV007', 700000),
('HD08', '2022-02-27', 'KH07', 'NV008', 800000),
('HD09', '2022-03-02', 'KH08', 'NV009', 900000),
('HD10', '2022-03-12', 'KH09', 'NV010', 1000000),
('HD11', '2022-03-22', 'KH06', 'NV007', 1100000),
('HD12', '2022-04-12', 'KH01', 'NV007', 1200000);

INSERT INTO CTHD (SOHD, MASP, SOLUONG, GIABAN) 
VALUES
('HD01', 'SP01', 55, 400),
('HD01', 'SP05', 120, 1200),
('HD02', 'SP01', 120, 1200),
('HD03', 'SP02', 100, 13),
('HD04', 'SP03', 200, 10),
('HD05', 'SP01', 50, 100),
('HD06', 'SP02', 9010, 10),
('HD07', 'SP05', 1230, 20),
('HD08', 'SP07', 131, 100),
('HD09', 'SP04', 122, 30),
('HD10', 'SP06', 736, 200);
select * from CTHD
--BÀI THỰC HÀNH 2:
use QLBANHANG
--1. Mã sản phẩm, tên sản phẩm và số lượng sản phẩm hiện có trong công ty?
select masp,tensp,soluong
from sanpham
--2. Địa chỉ, điện thoại của các khách hàng ở Bình Định?
select diachi,sodt
from khachhang
where diachi like N'%BÌNH ĐỊNH'
--3. Mã và tên sản phẩm có giá lớn hơn 10000 và số lượng hiện có ít hơn 135
select masp,tensp
from sanpham sp
where (sp.gia>10000) and (sp.soluong<135)
--4. Những sản phẩm nào được sản xuất ở Việt Nam?
select tensp
from sanpham
where nuocsx like N'%VIỆT NAM'
--5. Những khách hàng nào đã mua panadol của công ty?
select kh.hoten
from khachhang kh 
join hoadon hd on kh.Makh=hd.makh
join CTHD ct on hd.soHD=ct.sohd 
join sanpham sp on ct.masp=sp.masp
where sp.tensp = N'Panadol'
--6. Đơn hàng số HD01 do ai đặt và do nhân viên nào lập, trị giá là bao nhiêu?
select kh.hoten,nv.hoten,hd.trigia
from hoadon hd
join khachhang kh on hd.makh=kh.Makh
join nhanvien nv on hd.manv=nv.manv
where hd.soHD= N'HD01'
--7. Hãy cho biết có những nhân viên nào lại chính là khách hàng của công ty (có cùng sodt)
select nv.hoten,nv.sodt
from nhanvien nv
--8. Họ tên và ngày bắt đầu làm việc của các nhân viên trong công ty có ngày bắt đầu là ngày 17/3/2022?
select nv.hoten,nv.manv,nv.email,nv.ngaylamviec
from nhanvien nv
where nv.ngaylamviec='2022-03-17'
--9. Liệt kê danh sách những nhân viên có cùng ngày sinh.
select nv.manv,nv.hoten,nv.ngaysinh
from nhanvien nv
where exists(select ngaysinh from nhanvien
where nv.ngaysinh=ngaysinh and nv.hoten<>hoten and nv.manv<>manv)
--10.Những nhân viên nào của công ty có thâm niên cao nhất?
select top 5 nv.hoten,nv.manv,nv.gioitinh,(YEAR(getdate())-YEAR(ngaylamviec)) as Sonamlam
from nhanvien nv
order by Sonamlam DESC
--11.Cho biết thông tin TENSP, SOLUONG, DVT, SOHD, HOTEN của những khách
--hàng có địa chỉ ở BÌNH ĐỊNH săp xếp tăng dần theo SOHD
select sp.tensp,sp.soluong,sp.dvt,hd.soHD,kh.hoten
from hoadon hd 
join CTHD ct on hd.soHD=ct.sohd
join sanpham sp on ct.masp=sp.masp
join khachhang kh on hd.makh=kh.makh  
where kh.diachi like N'%Bình Định'
order by hd.soHD ASC
insert into khachhang values('KH11',N'Mai Văn Lam',N'Nguyễn Huệ,Bình Định','01357996','2005-04-21',7);
insert into hoadon values('HD13','2021-04-12','KH11','NV005',0);
insert into CTHD values('HD13','SP05',125,400);
--12.Cho biết thông tin TENSP, SOLUONG, DVT, SOHD của những hóa đơn có ngày
--và tháng trùng với ngày và tháng của ngày hiện tại (ngày đang làm thực hành)
select sp.tensp,sp.soluong,sp.dvt,hd.soHD,hd.ngayHD
from sanpham sp
join CTHD ct on sp.masp=ct.masp
join hoadon hd on ct.sohd=hd.soHD
where exists(select ngayHD from hoadon hd 
where hd.ngayHD=ngayHD and ct.soHD<>soHD)
--13.Cho biết thông tin của những sản phẩm bán trong tháng 2, 3.
select sp.tensp,sp.masp
from CTHD ct
join sanpham sp on ct.masp=sp.masp
join hoadon hd on ct.sohd=hd.soHD
where MONTH(hd.ngayHD)=2 or MONTH(hd.ngayHD)=3
--14.Hiển thị những thông tin: Masp, TenSP, NuocSX, số lượng bán, (Những
--sản phẩm nào chưa được bán cũng được hiển thị thông tin).
select sp.masp,sp.tensp,sp.nuocsx,ct.soluong
from sanpham sp,CTHD ct
where sp.masp=ct.masp
--15.Hiển thị những thông tin: TenKH, Địa chỉ, SoDT, SoHD, (Những khách
--hàng chưa mua lần nào cũng được hiển thị thông tin).
select kh.hoten,kh.diachi,kh.sodt,hd.sohd
from khachhang kh ,hoadon hd
where kh.Makh=hd.makh
--16.Tạo bảng LUU những sản phẩm được mua trong tháng 3 năm 2022.
create table LUU(
masp char(10) not null,
tensp nvarchar(50) not null,
dvt nvarchar(30),
nuocsx nvarchar(50),
gia float,
soluong float,
ngayhd date,
constraint pk_LUU primary key (masp)
)
drop table LUU
insert into luu values
('SP01', N'NƯỚC HOA', N'Chai', N'VIỆT NAM', 100, 55, '2022-02-02' ),
('SP02', 'OSHI', N'Thùng', N'HÀ LAN', 100, 120, '2022-02-12' ),
('SP03', N'NƯỚC LỌC', N'Thùng', N'VIỆT NAM', 150, 230, '2022-02-02' ),
('SP04', 'COCA COLA', 'Chai', N'HÀN QUỐC', 200, 150, '2022-02-18'),
('SP05', 'PANADOL', N'Viên', 'CAMPUCHIA', 20000, 1250, '2022-02-18'),
('SP06', N'ĐƯỜNG', 'Kg', N'VIỆT NAM', 20000, 90, '2022-02-20'),
('SP07', N'ẨM TRÀ', N'Bộ', N'VIỆT NAM', 20000, 1230, '2022-02-22'),
('SP08', N'QUẠT', N'Cái', N'VIỆT NAM', 20000, 131, '2022-03-27'),
('SP09', N'MŨ', N'Cái', N'TRUNG QUỐC', 20000, 122,'2022-03-05'),
('SP10', N'ÁO', N'Cái', N'ẤN ĐỘ', 20000, 736,'2022-03-24'),
('SP11', N'SỮA', N'Thùng', N'ẤN ĐỘ', 20000, 736,'2022-04-25');
select * from luu
select l.ngayhd,l.masp
from luu l
where month(l.ngayhd)=3 and year(l.ngayhd)=2022
--17.Xóa những hóa đơn của khách hàng có địa chỉ ở Côn Đảo
delete from khachhang where diachi like N'%Côn Đảo'
--18.Cập nhật lại giá tăng lên 10% so với giá hiện tại cho những sản phẩm có tên bắt đầu
--bằng chữ N.
update sanpham  
set gia=gia*1.1
where tensp like 'N%'
--19.Đơn hàng hd01 do nhân viên nào lập và địa chỉ giao hàng ở dâu.
select nv.hoten,nv.manv,kh.hoten,kh.diachi
from nhanvien nv
join hoadon hd on nv.manv=hd.manv
join khachhang kh on hd.makh=kh.Makh
where hd.soHD= N'HD01'
--20.Liệt kê những sản phẩm bán trong ngày 18/2.
select sp.tensp,sp.masp,hd.sohd,hd.ngayHD
from sanpham sp,hoadon hd
where MONTH(hd.ngayHD)=2 and DAY(hd.ngayHD)=18

Bài thực hành 3:
use QLBANHANG

--1. Tổng số tiền mà khách hàng phải trả cho các hóa đơn là bao nhiêu?
select kh.hoten,sum(soluong*giaban) as tongtrigia
from khachhang kh
join hoadon hd on kh.makh=hd.makh
join cthd ct on hd.sohd=ct.sohd
group by kh.hoten
--2. Tính tổng số sản phẩm của từng nước sản xuất.
select sp.nuocsx,sum(soluong) as tongsosanphamtungnuoc
from sanpham sp
group by sp.nuocsx 
--3. Với từng nước sản xuất, tìm giá bán cao nhất, thấp nhất, trung bình của các sản phẩm.
select sp.nuocsx,max(gia) as gialonnhat,min(gia)as gianhonhat,avg(gia) as trungbinhgia
from sanpham sp
group by sp.nuocsx
--4. Cho biết các mặt hàng đã bán.
select sp.tensp
from sanpham sp, CTHD ct
where sp.masp=ct.masp
group by sp.tensp
--5. Cho biết SOHD, TENSP, SOLUONG, DONGIA, THANHTIEN của hóa đơn số HD002.
select ct.soHD,sp.tensp,ct.soluong,ct.giaban,SUM(ct.soluong*ct.giaban) as thanhtoan
from sanpham sp,CTHD ct,hoadon hd
where sp.masp=ct.masp and ct.sohd=hd.soHD and ct.soHD = N'HD02'
group by ct.soHD,sp.tensp,ct.soluong,ct.giaban
--6. Cho biết SOHD, TENSP, SOLUONG, DONGIA, THANHTIEN có
--THANHTIEN trong đoạn 1 triệu đến 2 triệu.
select ct.soHD,sp.tensp,ct.soluong,ct.giaban
from sanpham sp,CTHD ct,hoadon hd
where sp.masp=ct.masp and ct.sohd=hd.soHD and ct.giaban between 100 and 20000
group by ct.soHD,sp.tensp,ct.soluong,ct.giaban 
--7. Tính số lượng bán của mỗi sản phẩm.
select sp.masp,sp.tensp,SUM(ct.soluong) as soluongban
from sanpham sp, CTHD ct
where sp.masp=ct.masp
group by sp.masp,sp.tensp 
--8. Cho biết số lượng đơn hàng xuất vào tháng 3.
select sp.tensp,sp.soluong,hd.ngayhd,sp.tensp
from sanpham sp,hoadon hd,CTHD ct
where sp.masp=ct.masp and hd.soHD=ct.sohd and month(hd.ngayHD)=3
group by sp.tensp,sp.soluong,hd.ngayhd
--9. Cập nhập cho giá trị trường trị giá trong bảng HOADON, trị giá là tổng
--soluong*dongia của từng hóa đơn.
update hoadon set trigia=(select SUM(ct.soluong*ct.giaban)
from CTHD ct,hoadon hd  where ct.sohd=hd.soHD)
select * from hoadon
--10.Tính trị giá của mỗi hóa 
select sp.masp,SUM(sp.soluong*sp.gia) as trigiadonhang,hd.soHD,sp.tensp
from sanpham sp,hoadon hd,CTHD ct
where sp.masp=ct.masp and ct.sohd=hd.soHD
group by sp.masp,hd.soHD,sp.tensp
--11.Mỗi nhân viên của công ty đã lập bao nhiêu đơn đặt hàng (nếu chưa từng lập hóa
--đơn nào thì cho kết quả là 0)?
--C1
select nv.hoten,nv.manv, coalesce (COUNT(hd.sohd),0) as sonvlapdonhang
from nhanvien nv,hoadon hd
where nv.manv=hd.manv
group by nv.hoten,nv.manv
--C2
select nv.hoten,COUNT(hd.sohd) as sonvlapdonhang
from nhanvien nv,hoadon hd
where nv.manv=hd.manv
group by (nv.hoten)
union 
select hoten, '0' sonvlapdonhang
from nhanvien nv
where not exists(select manv from nhanvien where manv=nv.manv)
group by hoten
--12.Tính tổng số tiền mà công ty thu được từ mỗi mặt hàng trong mỗi năm?
select sp.tensp,SUM(ct.giaban) as tongsotienban
from sanpham sp,CTHD ct
group by sp.tensp
--13.Trong năm 2022 những sản phẩm nào đặt mua đúng một lần?
select sp.tensp
from sanpham sp, CTHD ct,hoadon hd
where sp.masp=ct.masp and ct.sohd=hd.soHD and YEAR(hd.ngayhd)in (2022)
group by sp.tensp,ct.masp
having COUNT(*)=1
--14.Số tiền nhiều nhất mà khách hàng bỏ ra để mua hàng là bao nhiêu?
select top 5 kh.hoten,sp.masp,max(ct.giaban)as moneymax
from khachhang kh,sanpham sp,CTHD ct,hoadon hd
where kh.Makh=hd.makh and sp.masp=ct.masp and ct.sohd=hd.soHD
group by kh.hoten,sp.masp
order by moneymax DESC
--15.Xóa những đơn đặt hàng có tổng số lượng đặt < 5.
delete from CTHD 
where not exists(select 1 from CTHD ct 
where soluong=ct.soluong 
group by ct.soluong 
having SUM(soluong)<100
--16.Cho biết tên sản phẩm, tổng số lượng bán theo từng ngày
select sp.tensp,SUM(ct.soluong*ct.giaban) as tongsoluongbantheongay
from sanpham sp,CTHD ct
where sp.masp=ct.masp
group by sp.tensp
--17.Cho biết các sản phẩm có trung bình số lượng bán lớn hơn 15
select sp.tensp,avg(ct.soluong) as trungbinluongban
from sanpham sp,CTHD ct
where sp.masp=ct.masp
group by sp.tensp
having avg(ct.soluong)>15
--18.Cho biết những đơn đặt hàng có số sản phẩm < 4
select ct.sohd,sp.tensp,COUNT(ct.soluong) as sodondathang
from CTHD ct,hoadon hd,sanpham sp
where hd.soHD=ct.sohd and ct.masp=sp.masp
group by ct.sohd,sp.tensp
having COUNT(ct.soluong)<4
--19.Cho biết trị giá của hóa đơn HD05?
select hd.soHD,sp.tensp,hd.trigia
from hoadon hd,sanpham sp,CTHD ct
where hd.soHD=ct.sohd and sp.masp=ct.masp and hd.soHD='HD05'
group by hd.soHD,sp.tensp,hd.trigia
--20.Cho biết đơn đặt hàng nào có doanh thu cao nhất biết doanh thu bằng trị giá -
--gia*soluong (số lượng bán)
select tensp, sum(giaban*cthd.SOLUONG)-sum(CTHD.soluong*gia)as soluongbanra from SANPHAM, CTHD where CTHD.MASP=SANPHAM.MASP group by tensp
having sum(giaban*cthd.SOLUONG)-sum(CTHD.soluong*gia)= (select top 1 sum(giaban*cthd.SOLUONG)-sum(CTHD.soluong*gia) as sl from SANPHAM, CTHD
where CTHD.MASP=SANPHAM.MASP group by tensp order by sl desc ) 
--21.*Mỗi đơn đặt hàng đặt mua những mặt hàng nào và tổng số tiền của đơn đặt hàng?

--Bài thực hành 4:
use QLBANHANG
--1. Cho biết những sản phẩm có giá bằng với giá lớn nhất.
select sp.masp,sp.gia
from sanpham sp
where sp.gia in (select max(sp.gia) from sanpham sp)
--2. Cho biết danh sách khách hàng chưa từng mua hàng của công ty?
select kh.hoten,kh.Makh from khachhang kh 
where kh.makh not in (select hd.makh from hoadon as hd )
--3. Cho biết MASP, TENSP chưa được bán
select sp.masp,sp.tensp from sanpham sp
where sp.masp not in(select ct.masp from CTHD as ct)
--4. Cho biết thông tin sản phẩm chưa bán vào tháng 2.
select sp.masp,sp.tensp
from sanpham sp
where sp.masp not in(select ct.masp from CTHD as ct join sanpham on ct.masp=sp.masp 
join hoadon hd on hd.soHD=ct.sohd where month(hd.ngayhd)=2)
--5. Nhân viên nào của công ty bán được số lượng hàng nhiều nhất và số lượng hàng bán
--được của những nhân viên này là bao nhiêu?
select nv.manv,nv.hoten,MAX(ct.soluong) as soluongbanramax
from nhanvien nv,CTHD ct,hoadon hd
where nv.manv=hd.manv and hd.soHD=ct.sohd
group by nv.manv,nv.hoten
order by soluongbanramax desc
--6. Đơn đặt hàng nào có số lượng hàng được đặt mua ít nhất?
select hd.sohd,sp.masp,MIN(ct.soluong) as sodonhangmin
from hoadon hd, CTHD ct,sanpham sp
where hd.soHD=ct.sohd and sp.masp=ct.masp
group by hd.sohd,sp.masp
order by sodonhangmin asc
--7. Số tiền nhiều nhất mà các khách hàng đã từng bỏ ra để đặt hàng trong các đơn đặt hàng
--là bao nhiêu?(trị giá)
select hd.makh,kh.hoten,SUM(hd.trigia)as soluonglon
from khachhang kh,hoadon hd
where kh.Makh=hd.makh
group by kh.makh,kh.hoten,hd.makh
order by soluonglon desc
--8. Những Sản phẩm nào bán được số lượng ít nhất?
select sp.tensp,ct.soluong,sp.masp,MIN(ct.soluong) as habtr
from sanpham sp, CTHD ct
where sp.masp=ct.masp and sp.soluong=ct.soluong
group by  sp.tensp,ct.soluong,sp.masp
--9. Cho biết những mặt hàng có số lượng bán nhỏ hơn số lượng bán của mặt hàng nước lọc
select sp.masp,sp.tensp,ct.soluong
from sanpham sp,CTHD ct, hoadon hd
where sp.masp=ct.masp and hd.soHD=ct.sohd and (ct.soluong<200)
group by sp.masp,sp.tensp,ct.soluong
--10.Những nhân viên nào chưa từng lập 1 hóa đơn tính đến thời điểm này?
select nv.manv,nv.hoten,sp.tensp,sp.masp,hd.sohd
from sanpham sp,hoadon hd,CTHD ct,nhanvien nv
where sp.masp=ct.masp and nv.manv=hd.manv and hd.soHD=ct.sohd 
group by nv.manv,nv.hoten,sp.tensp,sp.masp,hd.sohd
--11.Những nhân viên nào của công ty có thâm niên cao nhất?
select top 5 nv.hoten,nv.manv,nv.gioitinh,(YEAR(getdate())-YEAR(ngaysinh)) as sotuoinhanvien
from nhanvien nv
order by sotuoinhanvien DESC
--12.Những khách hàng nào mua số lượng hàng nhiều nhất, số lượng đó là bao nhiêu?
select top 4 kh.makh,kh.hoten,ct.soluong,MAX(ct.soluong) as soluongbanracao
from khachhang kh, CTHD ct,hoadon hd
where kh.Makh=hd.makh and hd.soHD=ct.sohd 
group by kh.makh,kh.hoten,ct.soluong 
order by soluongbanracao DESC
--13.Cho biết những nhân viên có ngày sinh trùng với ngày sinh của bất kỳ khách hàng nào.
select nv.hoten,kh.hoten
from nhanvien nv, khachhang kh,hoadon hd 
where exists( select ngaysinh from nhanvien nv
where kh.ngaysinh=nv.ngaysinh)
--14.Cho biết những mặt hàng nào có tổng số lượng bán nhỏ hơn trung bình số lượng
--bán của các mặt hàng
select sp.tensp,SUM(ct.soluong) as soluongmin,AVG(ct.soluong*giaban) as trungbinhsoluongban
from sanpham sp,CTHD ct,hoadon hd
where sp.masp=ct.masp and hd.soHD=ct.sohd
group by sp.tensp
having SUM(ct.soluong)<AVG(ct.soluong*giaban) 

--Bài thực hành 5
use QLBANHANG
--1. Cho biết danh sách những sản phẩm có mã sản phẩm sp01, sp05
create view v_sanpham as 
select sp.masp,sp.tensp
from sanpham sp
where sp.masp= 'SP01' or sp.masp='SP05'
select * from v_sanpham
drop view v_sanpham
--2. Cho biết những sản phẩm bán trong tháng 2 năm 2022.
create view v_sanphamban as
select hd.ngayhd,sp.tensp
from hoadon hd
inner join cthd ct on hd.soHD=ct.sohd
inner join sanpham sp on ct.masp=sp.masp
where month(hd.ngayhd)=2 and year(hd.ngayhd)=2022
select * from v_sanphamban
drop view v_sanphamban
--3. Tạo view gồm các thông tin masp, tensp, soluong bán, giaban, sohd, ngayhd, thanhtien.
create view v_tong as 
select sp.masp, sp.tensp,ct.soluong,ct.giaban,hd.sohd,hd.ngayhd,sum(ct.soluong*ct.giaban) as thanhtien
from hoadon hd
join CTHD ct on ct.sohd=hd.soHD
join sanpham sp on sp.masp=ct.masp 
group by sp.masp, sp.tensp,ct.soluong,ct.giaban,hd.sohd,hd.ngayhd
select * from v_tong
drop view v_tong
--4. Nhật Bản đã cung cấp những mặt hàng nào?
create view v_som as
select tensp
from sanpham
where nuocsx = N'HÀN QUỐC'
select * from v_som
drop view v_som
--5. Sản phẩm Điện thoại di động do nước nào sản xuất?
create view v_sx as 
select sp.nuocsx
from sanpham sp 
where sp.tensp= N'Mũ'
select * from v_sx
drop view v_sx
--6. Những khách hàng nào có doanh số mua hàng cao nhất?
create view v_khmax as
select top 3 kh.makh,kh.hoten,MAX(ct.soluong) as somuahangcaonhat
from khachhang kh,CTHD ct,hoadon hd
where kh.Makh=hd.makh and hd.soHD=ct.sohd 
group by kh.makh,kh.hoten
order by somuahangcaonhat DESC
select * from v_khmax
--7. Cho biết những hóa đơn (sohd, ngayhd, trị giá ) cho những hóa đơn có trị giá < trị giá
--trung bình.
create view v_luongban as
select hd.sohd,hd.ngayHD,hd.trigia, AVG(ct.soluong*giaban) as sltb
from hoadon hd,CTHD ct
where hd.soHD=ct.sohd
group by hd.sohd,hd.ngayHD,hd.trigia
having hd.trigia>AVG(ct.soluong*giaban)
select * from v_luongban 
drop view v_luongban
--8. Hãy cho biết tổng số lượng sản phẩm do Việt Nam sản xuất?
create view v_vietnam as
select sp.tensp,hd.soHD,SUM(ct.soluong) as tongluongsanxuat
from sanpham sp,CTHD ct,hoadon hd
where ct.sohd=hd.soHD
and sp.masp=ct.masp 
group by sp.tensp,hd.soHD
select * from v_vietnam
drop view v_vietnam
--9. Trong đơn hàng số HD03 đặt mua những mặt hàng nào và tổng số tiền là bao nhiêu?
create view v_sxt3 as 
select sp.tensp, SUM(ct.soluong*ct.giaban) as tongsotienbanra
from sanpham sp,CTHD ct,hoadon hd
where sp.masp=ct.masp and hd.soHD=ct.sohd and ct.sohd= 'HD01'
group by sp.tensp
select * from v_sxt3
drop view v_sxt3
--10.Hãy cho biết có những khách hàng nào chưa có số điện thoại?
create view v_khcm as
select kh.hoten,kh.sodt
from khachhang kh
where kh.sodt= Null
select * from v_khcm
drop view v_khcm
insert into khachhang values
('KH12',N'Bùi Bảo Ninh',N'Chương Dương,Bình Định',N'chưa có','2005-09-29',9),
('KH13',N'Đoàn Gia Minh',N'Thanh Hóa',N'chưa có','2003-08-15',11);
--11.Trong công ty có những nhân viên nào có cùng ngày sinh?
create view v_nvcns as
select nv.hoten,nv.ngaysinh
from nhanvien nv
where exists (select ngaysinh from nhanvien 
where ngaysinh=nv.ngaysinh and manv<>nv.manv)
select * from v_nvcns
--12.Những nhân viên nào chưa xuất được hóa đơn trong 30 ngày qua?
create view v_ngxuat as 
select nv.hoten,ct.sohd,sp.masp
from nhanvien nv,CTHD ct,sanpham sp
where not exists (select sohd from CTHD ct,hoadon hd,sanpham sp 
where sp.masp=ct.masp and hd.soHD=ct.sohd 
and datepart(hd.ngayHD)=30
select * from v_ngxuat
--13.Cho biết những sản phẩm có số lượng ít hơn 300?
create view v_sp as 
select sp.tensp,ct.soluong
from sanpham sp,CTHD ct 
where sp.masp=ct.masp and ct.soluong<300
group by sp.tensp,ct.soluong
select * from v_sp
--14.Tạo view lưu những thông tin khách hàng có số đơn hàng >5.
create view v_luu as 
select kh.hoten,hd.soHD
from khachhang kh, hoadon hd,CTHD
where kh.Makh=hd.makh and CTHD.soluong>5
group by kh.hoten,hd.soHD
select * from v_luu
drop view v_luu

create table LUU(
masp char(10) not null,
tensp nvarchar(50) not null,
dvt nvarchar(30),
nuocsx nvarchar(50),
gia float,
soluong float,
ngayhd date,
constraint pk_LUU primary key (masp)
)
drop table LUU
insert into luu values
('SP01', N'NƯỚC HOA', N'Chai', N'VIỆT NAM', 100, 55, '2022-02-02' ),
('SP02', 'OSHI', N'Thùng', N'HÀ LAN', 100, 120, '2022-02-12' ),
('SP03', N'NƯỚC LỌC', N'Thùng', N'VIỆT NAM', 150, 230, '2022-02-02' ),
('SP04', 'COCA COLA', 'Chai', N'HÀN QUỐC', 200, 150, '2022-02-18'),
('SP05', 'PANADOL', N'Viên', 'CAMPUCHIA', 20000, 1250, '2022-02-18'),
('SP06', N'ĐƯỜNG', 'Kg', N'VIỆT NAM', 20000, 90, '2022-02-20'),
('SP07', N'ẨM TRÀ', N'Bộ', N'VIỆT NAM', 20000, 1230, '2022-02-22'),
('SP08', N'QUẠT', N'Cái', N'VIỆT NAM', 20000, 131, '2022-03-27'),
('SP09', N'MŨ', N'Cái', N'TRUNG QUỐC', 20000, 122,'2022-03-05'),
('SP10', N'ÁO', N'Cái', N'ẤN ĐỘ', 20000, 736,'2022-03-24'),
('SP11', N'SỮA', N'Thùng', N'ẤN ĐỘ', 20000, 736,'2022-04-25');
select * from luu
select l.ngayhd,l.masp
from luu l
where month(l.ngayhd)=3 and year(l.ngayhd)=2022
--BÀI THỰC HÀNH 6:
use QLBANHANG
--1.Viết thủ tục để xem doanh số mua hàng của khách hàng có mã X nào đó (X là tham số
--của thủ tục)
create proc sp_dsmhcuakhachhang
	(@x char(10))
as
begin
	select*from khachhang where makh=@x
end
execute sp_dsmhcuakhachhang @x='kh01'
--2. Viết thủ tục để xem masp và tensp của các sản phẩm có giá lớn hơn x và số lượng hiện
--có ít hơn y (x,y là tham số)
drop procedure sp_maspandtensp
create procedure sp_maspandtensp (@x int , @y int ) as 
select masp, tensp from sanpham 
where gia >@x and soluong  <@y 
execute sp_maspandtensp '10000','100'
--3. Viết thủ tục cho biết nhân viên X đã lập bao nhiêu hóa đơn (tham số x là manv)
create proc sp_nhanvien (@x char(10))
as
select sohd,manv from hoadon
where manv=@x 
execute sp_nhanvien 'NV009','6'
execute sp_nhanvien 'NV001'
--4. Viết thủ tục cho biết hóa đơn X do nhân viên nào lập, có bao nhiêu sản phẩm trên hóa
--đơn đó (tham số X là maHD)
create proc sp_hd  (@x char(10))
as
select sohd,masp from sanpham, hoadon
where masp=@x
execute sp_hd 'SP04'
--5. Viết thủ tục để xem những sản phẩm nào đã được mua với số lượng nhiều nhất
create proc sp_nhiunhat 
as
select sohd,MAX(soluong) as soluonglon
from CTHD
group by sohd
order by soluonglon DESC
execute sp_nhiunhat '55',
--6. Viết thủ tục cho biết thông tin của những sản phẩm có tổng số lượng bán >30




--bài thực hành 7:
--1. Viết hàm trả về tổng tiền (trị giá) mà khách hàng phải trả trên mỗi hóa đơn
create function sp_trigia (@sohd char(10))
returns int
as 
begin
declare @tongtien int
select @tongtien = SUM(ct.soluong*giaban)
from CTHD ct
where @sohd=soHD
return @tongtien 
end
select dbo.sp_trigia ('HD01') as Tongtien
 drop function sp_trigia 
--2. Viết hàm trả về tình trạng bán của các sản phẩm. Nếu soluong các sản phẩm
--(trong bảng CTHD) >100 thì bán chạy, ngược lại là bán chậm.
create function sp_bansp (@soluong int,@sohd char(10))
returns int 
as 
begin 
declare @tinhtrangban nvarchar(10)
select @tinhtrangban =ct.soHD
from CTHD ct,hoadon hd
where ct.soluong>100 and ct.soHD=hd.soHD
return @tinhtrangban
end
drop function sp_bansp
select dbo.sp_bansp ('HD01') as Mahd
---3. Viết hàm trả về một bảng gồm các thông tin Masp, tensp và soluong của các sản phẩm hiện có trong công ty.

--4. Viết hàm trả về một bảng gồm danh sách khách hàng có doanh số mua hàng cao
--nhất tính đến thời điểm này.
--5. Viết hàm trả về số lượng, sản phẩm bán chạy nhất trong tháng 2/2022 (sản phẩm
--có số lượng bán nhiều nhất)

--6. Viết hàm tính tiền bán được của sản phẩm x (x là mã sản phẩm, tham số đầu vào).
--Cho biết tổng tiền bán được của sản phẩm có mã SP01
--7. Viết hàm cho biết trung bình số lượng bán được của mỗi sản phẩm trong ngày x
--(x là tham số đầu vào của hàm)
--8. Viết hàm cho biết số đơn hàng bán được trong tháng x (biết x là tham số đầu
--vào). Cho biết tháng 2 có bao nhiêu đơn hàng.
--9. Viết hàm trả về tổng số lượng bán của mã sản phẩm x (x là MaSP, x là tham số
--của hàm)
--10.Viết hàm trả về số hóa đơn của khách hàng x (x là MaKH, x là tham số của hàm)
--11.Viết hàm TrangThai(x) trong đó x là tham số. Hàm trả về một trong các loại sau:
--Nếu x>=300 thì bán chạy
--Nếu 100<=x<300 trung bình
--Nếu x<100 thì bán ít
--Vận dụng để đánh giá trạng thái của các sản phấm bán được , giá trị truyền cho x là
--tổng số lượng đã bán của các sản phẩm.


