use Bitirme_Odev;

USE Bitirme_Odev;
GO

-- Tablolar� sil (varsa)
IF OBJECT_ID('siparis_detay', 'U') IS NOT NULL DROP TABLE siparis_detay;
IF OBJECT_ID('siparis', 'U') IS NOT NULL DROP TABLE siparis;
IF OBJECT_ID('urun', 'U') IS NOT NULL DROP TABLE urun;
IF OBJECT_ID('musteri', 'U') IS NOT NULL DROP TABLE musteri;
IF OBJECT_ID('kategori', 'U') IS NOT NULL DROP TABLE kategori;
IF OBJECT_ID('satici', 'U') IS NOT NULL DROP TABLE satici;
GO

-- =====================================================
-- TABLO OLU�TURMA
-- =====================================================

-- 1. Kategori Tablosu
CREATE TABLE kategori(
    id INT PRIMARY KEY IDENTITY(1,1),
    ad NVARCHAR(100) NOT NULL
);
GO

-- 2. Sat�c� Tablosu
CREATE TABLE satici(
    id INT PRIMARY KEY IDENTITY(1,1),
    ad NVARCHAR(100) NOT NULL,
    adres NVARCHAR(MAX)
);
GO

-- 3. M��teri Tablosu
CREATE TABLE musteri(
    id INT PRIMARY KEY IDENTITY(1,1),
    ad NVARCHAR(100) NOT NULL,
    soyad NVARCHAR(100) NOT NULL,
    email NVARCHAR(200) UNIQUE NOT NULL,
    sehir NVARCHAR(100) NOT NULL,
    kayit_tarihi DATE NOT NULL
);
GO

-- 4. �r�n Tablosu
CREATE TABLE urun(
    id INT PRIMARY KEY IDENTITY(1,1),
    ad NVARCHAR(200) NOT NULL,
    fiyat DECIMAL(10,2) NOT NULL,
    stok INT DEFAULT 0,
    kategori_id INT,
    satici_id INT,
    FOREIGN KEY (kategori_id) REFERENCES kategori(id),
    FOREIGN KEY (satici_id) REFERENCES satici(id)
);
GO

-- 5. Sipari� Tablosu
CREATE TABLE siparis(
    id INT PRIMARY KEY IDENTITY(1,1),
    musteri_id INT NOT NULL,
    tarih DATE NOT NULL,
    toplam_tutar DECIMAL(10,2) NOT NULL,
    odeme_turu NVARCHAR(100) NOT NULL CHECK (odeme_turu IN (N'Kredi Kart�', N'Banka Kart�', N'Kap�da �deme', N'Havale')),
    FOREIGN KEY (musteri_id) REFERENCES musteri(id)
);
GO

-- 6. Sipari� Detaylar� Tablosu
CREATE TABLE siparis_detay(
    id INT PRIMARY KEY IDENTITY(1,1),
    siparis_id INT NOT NULL,
    urun_id INT NOT NULL,
    adet INT NOT NULL,
    fiyat DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (siparis_id) REFERENCES siparis(id),
    FOREIGN KEY (urun_id) REFERENCES urun(id)
);
GO

-- =====================================================
-- VER� EKLEME
-- =====================================================

-- Kategoriler
INSERT INTO kategori (ad) VALUES
(N'Elektronik'),
(N'Giyim'),
(N'Ev & Ya�am'),
(N'Kitap'),
(N'Spor & Outdoor'),
(N'Kozmetik'),
(N'Oyuncak'),
(N'Mobilya');
GO

-- Sat�c�lar
INSERT INTO satici (ad, adres) VALUES
(N'TechMaster A.�.', N'�stanbul, Kad�k�y'),
(N'ModaLife Ltd.', N'Ankara, �ankaya'),
(N'HomeStore Tic.', N'�zmir, Bornova'),
(N'KitapD�nyas�', N'�stanbul, Beyo�lu'),
(N'SportZone', N'Antalya, Muratpa�a'),
(N'BeautyShop', N'Bursa, Nil�fer'),
(N'ToysWorld', N'�stanbul, �i�li'),
(N'FurniturePlus', N'Ankara, Yenimahalle');
GO

