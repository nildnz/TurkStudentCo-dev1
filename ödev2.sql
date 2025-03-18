--1.SORU
--integer veya date olan sütunları ::TEXT ile dönüştürürüm.
--unnest(array[...]) ile sütunları açtım. 
--WHERE x IS NOT NULL ile NULL olmayan değerleri filtreledim. 
--SELECT COUNT(*) ile NULL olmayan sütunların sayısını bulurum. 
--eğer COUNT(*) = 0 ise, o satırın tüm sütunları NULL’dır.
--SELECT COUNT(*) FROM invoice kısmı, yukarıdaki koşulu sağlayan satırları sayarak sonucu döndürür.
--row 0


SELECT COUNT(*) 
FROM invoice
WHERE (
    SELECT COUNT(*) 
    FROM unnest(array[
        invoice_id::TEXT, 
        customer_id::TEXT, 
        invoice_date::TEXT, 
        billing_address, 
        billing_city, 
        billing_state, 
        billing_country, 
        billingpostal_code, 
        total::TEXT
    ]) AS x 
    WHERE x IS NOT NULL
) = 0;


--2.SORU
--total AS eski_total orjinal total değerini gösterir.
--total * 2 AS yeni_total Total değerlerinin iki katını hesaplar.
--ORDER BY yeni_total DESC Yeni değere göre büyükten küçüğe sıralar.


SELECT 
    invoice_id, 
    customer_id, 
    total AS eski_total, 
    total * 2 AS yeni_total
FROM invoice
ORDER BY yeni_total DESC;

--3.SORU
--LEFT(billing_address, 3) Adresin ilk 3 karakterini alır.
--RIGHT(billing_address, 4) Adresin son 4 karakterini alır.
--LEFT(...) || '...' || RIGHT(...) İlk ve son karakterleri birleştirip ortasına "..." ekler.
--EXTRACT(YEAR FROM invoice_date) =2013 Yılı 2013 olanları filtreler.
--EXTRACT(MONTH FROM invoice_date) = 8  Ağustos ayını seçer.


SELECT 
    invoice_id, 
    customer_id, 
    LEFT(billing_address, 3) || '...' || RIGHT(billing_address, 4) AS "Açık Adres",
    invoice_date
FROM invoice
WHERE 
    EXTRACT(YEAR FROM invoice_date) = 2013 
    AND EXTRACT(MONTH FROM invoice_date) = 8;

