USE bEJibun

-- Insert Customer Table
GO
INSERT INTO MsCustomer VALUES
('CU001','Everly Jacobson','Female','087855536384','10-28-1995'),
('CU002','Libby Thornton','Female','089855590478','03-02-2001'),
('CU003','Imogen Burns','Male','085955559515','02-14-1998'),
('CU004','Jana Parsons','Female','089655568548','08-27-2010'),
('CU005','Alexis Cornish','Male','089855558312','05-30-2005'),
('CU006','Tristan Doyle','Male','083855521464','09-18-2007'),
('CU007','Quinn Iles','Male','083855554284','11-23-2002'),
('CU008','Zackary Wallace','Male','087855571550','12-12-2012'),
('CU009','Amin Hendrix','Male','089755582231','10-10-2010'),
('CU010','Juniper Mellor','Female','081355586885','07-15-2011')

-- Insert Staff Table
GO
INSERT INTO MsStaff VALUES
('ST001','Abdullah Burt','Male','081210431700',5000000),
('ST002','Milli Sadler','Female','081378286654',7500000),
('ST003','Kiana Hopper','Female','081936562393',4500000),
('ST004','Abdullah Burt','Male','081946802533',6000000),
('ST005','Ayse Ho','Female','081237434706',45000000),
('ST006','Alyx Thornton','Female','081209006410',5000000),
('ST007','Hammad Curran','Male','081601891407',5500000),
('ST008','Jerry Powers','Male','081687630312',50000000),
('ST009','Shayla Crawford','Female','081205244650',3000000),
('ST010','Hisham Patton','Male','081128836971',4000000)

-- Insert Vendor Table
GO
INSERT INTO MsVendor VALUES
('VE001','Vivo','088213140229','HR Rasuna Said Street','myvivoindonesia@gmail.com'),
('VE002','Samsung','081385554201','Pasar Minggu Street','cs.care@samsung.com'),
('VE003','Xiaomi','081985558398','Jawa Raya Street','service.id@xiaomi.com'),
('VE004','Bardi','081535557581','Danau Agung II Street','info@bardi.com'),
('VE005','Huawei','0816555849','Pinangsia Raya 1 Street','huawei.id@gmail.com'),
('VE006','Infinix','0878555832','Lobi Tim. Street','service.id@infinixmobility.com'),
('VE007','Apple','0878555480','Mangga Dua Raya Street','appleid@id.apple.com'),
('VE008','JBL','0878578470','Karet Kuningan Street','contact@jbl.com'),
('VE009','Sony','0897555732','Raya Ragunan Street','sonycustomer@sony.com'),
('VE010','Logitech','08821456782','Jend. Sudirman Street','logi.id@gmail.com')

-- insert ItemType Table
GO
INSERT INTO MsItemType VALUES
('IP001','Laptop'),
('IP002','Personal Computer'),
('IP003','Virtual Reality'),
('IP004','Watch'),
('IP005','Headphone'),
('IP006','Keyboard'),
('IP007','Mouse'),
('IP008','Smartphone'),
('IP009','Tablet'),
('IP010','Smart Lighting')

-- Insert Item Table
GO
INSERT INTO MsItem VALUES
('IT001','ASUS ZenBook Flip S',24000000,5,'IP001'),
('IT002','MSI Modern 14 A10RB',11499000,9,'IP001'),
('IT003','ASUS ExpertCenter D840MB',26199000,3,'IP002'),
('IT004','Apple 24-inch M1 iMac',19000000,6,'IP002'),
('IT005','Samsung Gear Vr Oculus',399000,2,'IP003'),
('IT006','Xiaomi Theater VR 3D',2919000,10,'IP003'),
('IT007','Apple Watch Series 6',7999999,2,'IP004'),
('IT008','Samsung Galaxy Watch 3',5999999,13,'IP004'),
('IT009','JBL Tune 750BTNC',2599000,14,'IP005'),
('IT010','Sony WH-1000XM4',4699000,20,'IP005')