-- M��teriler
INSERT INTO musteri (ad, soyad, email, sehir, kayit_tarihi) VALUES
(N'Ahmet', N'Y�lmaz', N'ahmet.yilmaz@email.com', N'�stanbul', '2024-01-15'),
(N'Ay�e', N'Demir', N'ayse.demir@email.com', N'Ankara', '2024-02-20'),
(N'Mehmet', N'Kaya', N'mehmet.kaya@email.com', N'�zmir', '2024-03-10'),
(N'Fatma', N'�ahin', N'fatma.sahin@email.com', N'�stanbul', '2024-03-25'),
(N'Ali', N'�elik', N'ali.celik@email.com', N'Bursa', '2024-04-05'),
(N'Zeynep', N'Arslan', N'zeynep.arslan@email.com', N'Antalya', '2024-04-15'),
(N'Can', N'�zt�rk', N'can.ozturk@email.com', N'�stanbul', '2024-05-01'),
(N'Elif', N'Ayd�n', N'elif.aydin@email.com', N'Ankara', '2024-05-20'),
(N'Burak', N'Y�ld�z', N'burak.yildiz@email.com', N'�zmir', '2024-06-10'),
(N'Selin', N'Kurt', N'selin.kurt@email.com', N'�stanbul', '2024-06-25'),
(N'Emre', N'Do�an', N'emre.dogan@email.com', N'Konya', '2024-07-01'),
(N'Deniz', N'Ko�', N'deniz.koc@email.com', N'Adana', '2024-07-15');
GO

-- �r�nler
INSERT INTO urun (ad, fiyat, stok, kategori_id, satici_id) VALUES
-- Elektronik
(N'iPhone 15 Pro', 45999.99, 50, 1, 1),
(N'Samsung Galaxy S24', 38999.99, 30, 1, 1),
(N'MacBook Air M2', 52999.99, 20, 1, 1),
(N'Sony WH-1000XM5 Kulakl�k', 8999.99, 100, 1, 1),
(N'iPad Air', 22999.99, 40, 1, 1),
-- Giyim
(N'Erkek Kot Pantolon', 599.99, 200, 2, 2),
(N'Kad�n Elbise', 899.99, 150, 2, 2),
(N'Spor Ayakkab�', 1299.99, 80, 2, 2),
(N'Kad�n Ceket', 1499.99, 60, 2, 2),
-- Ev & Ya�am
(N'Kahve Makinesi', 2499.99, 45, 3, 3),
(N'Elektrikli S�p�rge', 3999.99, 35, 3, 3),
(N'Tost Makinesi', 899.99, 70, 3, 3),
-- Kitap
(N'Su� ve Ceza', 89.99, 500, 4, 4),
(N'1984', 79.99, 300, 4, 4),
(N'Simyac�', 69.99, 400, 4, 4),
-- Spor
(N'Yoga Mat�', 299.99, 120, 5, 5),
(N'Damb�l Seti 10kg', 599.99, 50, 5, 5),
(N'Ko�u Band�', 8999.99, 15, 5, 5),
-- Kozmetik
(N'Cilt Bak�m Seti', 499.99, 200, 6, 6),
(N'Parf�m', 899.99, 150, 6, 6),
-- Oyuncak
(N'LEGO Star Wars', 1299.99, 80, 7, 7),
(N'Barbie Bebek', 399.99, 100, 7, 7),
-- Mobilya
(N'�al��ma Masas�', 3499.99, 25, 8, 8),
(N'Ofis Koltu�u', 2999.99, 30, 8, 8);
GO

-- =====================================================
-- S�PAR��LER VE DETAYLARI
-- =====================================================

-- M��teri 1 (Ahmet) - 3 sipari�
INSERT INTO siparis (musteri_id, tarih, toplam_tutar, odeme_turu) VALUES 
(1, '2024-06-15', 54999.98, N'Kredi Kart�');
INSERT INTO siparis_detay (siparis_id, urun_id, adet, fiyat) VALUES 
(1, 1, 1, 45999.99),
(1, 4, 1, 8999.99);

INSERT INTO siparis (musteri_id, tarih, toplam_tutar, odeme_turu) VALUES 
(1, '2024-07-20', 3499.99, N'Kredi Kart�');
INSERT INTO siparis_detay (siparis_id, urun_id, adet, fiyat) VALUES 
(2, 23, 1, 3499.99);

INSERT INTO siparis (musteri_id, tarih, toplam_tutar, odeme_turu) VALUES 
(1, '2024-08-10', 1199.98, N'Banka Kart�');
INSERT INTO siparis_detay (siparis_id, urun_id, adet, fiyat) VALUES 
(3, 6, 2, 599.99);
GO

-- M��teri 2 (Ay�e) - 3 sipari�
INSERT INTO siparis (musteri_id, tarih, toplam_tutar, odeme_turu) VALUES 
(2, '2024-06-22', 40299.98, N'Kredi Kart�');
INSERT INTO siparis_detay (siparis_id, urun_id, adet, fiyat) VALUES 
(4, 2, 1, 38999.99),
(4, 19, 1, 499.99);

