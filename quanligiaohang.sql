create database quanligiaohang
go
use quanligiaohang 
go
create table khuvuc(
makv char(10) not null,
tenkv nvarchar(20),
constraint pk_khuvuc primary key (makv),
)
  
create table lmh(
malmh char(10) not null,
tenlmh nvarchar(20),
constraint pk_lmh primary key (malmh),
)
  
create table dv(
madv char(10) not null,
tendv nvarchar(70),
constraint pk_dv primary key (madv),
)

create table ktg(
ma_khoang_tg_gh char(10) not null,
mota nvarchar(20),
constraint pk_ktg primary key (ma_khoang_tg_gh),
)

create table khachhang(
makh char(10) not null,
makv char(10),
tenkh nvarchar(20),
tench nvarchar(50),
sdt_kh char(15),
email char(30),
dc_nhanhang nvarchar(100),
constraint pk_khachhang primary key (makh),
constraint fk_khuvuc_khachhang foreign key (makv) references khuvuc(makv),
)

create table tvgh(
matv_gh char(10) not null,
tentv_gh nvarchar(20),
ngaysinh date,
gt nvarchar(5),
sdt_tv char(15),
dc_tv nvarchar(20),
constraint pk_tvgh primary key (matv_gh),
)

create table dkgh(
matv_gh char(10) not null,
ma_khoang_tg_gh char(10) not null,
constraint pk_dkgh primary key (matv_gh,ma_khoang_tg_gh),
constraint fk_tvgh_dkgh foreign key (matv_gh) references tvgh(matv_gh),
constraint fk_ktg_dkgh foreign key (ma_khoang_tg_gh) references ktg(ma_khoang_tg_gh),
)

create table dh_gh(
madh_gh char(10) not null,
makh char(10),
makv char(10),
matv_gh char(10),
madv char(10),
ten_ng_nhan nvarchar(30),
dc_gh nvarchar(20),
sdt_ng_nhan char(15),
ma_khoang_tg_gh char(10),
ngay_gh date,
pttt nvarchar(20),
tt_pheduyet nvarchar(30),
tt_gh nvarchar(30),
constraint pk_dh_gh primary key (madh_gh),
constraint fk_khuvuc_dh_gh foreign key (makv) references khuvuc(makv),
constraint fk_khachhang_dh_gh foreign key (makh) references khachhang(makh),
constraint fk_tvgh_dh_gh foreign key (matv_gh) references tvgh (matv_gh),
constraint fk_ktg_dh_gh foreign key (ma_khoang_tg_gh) references ktg(ma_khoang_tg_gh),
constraint fk_dv_dh_gh foreign key (madv) references dv(madv),
)

create table ctdh(
madh_gh char(10) not null,
tenspgiao nvarchar(20) not null,
soluong int,
trongluong char(10),
malmh char(10),
tienth char(20),
constraint pk_ctdh primary key (madh_gh,tenspgiao),
constraint fk_lmh_ctdh foreign key (malmh) references lmh(malmh),
constraint fk_dh_gh_ctdh foreign key (madh_gh) references dh_gh(madh_gh),
)


use quanligiaohang
--1.Tạo ràng buộc:
-- Phương thức thanh toán nhận 2 giá trị: Chuyển khoản, tiền mặt
alter table dh_gh
add constraint ck_pttt 
check (pttt in(N'Chuyển khoản',N'Tiền mặt'))
-- Số lượng >=1
alter table ctdh
add constraint ck_soluong 
check (soluong>=1)
-- Trạng thái giao hàng nhận 3 giá trị, nhận hàng, không nghe điện thoại, không nhận
alter table dh_gh
add constraint ck_tt_pheduyet 
check(tt_pheduyet in(N'Nhận hàng',N'Không nghe điện thoại',N'Không nhận'))
--Nhập dữ liệu cho các bảng trên.

insert into khuvuc values                                             
('KV01',N'Ngô Mây'),
('KV02',N'Đống Đa'),
('KV03',N'An Dương Vương'),
('KV04',N'Chương Dương'),
('KV05',N'Vũ Bảo'),
('KV06',N'Diên Hồng'),
('KV07',N'An Dương Vương');
select * from khuvuc
drop table khuvuc

insert into lmh values
('MH01',N'Giày dép'),
('MH02',N'Đồ gia dụng'),
('MH03',N'Sắt thép'),
('MH04',N'Nông thủy sản'),
('MH05',N'Máy móc'),
('MH06',N'May mặc'),
('MH07',N'Gỗ');
select * from lmh
drop table lmh 


