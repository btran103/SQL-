CREATE DATABASE QuanLyQuanAn;
GO
USE QuanLyQuanAn;
GO

CREATE TABLE Account (
    UserName NVARCHAR(50) PRIMARY KEY,
    Password NVARCHAR(50)
);

CREATE TABLE NhanVien (
    MaNV NVARCHAR(10) PRIMARY KEY,
    HoTen NVARCHAR(100),
    NgaySinh DATE,
    DiaChi NVARCHAR(100),
    DienThoai NVARCHAR(20)
);

CREATE TABLE MonAn (
    MaMon NVARCHAR(10) PRIMARY KEY,
    TenMon NVARCHAR(100),
    DonGia FLOAT
);

CREATE TABLE DatMon (
    STT INT IDENTITY PRIMARY KEY,
    MaMon NVARCHAR(10),
    SoLuong INT,
    MaBan NVARCHAR(10)
);
