
--1. Cho biết danh sách những sản phẩm có mã sản phẩm sp01, sp05
create view ds_san_pham 
as select masp,tensp
from sanpham sp
where sp.masp='SP01' or sp.masp= 'SP05'
select * from ds_san_pham 
drop view ds_san_pham 
--2. Cho biết những sản phẩm bán trong tháng 2 năm 2022.
create view spban  
as select sohd,ngayHD 
from hoadon hd
where month(ngayHD)=2 and year(ngayHD)=22
select * from spban
drop view spban 
--3. Tạo view gồm các thông tin masp, tensp, soluong bán, giaban, sohd, ngayhd, thanhtien.
create view
--4. ấn độ đã cung cấp những mặt hàng nào?
create view spad
as select tensp,nuocsx
--5. Sản phẩm Điện thoại di động do nước nào sản xuất?
create view spham 
from 
--6. Những khách hàng nào có doanh số mua hàng cao nhất?
--7. Cho biết những hóa đơn (sohd, ngayhd, trị giá ) cho những hóa đơn có trị giá < trị giá trung bình.
--8. Hãy cho biết tổng số lượng sản phẩm do Việt Nam sản xuất?
--9. Trong đơn hàng số 3 đặt mua những mặt hàng nào và tổng số tiền là bao nhiêu?
--10.Hãy cho biết có những khách hàng nào chưa có số điện thoại?
--11.Trong công ty có những nhân viên nào có cùng ngày sinh?
--12.Những nhân viên nào chưa xuất được hóa đơn trong 30 ngày qua?
--13.Cho biết những sản phẩm có số lượng ít hơn 10?
--14.Tạo view lưu những thông tin khách hàng có số đơn hàng >5.