insert into dv values
('DV01',N'Dịch vụ y tế'),
('DV02',N'Dịch vụ thương mại'),
('DV03',N'Dịch vụ bưu chính viễn thông'),
('DV04',N'Dịch vụ vận chuyển'),
('DV05',N'Dịch vụ công cộng'),
('DV06',N'Dịch vụ du lịch'),
('DV07',N'Dịch vụ nhà hàng và khách sạn');
select * from dv
drop table dv

insert into ktg values 
('KTG01',N'Tốt'),
('KTG02',N'Hư hỏng'),
('KTG03',N'Trung bình'),
('KTG04',N'Chất lượng cao'),
('KTG05',N'Sửa chửa'),
('KTG06',N'Tốt'),
('KTG07',N'Trung bình');
select * from ktg
drop table ktg


insert into khachhang values 
('KH01','KV01',N'Lê Thị An',N'Như Ý','1234589','lean123@gmail.com',N'An Dương Vương'),
('KH02','KV02',N'Nguyễn Mai',N'Như Hòa','1734579','emmai134@gmail.com',N'Ngô Mây'),
('KH03','KV03',N'Lê Thị An',N'Hòa Xuân','1456719','lean167@gmail.com',N'Chương Dương'),
('KH04','KV04',N'Văn Lang',N'Mạnh Hào','1467899','langeptrai111@gmail.com',N'Đống Đa'),
('KH05','KV05',N'Hà Lê Yên',N'Kiên San','1456787','hayen145@gmail.com',N'Lê Hồng Phong'),
('KH06','KV06',N'Bùi Thanh Phú',N'Kiên San','1456787','hayen145@gmail.com',N'Lê Hồng Phong'),
('KH07','KV05',N'Ninh Anh Bùi',N'Kiên San','1456787','hayen145@gmail.com',N'Lê Hồng Phong');
select * from khachhang
drop table khachhang


insert into tvgh values 
('TV01',N'Lê Yến','2003-12-24',N'Nữ','0987654',N'Nguyễn Huệ'),
('TV02',N'Phạm Hùng','2002-01-17',N'Nam','0976591',N'Nguyễn Lê'),
('TV03',N'Trần Cảnh','2001-09-08',N'Nam','0912345',N'Ngô Mây'),
('TV04',N'Phan Lân','1999-04-16',N'Nam','0968791',N'Tây Sơn'),
('TV05',N'Ánh Linh','2005-03-31',N'Nữ','0945712',N'Nguyễn Du'),
('TV06',N'Đỗ Tiến','1998-07-10',N'Nam','0965474',N'Chương Vương'),
('TV07',N'Ý Như','2004-10-18',N'Nữ','0135687',N'Đống Đa');
select * from tvgh
drop table tvgh

insert into dkgh values 
('TV01','KTG02'),
('TV03','KTG03'),
('TV01','KTG04'),
('TV07','KTG01'),
('TV04','KTG05'),
('TV02','KTG02'),
('TV05','KTG04');
select * from dkgh
drop table dkgh


insert into dh_gh values 
('DH01','KH02','KV02','TV01','DV01',N'Nguyễn Văn',N'Chương Dương','012368','KTG02','2022-04-27',N'Tiền mặt',N'Không nghe điện thoại',N'Thất bại'),
('DH02','KH04','KV03','TV03','DV02',N'Lê Hoài',N'An Dương Vương','034567','KTG01','2024-02-16',N'Chuyển khoản',N'Đang giao hàng',N'Thành công'),
('DH03','KH05','KV02','TV04','DV03',N'Phạm Linh',N'Ngô Mây','045678','KTG04','2023-03-10',N'Tiền mặt',N'Không nhận',N'Thất bại'),
('DH04','KH04','KV04','TV02','DV05',N'Thanh Nhã',N'Đống Đa','056789','KTG05','2021-11-26',N'Tiền mặt',N'Không nghe điện thoại',N'Thất bại'),
('DH05','KH05','KV07','TV05','DV06',N'Huyền Ngân',N'Diên Hồng','099112','KTG03','2022-04-01',N'Chuyển khoản',N'Đã giao hàng',N'Thành công'),
('DH06','KH04','KV05','TV07','DV03',N'Đình Hùng',N'Nguyễn Thái Học','035790','KTG06','2023-09-04',N'Tiền mặt',N'Không nghe điện thoại',N'Thất bại'),
('DH07','KH06','KV03','TV02','DV02',N'Nhật Minh',N'Lý Thái Tổ','024680','KTG03','2024-05-19',N'Chuyển khoản',N'Đã giao hàng',N'Thành công');
select * from dh_gh
drop table dh_gh