-- Insert Header Sales Table
GO
INSERT INTO HeaderSalesTransaction VALUES
('SA001', 'ST001', 'CU001', '04-05-2021'),
('SA002', 'ST003', 'CU004', '01-29-2020'),
('SA003', 'ST005', 'CU002', '04-09-2021'),
('SA004', 'ST010', 'CU008', '08-01-2021'),
('SA005', 'ST004', 'CU001', '09-08-2019'),
('SA006', 'ST008', 'CU005', '09-05-2020'),
('SA007', 'ST007', 'CU003', '07-17-2021'),
('SA008', 'ST002', 'CU006', '09-13-2020'),
('SA009', 'ST004', 'CU009', '12-17-2019'),
('SA010', 'ST006', 'CU010', '01-02-2020'),
('SA011', 'ST001', 'CU007', '05-12-2020'),
('SA012', 'ST004', 'CU008', '09-16-2019'),
('SA013', 'ST003', 'CU001', '10-28-2019'),
('SA014', 'ST002', 'CU002', '05-21-2021'),
('SA015', 'ST006', 'CU010', '08-03-2021')

GO
INSERT INTO DetailSalesTransaction VALUES
('SA001', 'IT002', 10),
('SA002', 'IT008', 20),
('SA003', 'IT005', 5),
('SA004', 'IT001', 8),
('SA005', 'IT010', 24),
('SA006', 'IT005', 4),
('SA008', 'IT009', 15),
('SA009', 'IT009', 18),
('SA010', 'IT003', 5),
('SA011', 'IT005', 3),
('SA012', 'IT006', 17),
('SA013', 'IT006', 14),
('SA014', 'IT002', 10),
('SA015', 'IT002', 9),
('SA014', 'IT006', 14),
('SA013', 'IT003', 5),
('SA012', 'IT004', 8),
('SA011', 'IT006', 12),
('SA010', 'IT001', 9),
('SA009', 'IT002', 10),
('SA008', 'IT004', 27),
('SA007', 'IT003', 10),
('SA006', 'IT003', 8),
('SA005', 'IT004', 7),
('SA004', 'IT007', 5),
('SA003', 'IT006', 15),
('SA002', 'IT009', 15),
('SA001', 'IT010', 26),
('SA002', 'IT003', 4),
('SA003', 'IT003', 9),
('SA004', 'IT003', 8),
('SA005', 'IT003', 21),
('SA006', 'IT007', 6),
('SA007', 'IT004', 9),
('SA008', 'IT008', 19)

GO
INSERT INTO HeaderPurchaseTransaction VALUES
('PH001', 'ST008', 'VE007', '1-23-2021', '2-23-2021'),
('PH002', 'ST006', 'VE003', '2-7-2020', '5-7-2020'),
('PH003', 'ST002', 'VE002', '7-28-2019', '4-26-2020'),
('PH004', 'ST010', 'VE002', '09-23-2021', NULL),
('PH005', 'ST009', 'VE009', '11-6-2020', '1-16-2021'),
('PH006', 'ST001', 'VE005', '4-24-2021', '5-24-2021'),
('PH007', 'ST005', 'VE004', '10-22-2019', '12-21-2019'),
('PH008', 'ST001', 'VE007', '3-7-2021', '4-17-2021'),
('PH009', 'ST009', 'VE010', '4-22-2021', NULL),
('PH010', 'ST008', 'VE001', '9-18-2020', '11-18-2020'),
('PH011', 'ST006', 'VE006', '6-25-2021', '8-25-2021'),
('PH012', 'ST007', 'VE008', '10-30-2021', NULL),
('PH013', 'ST003', 'VE009', '12-19-2020', '2-19-2021'),
('PH014', 'ST004', 'VE002', '2-22-2021', '4-22-2021'),
('PH015', 'ST005', 'VE005', '5-22-2021', NULL)

GO
INSERT INTO DetailPurchaseTransaction VALUES
('PH001', 'IT008', 19),
('PH002', 'IT004', 10),
('PH003', 'IT007', 4),
('PH004', 'IT007', 5),
('PH005', 'IT008', 15),
('PH006', 'IT004', 8),
('PH007', 'IT003', 4),
('PH008', 'IT003', 7),
('PH009', 'IT005', 5),
('PH010', 'IT002', 9),
('PH011', 'IT007', 10),
('PH012', 'IT001', 7),
('PH013', 'IT006', 20),
('PH014', 'IT009', 19),
('PH015', 'IT007', 8),
('PH014', 'IT010', 34),
('PH013', 'IT002', 17),
('PH012', 'IT005', 14),
('PH011', 'IT009', 21),
('PH010', 'IT010', 25),
('PH009', 'IT002', 16),
('PH008', 'IT001', 7),
('PH007', 'IT008', 18),
('PH006', 'IT009', 21),
('PH005', 'IT007', 7)