INSERT INTO siparis (musteri_id, tarih, toplam_tutar, odeme_turu) VALUES 
(2, '2024-08-15', 899.99, N'Banka Kart�');
INSERT INTO siparis_detay (siparis_id, urun_id, adet, fiyat) VALUES 
(5, 20, 1, 899.99);

INSERT INTO siparis (musteri_id, tarih, toplam_tutar, odeme_turu) VALUES 
(2, '2024-09-05', 239.97, N'Kap�da �deme');
INSERT INTO siparis_detay (siparis_id, urun_id, adet, fiyat) VALUES 
(6, 13, 1, 89.99),
(6, 14, 1, 79.99),
(6, 15, 1, 69.99);
GO

-- M��teri 3 (Mehmet) - 2 sipari�
INSERT INTO siparis (musteri_id, tarih, toplam_tutar, odeme_turu) VALUES 
(3, '2024-07-05', 53899.98, N'Kredi Kart�');
INSERT INTO siparis_detay (siparis_id, urun_id, adet, fiyat) VALUES 
(7, 3, 1, 52999.99),
(7, 12, 1, 899.99);

INSERT INTO siparis (musteri_id, tarih, toplam_tutar, odeme_turu) VALUES 
(3, '2024-09-10', 38999.99, N'Kredi Kart�');
INSERT INTO siparis_detay (siparis_id, urun_id, adet, fiyat) VALUES 
(8, 2, 1, 38999.99);
GO

-- M��teri 4 (Fatma) - 3 sipari�
INSERT INTO siparis (musteri_id, tarih, toplam_tutar, odeme_turu) VALUES 
(4, '2024-06-18', 1799.98, N'Kap�da �deme');
INSERT INTO siparis_detay (siparis_id, urun_id, adet, fiyat) VALUES 
(9, 7, 2, 899.99);

INSERT INTO siparis (musteri_id, tarih, toplam_tutar, odeme_turu) VALUES 
(4, '2024-07-25', 6499.98, N'Kredi Kart�');
INSERT INTO siparis_detay (siparis_id, urun_id, adet, fiyat) VALUES 
(10, 11, 1, 3999.99),
(10, 10, 1, 2499.99);

INSERT INTO siparis (musteri_id, tarih, toplam_tutar, odeme_turu) VALUES 
(4, '2024-08-20', 999.98, N'Banka Kart�');
INSERT INTO siparis_detay (siparis_id, urun_id, adet, fiyat) VALUES 
(11, 19, 2, 499.99);
GO

-- M��teri 5 (Ali) - 2 sipari�
INSERT INTO siparis (musteri_id, tarih, toplam_tutar, odeme_turu) VALUES 
(5, '2024-07-12', 9599.98, N'Kredi Kart�');
INSERT INTO siparis_detay (siparis_id, urun_id, adet, fiyat) VALUES 
(12, 18, 1, 8999.99),
(12, 16, 2, 299.99);

INSERT INTO siparis (musteri_id, tarih, toplam_tutar, odeme_turu) VALUES 
(5, '2024-08-05', 239.97, N'Kap�da �deme');
INSERT INTO siparis_detay (siparis_id, urun_id, adet, fiyat) VALUES 
(13, 13, 2, 89.99),
(13, 15, 1, 69.99);
GO

-- M��teri 6 (Zeynep) - 2 sipari�
INSERT INTO siparis (musteri_id, tarih, toplam_tutar, odeme_turu) VALUES 
(6, '2024-08-08', 1399.98, N'Banka Kart�');
INSERT INTO siparis_detay (siparis_id, urun_id, adet, fiyat) VALUES 
(14, 19, 2, 499.99),
(14, 20, 1, 899.99);

INSERT INTO siparis (musteri_id, tarih, toplam_tutar, odeme_turu) VALUES 
(6, '2024-09-15', 2699.97, N'Kredi Kart�');
INSERT INTO siparis_detay (siparis_id, urun_id, adet, fiyat) VALUES 
(15, 6, 3, 599.99),
(15, 8, 1, 1299.99);
GO

-- M��teri 7 (Can) - 2 sipari�
INSERT INTO siparis (musteri_id, tarih, toplam_tutar, odeme_turu) VALUES 
(7, '2024-06-30', 23899.98, N'Kredi Kart�');
INSERT INTO siparis_detay (siparis_id, urun_id, adet, fiyat) VALUES 
(16, 5, 1, 22999.99),
(16, 12, 1, 899.99);