insert into ctdh values 
('DH01',N'Lê Triển',20,'2000 gam','MH01',750000),
('DH01',N'Hà Trân',null,'0 gam','MH02',000000),
('DH04',N'Trang Nhung',66,'20 gam','MH04',800000),
('DH05',N'Triết Lí',55,'1800 gam','MH02',590000),
('DH02',N'Thái Minh',10,'1000 gam','MH03',720000),
('DH04',N'Kiên Lâm',77,'3000 gam','MH05',630000),
('DH07',N'Tổng Quản',null,'1999 gam','MH07',400000);
select * from ctdh
drop table ctdh

use quanligiaohang
--2.Cập nhật và xóa dữ liệu
--Xóa những khách hàng có tên là “Lê Thị An”.
select * from khachhang
delete from khachhang 
where tenkh=N'Lê Thị An'
--Cập nhật những khách hàng đang thường trú ở khu vực “Ngô mây” thành
--khu vực “Đống Đa”.
update khachhang
set dc_nhanhang=N'Đống Đa'
where dc_nhanhang=N'Ngô Mây'
-- Xóa những khách hàng có địa chỉ ở đường “An Dương Vương”
delete from khachhang 
where dc_nhanhang='An Dương Vương'
--Xóa những khách hàng có trạng thái giao hàng là:”Không nhận”
delete from dh_gh
where tt_pheduyet=N'Không nhận' 
--3.Truy Vấn
-- Liệt kê những thành viên (shipper) có họ tên bắt đầu là ký tự ‘Tr’
select ctdh.tenspgiao 
from ctdh
where ctdh.tenspgiao like 'Tr%'
--Liệt kê những đơn hàng có Ngày Giao Hàng nằm trong năm 2022 và có khu vực giao hàng là “Ngô Mây”.
select dh_gh.ngay_gh,khuvuc.tenkv
from  dh_gh,khuvuc
where dh_gh.makv=khuvuc.makv 
and year(dh_gh.ngay_gh)=2022 or khuvuc.tenkv=N'Ngô Mây'
-- Liệt kê MaDHG, MaTV, Ngày giao hàng, tên thành viên giao hàng,
--PhuongThucThanhToan của tất cả những đơn hàng có trạng thái là “Da giao hang”.
select dh_gh.madh_gh,dh_gh.ngay_gh,ctdh.tenspgiao
from dh_gh,ctdh
where dh_gh.madh_gh=ctdh.madh_gh and dh_gh.tt_pheduyet=N'Đã giao hàng'
--Kết quả hiển thị được sắp xếp tăng dần theo NgayGiaoHang và giảm dần theo
--PhuongThucThanhToan
select dh_gh.ngay_gh,dh_gh.pttt,ctdh.madh_gh
from dh_gh,ctdh
where  dh_gh.madh_gh=ctdh.madh_gh 
order by dh_gh.ngay_gh ASC,dh_gh.pttt DESC
--**Liệt kê những thành viên có giới tính là “Nam” và chưa từng được giao hàng lần nào.
select distinct ctdh.tenspgiao
from ctdh,tvgh
where tvgh.gt=N'Nam' and ctdh.soluong is null
--Liệt kê họ tên của những khách hàng đang có trong hệ thống. Nếu họ tên
--trùng nhau thì chỉ hiển thị 1 lần. Học viên cần thực hiện yêu cầu này bằng 2 cách khác nhau
--c1
select distinct khachhang.tenkh
from khachhang
--c2
-- Liệt kê MaKH, TenKH, địa chỉ nhận hang, MaDHG,
--PhuongThucThanhToan, TrangThaiGiaoHang của tất cả các khách hàng đang có
--trong hệ thống
select khachhang.makh,khachhang.tench,khachhang.dc_nhanhang,dh_gh.madh_gh
from khachhang,dh_gh
where khachhang.makh=dh_gh.makh
--: Liệt kê những thành viên giao hàng có giới tính là “Nu” và từng giao hàng cho 10
--khách hàng khác nhau ở khu vực giao hàng là “Đống Đa”
select distinct tvgh.gt,khachhang.tenkh
from tvgh,khachhang,ctdh
where khachhang.dc_nhanhang=N'Đống Đa' and ctdh.soluong=10
--Liệt kê những khách hàng đã từng yêu cầu giao hàng tại khu vực “Lê Hồng Phong” và 
--chưa từng được một thành viên giao hàng nào có giới tính là “Nam” nhận giao hàng”
select distinct tvgh.gt,khachhang.tenkh
from khachhang,tvgh
where khachhang.dc_nhanhang=N'Lê Hồng Phong' and not exists
(select tv.gt from tvgh tv where tv.gt=tvgh.gt and tv.gt=N'Nam')
-- Cho biết những đơn hàng có tổng số lượng hàng giao >50
select ctdh.trongluong,sum(ctdh.soluong) as tongsoluonghangra
from ctdh
group by ctdh.trongluong
having sum(ctdh.soluong)>50
--Cho biết tháng 4 có bao nhiêu đơn hàng.
select ctdh.soluong,dh_gh.ngay_gh
from ctdh,dh_gh
where ctdh.madh_gh=dh_gh.madh_gh and MONTH(dh_gh.ngay_gh)=4
-- 4.Thủ tục
-- Viết thủ tục đếm xem nhân viên A nào đó giao được bao nhiêu lần trong
--tháng này (nhân viên A là mã nhân viên giao hàng là tham số đầu vào)
create proc nhanvienxem (@nhanvienA char(10)) as
select distinct dh_gh.matv_gh,dh_gh.ngay_gh,ctdh.soluong 
from dh_gh,ctdh
where @nhanvienA=dh_gh.matv_gh
group by dh_gh.matv_gh,dh_gh.ngay_gh,ctdh.soluong 
execute nhanvienxem 'TV01'
drop proc nhanvienxem
--Viết thủ tục tính tổng số lượng hàng giao cho 1 mã loại hàng giao nào đó.
create proc tinhtongsoluonghang(@mahangs char(10)) as 
select ctdh.madh_gh,sum(ctdh.soluong) as tongsoluong
from ctdh
where @mahangs=ctdh.madh_gh
group by ctdh.madh_gh
drop proc tinhtongsoluonghang
execute tinhtongsoluonghang 'DH04' 
-- Viết thủ tục cho biết số đơn hàng mỗi nhân viên giao được trong năm 2022
create proc donhangra as
select tvgh.matv_gh,dh_gh.ngay_gh,ctdh.soluong
from tvgh,dh_gh,ctdh
where tvgh.matv_gh=dh_gh.matv_gh and dh_gh.madh_gh=ctdh.madh_gh and year(dh_gh.ngay_gh)=2022
execute donhangra
drop proc donhangra
-- 5.Hàm
--Viết hàm trả về tổng số lượng của 1 hóa đơn
create function fntongsoluong()
returns int 
begin
declare @soluonghoadon int
select @soluonghoadon=sum(ctdh.soluong) 
from dh_gh,ctdh 
where dh_gh.madh_gh=ctdh.madh_gh 
group by dh_gh.pttt
return @soluonghoadon 
end 
select dbo.fntongsoluong() as [tổng sản phẩm bán ra]
drop function fntongsoluong
-- Viết hàm trả về một bảng gồm những thông tin, MADHG, ngày giao hàng,
--nhân viên giao hàng, trạng thái giao hàng.
create function fntrangthaigiaohang()
returns table 
as 
return (select madh_gh,ngay_gh,matv_gh,tt_gh from dh_gh)
select * from fntrangthaigiaohang()
-- Viết hàm trả về 1 bảng gồm những thông tin MADHG, ngày giao hàng, nhân
--viên giao hàng, khảng thời gian giao hàng.
create function fnconduonggiaohang ()
returns table 
as 
return (select madh_gh,ngay_gh,matv_gh,ma_khoang_tg_gh from dh_gh)
select * from fnconduonggiaohang()
-- 6.Trigger
--Viết Trigger thực hiện công việc chỉ thêm dữ liệu cho bản CTHD khi mã
--giao hàng có trong bảng LMH nếu khoogn có thì thông báo không có mã loại hàng này.
create trigger trigiadd on CTDH
for insert
as
begin
declare @magiaohang varchar(5)
select @magiaohang= MALMH from inserted
if (@magiaohang not in (select MALMH from lmh))
begin
rollback tran
print ('Không được thêm mã dữ liệu vào cthd khi mã lmh không tồn tại trong bảng lmh')
end
end -- check câu trigger
insert into CTDH values ('DH01',N'Áo',7,15,'L09',45000)
--Viết Trigger thực hiện công việc sửa số lượng thành 50 trong bảng CTHD cho đơn hàng “DH01”
create trigger triggsua on CTDH
for update, insert,delete
as
begin
declare @soluong int
select @soluong=soluong from CTDH
where madh_gh='DH01'
if (@soluong != 50) 
begin
update CTDH
set soluong =50
where madh_gh='DH01'
print(N'Đã update toàn bộ số lượng DH01 thành 50')
end
end
---test câu trigger
update CTDH
set soluong =22
where madh_gh='DH01'
