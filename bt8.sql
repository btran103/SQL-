CREATE DATABASE QUANLYPHONGMAY

USE QUANLYPHONGMAY

create table phongmay(
maphong char(20) not null,
ghichu nvarchar(100),
constraint pk_phongmay primary key (maphong)
)
create table maytinh(
MaMay varchar(20) not null,
TenMay nvarchar(100),
MaPhong varchar(20),
constraint pk_maytinh primary key (mamay)
constraint fk_ma
)
create table monhoc(
MaMon varchar(20) not null,
TenMon nvarchar(100),
SoGio Int,
constraint pk_monhoc primary key (mamon),
)
create table dangky(
MaMon varchar(20) not null,
MaPhong varchar(20) not null,
NgayDK Datetime,
constraint pk_dangky primary key (maphong,mamon),
)
--a. Thêm các ràng buộc khóa ngoài
alter table 
--b. Ngày đăng ký phải lớn hơn hay bằng ngày hiện tại
--c. Mã phòng chỉ nhận các giá trị pm01, pm02, pm03, pm04.
--d. Số giờ >0 và <4
--Nhập dữ liệu cho các bàng ít nhất là 5 dòng mỗi bảng
--Câu 2: Truy vấn:
--1. Cho biết danh sách các phòng máy
--2. Cho biết danh sách các máy tính ở phòng pm02
--3. Cho biết TenMay, maphong, NgayDK cho những môn học có tên SQL
--4. Cho biết những môn học có số giờ đăng ký
--5. Cho biết mỗi phòng có bao nhiêu môn học đăng ký
--6. Tính tổng số giờ của mỗi phòng
--7. Cho biết danh sách các phòng có tổng số giờ >10
--8. Cho biết danh sách các phòng có tổng sogio cao nhất.
--9. Cho biết danh sách các môn học chưa đăng ký phòng thực hành
--10. Cho biết danh sách các môn học có ngày đăng ký trước môn SQL