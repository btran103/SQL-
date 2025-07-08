USE QLBANHANG

--1. Mã sản phẩm, tên sản phẩm và số lượng sản phẩm hiện có trong công ty?
SELECT sanpham.masp, sanpham.tensp, sanpham.soluong
FROM sanpham
--2. Địa chỉ, điện thoại của các khách hàng ở Bình Định? 
SELECT khachhang.diachi, khachhang.sodt
FROM khachhang
WHERE khachhang.diachi LIKE N'%BÌNH ĐỊNH%'
--3. Mã và tên sản phẩm có giá lớn hơn 100000 và số lượng hiện có ít hơn 50
SELECT sanpham.masp, sanpham.tensp
FROM sanpham
WHERE (sanpham.gia> 10000) AND (sanpham.soluong< 100)
--4. Những sản phẩm nào được sản xuất ở Việt Nam? 
SELECT sanpham.tensp
FROM sanpham
WHERE nuocsx like N'%VIỆT NAM%'
--5. Những khách hàng nào đã mua sữa của công ty? 
SELECT khachhang.hoten 
FROM khachhang,SanPham,CTHD,HoaDon
WHERE khachhang.Makh=HoaDon.makh AND HoaDon.soHD=CTHD.sohd and CTHD.masp=SanPham.masp and SanPham.tensp LIKE N'%HOA%'
SELECT * FROM HoaDon
--6. Đơn hàng số HD01 do ai đặt và do nhân viên nào lập, trị giá là bao nhiêu? 
SELECT Khachhang.hoten,NhanVien.hoten,HoaDon.trigia
FROM HoaDon, NhanVien, Khachhang
WHERE Khachhang.Makh=HoaDon.makh AND NhanVien.manv=HoaDon.manv AND HoaDon.soHD=N'HD01'
--7. Hãy cho biết có những nhân viên nào lại chính là khách hàng của công ty (có cùng  sodt) 
SELECT NhanVien.hoten, NhanVien.sodt 
FROM NhanVien, Khachhang
WHERE NhanVien.sodt=Khachhang.sodt
--8. Họ tên, địa chỉ và ngày bắt đầu làm việc của các nhân viên trong công ty có ngày  bắt đầu là ngày 17/3/2022? 
SELECT NhanVien.hoten, NhanVien.manv, NhanVien.ngaylamviec
FROM NhanVien
WHERE ngaylamviec like '2022-03-17'
--9. Liệt kê danh sách những nhân viên có cùng ngày sinh. 

SELECT v1.manv, v1.hoten,v1.ngaysinh
FROM NhanVien v1, NhanVien v2 
WHERE v1.NgaySinh = v2.Ngaysinh And v1.manv <> v2.manv

--10.Những nhân viên nào của công ty có thâm niên cao nhất? 

SELECT TOP (1) NhanVien.hoten, NhanVien.gioitinh,
YEAR(GETDATE())-YEAR(NhanVien.ngaylamviec) AS tglam
FROM NhanVien 
ORDER BY tglam DESC
--hoac 
SELECT TOP (5) NhanVien.hoten, NhanVien.gioitinh,
DATEDIFF (DAY,NhanVien.ngaylamviec,GETDATE()) AS tglam
FROM NhanVien 
ORDER BY tglam DESC

--11.Cho biết thông tin TENSP, SOLUONG, DVT, SOHD, HOTEN của những khách  hàng có địa chỉ ở BÌNH ĐỊNH săp xếp tăng dần theo SOHD

SELECT SanPham.tensp, CTHD.soluong, SanPham.dvt, HoaDon.soHD, Khachhang.hoten, diachi
FROM SanPham, CTHD, HoaDon, Khachhang
WHERE SanPham.masp=CTHD.masp AND CTHD.sohd=HoaDon.soHD AND HoaDon.makh=Khachhang.makh and Khachhang.diachi like N'%BÌNH ĐỊNH%'
ORDER BY HoaDon.soHD ASC

--12.Cho biết thông tin TENSP, SOLUONG, DVT, SOHD vủa những hóa đơn có ngày và tháng trùng với ngày và tháng của ngày hiện tại (ngày đang làm thực hành)

