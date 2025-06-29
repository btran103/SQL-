create database quanlidichvu
use quanlidichvu
-- Tạo bảng đầy đủ tất cả trường cần thiết
CREATE TABLE DICH_VU_DI_KEM (
    MaDV CHAR(10) PRIMARY KEY,
    TenDV NVARCHAR(50),
    DonGia FLOAT,
    DonViTinh NVARCHAR(20)
);

CREATE TABLE CHI_TIET_SU_DUNG_DV (
    MaDatPhong CHAR(10),
    MaDV CHAR(10),
    SoLuong INT
);

CREATE TABLE PHONG (
    MaPhong CHAR(10) PRIMARY KEY,
    LoaiPhong NVARCHAR(20),
    SoKhachToiDa INT,
    GiaPhong FLOAT
);

CREATE TABLE DAT_PHONG (
    MaDatPhong CHAR(10) PRIMARY KEY,
    MaPhong CHAR(10),
    MaKH CHAR(10),
    NgayDat DATE,
    GioBatDau DATETIME,
    GioKetThuc DATETIME,
    TienDatCoc FLOAT
);

CREATE TABLE KHACH_HANG (
    MaKH CHAR(10) PRIMARY KEY,
    TenKH NVARCHAR(50),
    DiaChi NVARCHAR(100)
);

-- Thêm dữ liệu đầy đủ
INSERT INTO PHONG VALUES ('P01', N'VIP', 20, 500000);
INSERT INTO PHONG VALUES ('P02', N'Thường', 10, 300000);

INSERT INTO KHACH_HANG VALUES ('KH01', N'Nguyễn Văn A', N'Hà Nội');

INSERT INTO DAT_PHONG VALUES ('DP01', 'P01', 'KH01', '2022-05-10', '2022-05-10 08:00', '2022-05-10 12:00', 100000);

INSERT INTO CHI_TIET_SU_DUNG_DV VALUES ('DP01', 'MDV01', 10);

INSERT INTO DICH_VU_DI_KEM VALUES ('MDV01', N'Nước uống', 10000, N'Chai');  20 hàng dữ liệu mỗi hàng


-- Thêm 20 dòng dữ liệu mẫu chỉ cho trường khóa chính của từng bảng
INSERT INTO PHONG (MaPhong) VALUES ('P03');
INSERT INTO PHONG (MaPhong) VALUES ('P04');
-- ... đến 'P22'

INSERT INTO KHACH_HANG (MaKH) VALUES ('KH02');
INSERT INTO KHACH_HANG (MaKH) VALUES ('KH03');
-- ... đến 'KH21'

INSERT INTO DAT_PHONG (MaDatPhong) VALUES ('DP02');
INSERT INTO DAT_PHONG (MaDatPhong) VALUES ('DP03');
-- ... đến 'DP21'

INSERT INTO DICH_VU_DI_KEM (MaDV) VALUES ('MDV02');
INSERT INTO DICH_VU_DI_KEM (MaDV) VALUES ('MDV03');
-- ... đến 'MDV21'





--p1:
--1:
select p.LoaiPhong,p.SoKhachToiDa,dp.NgayDat,dp.GioBatDau,dp.GioKetThuc,dp.TienDatCoc from DAT_PHONG dp join PHONG p on p.MaPhong=dp.MaPhong
where p.SoKhachToiDa=20 or dp.TienDatCoc<150000
--2:
select dvdk.TenDV,dvdk.DonGia,ctsd.SoLuong,dvdk.DonViTinh from DICH_VU_DI_KEM dvdk join CHI_TIET_SU_DUNG_DV ctsd on ctsd.MaDV=dvdk.MaDV
where ctsd.SoLuong in(6,10)
--3:
select p.MaPhong,d.NgayDat,dv.TenDV,c.SoLuong from PHONG p join DAT_PHONG d on d.MaPhong=p.MaPhong join CHI_TIET_SU_DUNG_DV c on c.MaDatPhong=d.MaDatPhong join DICH_VU_DI_KEM dv on dv.MaDV=c.MaDV
where c.SoLuong=50 and month(d.NgayDat)=12
--4:
update DICH_VU_DI_KEM set DonGia=(DonGia-((DonGia/100)*20)) where MaDV in (select dv.MaDV from DICH_VU_DI_KEM dv left join CHI_TIET_SU_DUNG_DV ct on ct.MaDV=dv.MaDV where ct.MaDV is null)
--5:
select p.MaPhong,sum(dp.TienDatCoc) 'Tổng tiền đặt cọc' from PHONG p join DAT_PHONG dp on dp.MaPhong=p.MaPhong
where year(dp.NgayDat)=2022
group by p.MaPhong
--6:
select p.MaPhong,p.LoaiPhong,p.SoKhachToiDa,p.GiaPhong,count(dp.MaKH) 'Số lần đặt' from PHONG p join DAT_PHONG dp on dp.MaPhong=p.MaPhong 
where month(dp.NgayDat)=1 and year(dp.NgayDat)=2022
group by p.MaPhong,p.LoaiPhong,p.SoKhachToiDa,p.GiaPhong
having count(dp.MaKH)<10  
--7:
select p.MaPhong from PHONG p
where p.MaPhong not in (select distinct p.MaPhong from DAT_PHONG dp join PHONG p on p.MaPhong=dp.MaPhong and year(dp.NgayDat)=2021)
--p2:
--1:
create proc prc_hienthithongtin (@nam int)
as
begin
select dp.MaDatPhong,dv.TenDV,dv.DonViTinh,ct.SoLuong,dv.DonGia,dp.NgayDat from DAT_PHONG dp join CHI_TIET_SU_DUNG_DV ct on ct.MaDatPhong=dp.MaDatPhong join DICH_VU_DI_KEM dv on dv.MaDV=ct.MaDV
where ct.SoLuong<40 and dv.DonGia<15000 and year(dp.NgayDat)=@nam
end
exec prc_hienthithongtin @nam=2021
--2:
create function func_hienthithongtin1 (@maphong nvarchar(10))
returns nvarchar(10)
as
begin
declare @solandat int
select @solandat=count(dp.MaKH) from PHONG p join DAT_PHONG dp on dp.MaPhong=p.MaPhong
where @maphong=p.MaPhong and month(dp.NgayDat)=8 and year(dp.NgayDat)=2022
group by p.MaPhong
return @solandat
end
select dbo.func_hienthithongtin1 ('MP09') as 'Số lần đặt'


