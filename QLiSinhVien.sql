-- 1. Tạo CSDL
CREATE DATABASE QLiSinhVien;
GO
CREATE TABLE TaiKhoan (
    
    TenDangNhap NVARCHAR(50) NOT NULL,
    MatKhau NVARCHAR(50) NOT NULL
);
-- 2. Sử dụng CSDL
USE QLiSinhVien;
GO

-- 3. Tạo bảng KHOA
CREATE TABLE KHOA (
    MaKhoa NVARCHAR(10) PRIMARY KEY,
    TenKhoa NVARCHAR(100)
);

-- 4. Tạo bảng MONHOC
CREATE TABLE MONHOC (
    MaMH NVARCHAR(10) PRIMARY KEY,
    TenMH NVARCHAR(100)
);

-- 5. Tạo bảng SINHVIEN
CREATE TABLE SINHVIEN (
    MaSV NVARCHAR(10) PRIMARY KEY,
    HoTen NVARCHAR(100),
    NgaySinh DATE,
    GioiTinh NVARCHAR(10),
    DiaChi NVARCHAR(200),
    DienThoai NVARCHAR(15),
    MaKhoa NVARCHAR(10),
    FOREIGN KEY (MaKhoa) REFERENCES KHOA(MaKhoa)
);


select*from SINHVIEN