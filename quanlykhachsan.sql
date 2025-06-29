-- Tạo CSDL
CREATE DATABASE QL_KhachSan;
GO

USE QL_KhachSan;
GO

-- Tạo bảng và dữ liệu
CREATE TABLE KHACH_HANG (
    MaKH CHAR(10) PRIMARY KEY,
    TenKH NVARCHAR(50),
    DiaChi NVARCHAR(100)
);

INSERT INTO KHACH_HANG VALUES ('KH01', N'Nguyễn Văn A', N'Hà Nội'), ('KH02', N'Trần Thị B', N'Phú Yên'), ('KH03', N'Lê Văn C', N'Đà Nẵng');

CREATE TABLE PHONG (
    MaPhong CHAR(10) PRIMARY KEY,
    LoaiPhong NVARCHAR(20),
    SoKhachToiDa INT,
    GiaPhong FLOAT
);

INSERT INTO PHONG VALUES ('P01', N'VIP', 20, 500000), ('P02', N'Thường', 10, 300000), ('P03', N'VIP', 20, 600000);

CREATE TABLE DAT_PHONG (
    MaDatPhong CHAR(10) PRIMARY KEY,
    MaPhong CHAR(10),
    MaKH CHAR(10),
    NgayDat DATE,
    GioBatDau DATETIME,
    GioKetThuc DATETIME,
    TienDatCoc FLOAT,
    FOREIGN KEY (MaPhong) REFERENCES PHONG(MaPhong),
    FOREIGN KEY (MaKH) REFERENCES KHACH_HANG(MaKH)
);

INSERT INTO DAT_PHONG VALUES ('DP01', 'P01', 'KH01', '2022-05-10', '2022-05-10 08:00', '2022-05-10 12:00', 100000), ('DP02', 'P02', 'KH02', '2022-03-15', '2022-03-15 14:00', '2022-03-15 18:00', 0), ('DP03', 'P03', 'KH02', '2022-04-20', '2022-04-20 09:00', '2022-04-20 13:00', 200000);

CREATE TABLE DICH_VU_DI_KEM (
    MaDV CHAR(10) PRIMARY KEY,
    TenDV NVARCHAR(50),
    DonGia FLOAT
);

INSERT INTO DICH_VU_DI_KEM VALUES ('MDV01', N'Nước uống', 10000), ('MDV02', N'Trái cây', 50000), ('MDV03', N'Đồ ăn nhanh', 30000);

CREATE TABLE CHI_TIET_SU_DUNG_DV (
    MaDatPhong CHAR(10),
    MaDV CHAR(10),
    SoLuong INT,
    FOREIGN KEY (MaDatPhong) REFERENCES DAT_PHONG(MaDatPhong),
    FOREIGN KEY (MaDV) REFERENCES DICH_VU_DI_KEM(MaDV)
);

INSERT INTO CHI_TIET_SU_DUNG_DV VALUES ('DP01', 'MDV01', 20), ('DP02', 'MDV03', 50), ('DP03', 'MDV02', 15);





select*from KHACH_HANG

select*from PHONG

select*from DAT_PHONG

select*from DICH_VU_DI_KEM

select*from CHI_TIET_SU_DUNG_DV

--Phần 1 Ngôn ngữ SQL
--CÂU 1
SELECT MaPhong,MaKH, NgayDat, GioBatDau, GioKetThuc, TienDatCoc
from DAT_PHONG
where MONTH(ngaydat)='05' and YEAR(ngaydat)='2022' and TienDatCoc='0'
--CÂU 2
SELECT LoaiPhong, SoKhachToiDa, NgayDat, GioBatDau, GioKetThuc, TienDatCoc
from PHONG, DAT_PHONG
where PHONG.MaPhong=DAT_PHONG.MaPhong and SoKhachToiDa='20' and TienDatCoc='100000'
--CÂU 3
select TenKH, DiaChi, NgayDat, GioBatDau, GioKetThuc
from DAT_PHONG, KHACH_HANG
where YEAR(ngaydat)='2022' and DiaChi like N'%Phú Yên%'
--CÂU 4
UPDATE PHONG SET GiaPhong=GiaPhong*0.8 
WHERE COUNT(MAPHONG)=(SELECT COUNT(DAT_PHONG.MaPhong) FROM DAT_PHONG, PHONG WHERE PHONG.MaPhong=DAT_PHONG.MaPhong
GROUP BY PHONG.MaPhong
HAVING COUNT(DAT_PHONG.MaPhong)=52)
--CÂU 5
select MaPhong, sum(tiendatcoc) as N'Tổng tiền cọc'
from DAT_PHONG
WHERE MONTH(NGAYDAT)='9'
GROUP BY MaPhong
--CÂU 6
SELECT TenKH, DiaChi, COUNT(KHACH_HANG.MAKH) AS N'Số lần đặt'
FROM KHACH_HANG, DAT_PHONG
where KHACH_HANG.MaKH=DAT_PHONG.MaKH and MONTH(ngaydat)='3' and YEAR(ngaydat)='2022'
group by TenKH, DiaChi
having COUNT(khach_hang.makh)>3
--CÂU 7
select TenKH
from KHACH_HANG, DAT_PHONG
where KHACH_HANG.MaKH=DAT_PHONG.MaKH
and KHACH_HANG.MaKH not in (select DAT_PHONG.MaKH from DAT_PHONG, KHACH_HANG where MONTH(ngaydat)='1' and YEAR(ngaydat)='2021')
group by TenKH
--PHẦN 2 LẬP TRÌNH HÀM/THỦ TỤC
-- CÂU 1
create proc proc1(@madv char(10))
as
begin 
	select DICH_VU_DI_KEM.MaDV, SoLuong, NgayDat, SUM(soluong) as N'Tổng số lượng'
	from DICH_VU_DI_KEM, CHI_TIET_SU_DUNG_DV, DAT_PHONG
	where DICH_VU_DI_KEM.MaDV=CHI_TIET_SU_DUNG_DV.MaDV and
	CHI_TIET_SU_DUNG_DV.MaDatPhong=DAT_PHONG.MaDatPhong
	and month(ngaydat)='4' and dich_vu_di_kem.MaDV=@madv
	group by DICH_VU_DI_KEM.MaDV, SoLuong, NgayDat 
	having SUM(soluong)>40
end

execute proc1'MDV03'
--CÂU 2
create function fn_1(@x char(10))
returns float
begin
	declare @tiengio float
	select @tiengio=(giaphong*datediff(HOUR, GioBatDau,GioKetThuc))
	from PHONG, DAT_PHONG
	return @tiengio
end


select DBO.fn_1('KH04') as N'Tiền giờ'