SELECT SanPham.tensp, CTHD.soluong, SanPham.dvt, HoaDon.soHD
FROM SanPham, CTHD, HoaDon
WHERE SanPham.masp=CTHD.masp AND CTHD.sohd=HoaDon.soHD AND DAY(ngayHD)=DAY(GETDATE()) AND MONTH(ngayHD)=MONTH(GETDATE())

13.Cho biết thông tin của những sản phẩm bán trong tháng 2, 3. 
SELECT SanPham.tensp,CTHD.*, HoaDon.ngayHD FROM SanPham, HoaDon, CTHD
WHERE SanPham.masp=CTHD.masp AND CTHD.sohd=HoaDon.soHD AND SanPham.masp=SanPham.masp AND MONTh(ngayHD)=2 OR MONTh(ngayHD)=3
14.Hiển thị những thông tin : Masp, TenSP, NuocSX, số lượng bán, (Những sản phẩm nào chưa được bán cũng được hiển thị thông tin). 
SELECT SanPham.masp, SanPham.tensp, SanPham.nuocsx, CTHD.soluong as soluongban
FROM SanPham,CTHD
WHERE SanPham.masp=CTHD.masp
15.Hiển thị những thông tin : TenKH, Địa chỉ, SoDT, SoHD, (Những khách  hàng chưa mua lần nào cũng được hiển thị thông tin).  

SELECT Khachhang.hoten,Khachhang.diachi,Khachhang.sodt,HoaDon.soHD
FROM Khachhang, HoaDon
 Khachhang*=HoaDon

--16.Tạo bảng LUU những sản phẩm được mua trong tháng 3 năm 2022.
			--SELECT *FROM SP_Thang3_2022
			--drop table SP_Thang3_2022

SELECT SanPham.masp, SanPham.tensp,CTHD.soluong, HoaDon.ngayHD
INTO SP_Thang3_2022
FROM SanPham, HoaDon, CTHD
WHERE SanPham.masp=CTHD.masp and HoaDon.soHD=CTHD.sohd and MONTH(ngayHD)=3 and YEAR(ngayHD)=2022

--17.Xóa những hóa đơn của khách hàng có địa chỉ ở Côn Đảo 

DELETE FROM Khachhang
where Khachhang.diachi like N'%CÔN ĐẢO%'
--SELECT *FROM Khachhang

--18.Cập nhật lại giá tăng lên 10% so với giá hiện tại cho những sản phẩm có tên bắt đầu  bằng chữ N. 

UPDATE SanPham
SET gia=gia+gia*10/100
FROM SanPham
WHERE SanPham.tensp like N'N%'

--19.Đơn hàng hd01 do nhân viên nào lập và địa chỉ giao hàng ở dâu. 

SELECT NhanVien.hoten, Khachhang.diachi--, HoaDon.soHD
FROM HoaDon,NhanVien, Khachhang
WHERE HoaDon.manv=NhanVien.manv and HoaDon.makh=Khachhang.Makh and HoaDon.soHD=N'HD01'

--20.Liệt kê những sản phẩm bán trong ngày 18/2. 
SELECT SanPham.tensp, HoaDon.ngayHD
FROM SanPham, CTHD, HoaDon
WHERE SanPham.masp=CTHD.masp and HoaDon.soHD=CTHD.sohd and MONTH(HoaDon.ngayHD)=2 and DAY(HoaDon.ngayHD)=18
Bài làm thêm 
Bài 2: Sử dụng csdl QLDUAN thực hiện các câu truy vấn sau: 
1. Tìm những nhân viên làm việc ở phòng số 4  
2. Tìm những nhân viên có mức lương trên 30000  
3. Tìm tên và địa chỉ của tất cả các nhân viên của phòng "Nghien cuu". 
4. Tìm các nhân viên có mức lương trên 25,000 ở phòng 4 hoặc các nhân viên  có mức lương trên 30,000 ở phòng 5  
5. Cho biết họ tên đầy đủ của các nhân viên ở TP HCM  
6. Cho biết họ tên đầy đủ của các nhân viên có họ bắt đầu bằng ký tự ‘N’  
7. Với mỗi phòng ban, cho biết tên phòng ban và địa điểm phòng  
8. Tìm tên những người trưởng phòng của từng phòng ban  
9. Tìm TENDA, MADA, DDIEM_DA, PHONG, TENPHG, MAPHG,  NG_NHANCHUC 
