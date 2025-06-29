create database quanlituyensinh
go 
use quanlituyensinh
go
create table khoa(
makhoa char(4) not null,
tenkhoa nvarchar(100),
)
go 
create table tinh(
matinh char(4) not null,
tentinh nvarchar(100),
)
go
create table nganh(
manganh char(7) not null,
tennganh nvarchar(100),
makhoa char(4),
chitieu int,
)
go
create table truongpt(
matruong char(4) not null,
tentruong nvarchar(100),
matinh char(4),
)
go
create table sinhvien(
masv char(10) not null,
hoten nvarchar(100),
ngaysinh date,
gioitinh bit,
quequan nvarchar(100),
matruong char(4),
manganh char(7),
)
go
create table diem(
masv char(10) not null,
dm1 float,
dm2 float,
dm3 float,
) 
--
select manganh,tennganh,chitieu
from nganh 
where tennganh=N'Kĩ thuật phần mềm' and tennganh=N'Công nghệ thông tin' 

--
select hoten,tennganh,dm1
from sinhvien,nganh,diem
where nganh.manganh=sinhvien.manganh and diem.masv=sinhvien.masv and tennganh=N'Công nghệ thông tin' and dm1>=7
--
select manganh,chitieu,makhoa,avg(chitieu) as trungbinhchitieu,sum(chitieu) as tongchitieu
from nganh 
group by manganh,chitieu,makhoa
--
 alter table sinhvien
 alter column email varchar(30) 
--
select top 1 chitieu,tenkhoa,khoa.makhoa
from nganh,khoa 
where nganh.makhoa=khoa.makhoa
--
 select top 10 avg(dm1+dm2+dm3/3) as trungbinhsinhvien,diem.masv,hoten
 from diem,sinhvien
 where diem.masv=sinhvien.masv 
 group by diem.masv,hoten
 order by trungbinhsinhvien DESC
--
 create proc sp_manganh (@x char(7))
 as 
 begin 
 select * from nganh 
 end 
 execute sp_manganh @x='7480201'
--
create function sp_tongsosinhvien (@x char(7))
returns int
as 
begin
declare @tongso int
select @tongso=sum(masv*manganh)
from sinhvien 
where @x=manganh
return @tongso
end 
select dbo.sp_tongsosinhvien ('7480201') as Tongsosv