INSERT INTO siparis (musteri_id, tarih, toplam_tutar, odeme_turu) VALUES 
(7, '2024-08-18', 1699.98, N'Banka Kart�');
INSERT INTO siparis_detay (siparis_id, urun_id, adet, fiyat) VALUES 
(17, 21, 1, 1299.99),
(17, 22, 1, 399.99);
GO

-- M��teri 8 (Elif) - 1 sipari�
INSERT INTO siparis (musteri_id, tarih, toplam_tutar, odeme_turu) VALUES 
(8, '2024-07-08', 1499.99, N'Kredi Kart�');
INSERT INTO siparis_detay (siparis_id, urun_id, adet, fiyat) VALUES 
(18, 9, 1, 1499.99);
GO

-- M��teri 9 (Burak) - 2 sipari�
INSERT INTO siparis (musteri_id, tarih, toplam_tutar, odeme_turu) VALUES 
(9, '2024-07-18', 22999.99, N'Kredi Kart�');
INSERT INTO siparis_detay (siparis_id, urun_id, adet, fiyat) VALUES 
(19, 5, 1, 22999.99);

INSERT INTO siparis (musteri_id, tarih, toplam_tutar, odeme_turu) VALUES 
(9, '2024-08-25', 1799.97, N'Banka Kart�');
INSERT INTO siparis_detay (siparis_id, urun_id, adet, fiyat) VALUES 
(20, 16, 3, 299.99),
(20, 17, 2, 599.99);
GO

-- M��teri 10 (Selin) - 1 sipari�
INSERT INTO siparis (musteri_id, tarih, toplam_tutar, odeme_turu) VALUES 
(10, '2024-08-22', 6498.99, N'Kredi Kart�');
INSERT INTO siparis_detay (siparis_id, urun_id, adet, fiyat) VALUES 
(21, 23, 1, 3499.99),
(21, 24, 1, 2999.99);
GO

-- M��teri 11 (Emre) - 1 sipari�
INSERT INTO siparis (musteri_id, tarih, toplam_tutar, odeme_turu) VALUES 
(11, '2024-08-28', 7399.97, N'Kredi Kart�');
INSERT INTO siparis_detay (siparis_id, urun_id, adet, fiyat) VALUES 
(22, 10, 1, 2499.99),
(22, 11, 1, 3999.99),
(22, 12, 1, 899.99);
GO

-- M��teri 12 (Deniz) - 1 sipari�
INSERT INTO siparis (musteri_id, tarih, toplam_tutar, odeme_turu) VALUES 
(12, '2024-09-20', 1699.98, N'Havale');
INSERT INTO siparis_detay (siparis_id, urun_id, adet, fiyat) VALUES 
(23, 21, 1, 1299.99),
(23, 22, 1, 399.99);
GO

-- =====================================================
-- VER� G�NCELLEME VE S�LME
-- =====================================================

-- �r�n Fiyat� G�ncelleme
UPDATE urun SET fiyat = 44999.99 WHERE id = 1;
GO

-- Stok G�ncellemesi (Sat�� D�����)
UPDATE urun SET stok = stok - 1 WHERE id = 1;
UPDATE urun SET stok = stok - 1 WHERE id = 4;
GO

-- M��teri Bilgisi G�ncelleme
UPDATE musteri SET sehir = N'�stanbul' WHERE id = 5;
GO

-- =====================================================
-- TEMEL SORGULAR
-- =====================================================

-- 1. En �ok sipari� veren 5 m��teri
SELECT TOP 5
    m.id,
    m.ad,
    m.soyad,
    COUNT(s.id) AS siparis_sayisi,
    SUM(s.toplam_tutar) AS toplam_harcama
FROM musteri m
JOIN siparis s ON m.id = s.musteri_id
GROUP BY m.id, m.ad, m.soyad
ORDER BY siparis_sayisi DESC;
GO

-- 2. En �ok sat�lan �r�nler
SELECT TOP 10
    u.id,
    u.ad AS urun_adi,
    SUM(sd.adet) AS toplam_satis,
    SUM(sd.adet * sd.fiyat) AS toplam_ciro
FROM urun u
JOIN siparis_detay sd ON u.id = sd.urun_id
GROUP BY u.id, u.ad
ORDER BY toplam_satis DESC;
GO

-- 3. En y�ksek cirolu sat�c�lar
SELECT
    sat.id,
    sat.ad AS satici_adi,
    COUNT(DISTINCT sd.siparis_id) AS siparis_sayisi,
    SUM(sd.adet * sd.fiyat) AS toplam_ciro
