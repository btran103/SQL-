--1  Tổng số tiền mà khách hàng phải trả cho các hóa đơn là bao nhiêu?
select sohd,SUM(soluong*giaban) 'Tong tien' from CTHD group by sohd
--2. Tính tổng số sản phẩm của từng nước sản xuất.
select nuocsx,SUM(gia*soluong) 'Tong so san pham' from sanpham group by nuocsx
--3. Với từng nước sản xuất, tìm giá bán cao nhất, thấp nhất, trung bình của các sản phẩm.
select nuocsx ,MAX(gia) 'Gia lon nhat',MIN(gia) 'gia nho nhat',
avg (gia) 'tb' from sanpham group by nuocsx
--4. Cho biết các mặt hàng đã bán.
select tensp,COUNT(soluong) 'Cac mat hang da ban' from sanpham group by tensp 
--5. Cho biết SOHD, TENSP, SOLUONG, DONGIA, THANHTIEN của hóa đơn số
--HD002.
select ct.soHD ,sp.tensp ,ct.soluong ,sp.gia from sanpham sp 
join CTHD ct on sp.masp=ct.masp where ct.soHD ='HD02'
--6. Cho biet
--THANHTIEN trong đoạn 1 triệu đến 2 triệu.
--7. Tính số lượng bán của mỗi sản phẩm?
select tensp, SUM(soluong) N'Tổng số lượng bán' from sanpham group by tensp
--8. Cho biết số lượng đơn hàng xuất vào tháng 8.
select soluong,COUNT(soluong) 'So luong don hang'from sanpham
--9. Cập nhập cho giá trị trường trị giá trong bảng HOADON, trị giá là tổng
--soluong*dongia của từng hóa đơn.
update hoadon set trigia= (select SUM(soluong*giaban)
from CTHD where CTHD.soHD=hoadon.soHD group by soHD) 
--11.Mỗi nhân viên của công ty đã lập bao nhiêu đơn đặt hàng (nếu chưa từng lập hóa
--đơn nào thì cho kết quả là 0)?
select nhanvien.manv, COUNT(hoadon.sohd) as "so don dat hang"
from nhanvien left join hoadon on nhanvien.manv = hoadon.manv group by nhanvien.manv
--12.Tính tổng số tiền mà công ty thu được từ mỗi mặt hàng trong mỗi năm?
select sanpham.tensp, YEAR(ngayHD) as "Nam", SUM(hoadon.trigia) as "Tong so tien" from hoadon inner join CTHD on hoadon.soHD=cthd.sohd
inner join sanpham on cthd.masp=sanpham.masp group by YEAR(ngayHD), sanpham.tensp
--13.Trong năm 2022 những sản phẩm nào đặt mua đúng một lần?

--14.Số tiền nhiều nhất mà khách hàng bỏ ra để mua hàng là bao nhiêu?
--15.Xóa những đơn đặt hàng có tổng số lượng đặt < 5.
select 
--16.Cho biết tên sản phẩm, tổng số lượng bán theo từng ngày
--17.Cho biết các sản phẩm có trung bình số lượng bán lớn hơn 15
--18.Cho biết những đơn đặt hàng có số sản phẩm < 4
select sohd,COUNT(masp) N'Số sp' from CTHD group by soHD having COUNT(masp)<4
select * from hoadon
alter table hoadon alter column trigia int Null
--19.Cho biết trị giá của hóa đơn HD05?

--20.Cho biết đơn đặt hàng nào có doanh thu cao nhất biết doanh thu bằng trị giá -
--gia*soluong (số lượng bán)
select tensp, sum(giaban*cthd.soluong)-sum(CTHD.soluong*gia) from sanpham, CTHD where CTHD.masp=sanpham.masp group by tensp
having sum(giaban*cthd.soluong)-sum(CTHD.soluong*gia)= (select top 1 sum(giaban*cthd.soluong)-sum(CTHD.soluong*gia) as sl from sanpham, CTHD
where CTHD.masp=sanpham.masp group by tensp order by sl desc ) 'Cho biet don dat hang'