USE bEJibun

-- Transaksi Penjualan 
/*
Transaksi Penjualan diurus oleh staff: Kiana Hopper
Transaksi dilakukan pada: 5 Mei 2021
Customer yang membeli adalah Jana Parsons

Unit yang terjual: 
- Apple 24-inch M1 iMac: 2 unit
- Apple Watch Series 6: 3 unit
- Samsung Galaxy Watch 3: 1 unit
*/
GO
INSERT INTO HeaderSalesTransaction VALUES
('SA016', 'ST003', 'CU004', '05-05-2021')

GO
INSERT INTO DetailSalesTransaction VALUES
('SA016', 'IT004', 2),
('SA016', 'IT007', 3),
('SA016', 'IT008', 1)


/*
Transaksi Pembelian ditangani oleh staff: Abdullah Burt
Transaksi dilakukan pada: 14 Oktober 2021
Unit yang terjual: 
- Samsung Galaxy Watch 3: 19 unit

Dibeli dari vendor: Samsung
*/
GO
INSERT INTO HeaderPurchaseTransaction VALUES
('PH016', 'ST004', 'VE002', '10-14-2021', NULL)
GO
INSERT INTO DetailPurchaseTransaction VALUES
('PH016', 'IT008', '19')