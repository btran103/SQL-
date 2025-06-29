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