FROM satici sat
JOIN urun u ON sat.id = u.satici_id
JOIN siparis_detay sd ON u.id = sd.urun_id
GROUP BY sat.id, sat.ad
ORDER BY toplam_ciro DESC;
GO

-- =====================================================
-- AGGREGATE & GROUP BY
-- =====================================================

-- 4. �ehirlere g�re m��teri say�s�
SELECT 
    sehir,
    COUNT(*) AS musteri_sayisi
FROM musteri
GROUP BY sehir
ORDER BY musteri_sayisi DESC;
GO

-- 5. Kategori bazl� toplam sat��
SELECT
    k.ad AS kategori_adi,
    COUNT(sd.id) AS urun_satis_adedi,
    SUM(sd.adet * sd.fiyat) AS toplam_satis_tutari
FROM kategori k
JOIN urun u ON k.id = u.kategori_id
JOIN siparis_detay sd ON u.id = sd.urun_id
GROUP BY k.id, k.ad
ORDER BY toplam_satis_tutari DESC;
GO

-- 6. Aya g�re sipari� say�s�
SELECT
    FORMAT(tarih, 'yyyy-MM') AS ay,
    COUNT(*) AS siparis_sayisi,
    SUM(toplam_tutar) AS toplam_ciro
FROM siparis
GROUP BY FORMAT(tarih, 'yyyy-MM')
ORDER BY ay;
GO

-- =====================================================
-- JOIN SORGULARI
-- =====================================================

-- 7. Sipari�lerde m��teri bilgisi + �r�n bilgisi + sat�c� bilgisi
SELECT
    s.id AS siparis_id,
    s.tarih,
    m.ad AS musteri_adi,
    m.soyad AS musteri_soyadi,
    u.ad AS urun_adi,
    sd.adet,
    sd.fiyat,
    sat.ad AS satici_adi,
    k.ad AS kategori_adi
FROM siparis s
JOIN musteri m ON s.musteri_id = m.id
JOIN siparis_detay sd ON s.id = sd.siparis_id
JOIN urun u ON sd.urun_id = u.id
JOIN satici sat ON u.satici_id = sat.id
JOIN kategori k ON u.kategori_id = k.id
ORDER BY s.tarih DESC;
GO

-- 8. Hi� sat�lmam�� �r�nler
SELECT
    u.id,
    u.ad AS urun_adi,
    u.fiyat,
    u.stok,
    k.ad AS kategori
FROM urun u 
LEFT JOIN siparis_detay sd ON u.id = sd.urun_id
JOIN kategori k ON u.kategori_id = k.id
WHERE sd.id IS NULL;
GO

-- 9. Hi� sipari� vermemi� m��teriler
SELECT
    m.id,
    m.ad,
    m.soyad,
    m.email,
    m.sehir,
    m.kayit_tarihi
FROM musteri m
LEFT JOIN siparis s ON m.id = s.musteri_id
WHERE s.id IS NULL;
GO

-- =====================================================
-- �LER� SEV�YE SORGULAR
-- =====================================================

-- 10. En �ok Kazan� Sa�layan 3 Kategori
SELECT TOP 3
    k.ad AS kategori_adi,
    COUNT(DISTINCT sd.siparis_id) AS siparis_sayisi,
    SUM(sd.adet) AS toplam_adet,
    SUM(sd.adet * sd.fiyat) AS toplam_kazanc
FROM kategori k
JOIN urun u ON k.id = u.kategori_id
JOIN siparis_detay sd ON u.id = sd.urun_id
GROUP BY k.id, k.ad
ORDER BY toplam_kazanc DESC;
GO

-- 11. Ortalama Sipari� Tutar�n� Ge�en Sipari�ler
SELECT
    s.id,
    m.ad AS musteri_adi,
    m.soyad,
    s.tarih,
    s.toplam_tutar,
    (SELECT AVG(toplam_tutar) FROM siparis) AS ortalama_tutar
FROM siparis s
JOIN musteri m ON s.musteri_id = m.id
WHERE s.toplam_tutar > (SELECT AVG(toplam_tutar) FROM siparis)
ORDER BY s.toplam_tutar DESC;
GO

-- 12. En Az Bir Kez Elektronik Alanlar
SELECT DISTINCT
    m.id,
    m.ad,
    m.soyad,
    m.email
FROM musteri m
JOIN siparis s ON m.id = s.musteri_id
JOIN siparis_detay sd ON s.id = sd.siparis_id
JOIN urun u ON sd.urun_id = u.id
JOIN kategori k ON u.kategori_id = k.id
WHERE k.ad = N'Elektronik'
ORDER BY m.ad;
GO