
CREATE TABLE [dbo].[transactions](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[code] [char](38) NULL,
	[obj_codes_by] [nvarchar](max) NULL,
	[part_aggregate] [char](25) NULL
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[object_code](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[acceptance_date] [datetime] NULL,
	[code] [char](12) NULL,
	[dati] [nvarchar](max) NULL,
	[expiration_date] [datetime] NULL,
	[product_details] [nvarchar](max) NULL,
	[sale_date] [datetime] NULL,
	[status] [char](10) NULL,
	[transactions] [nvarchar](max) NULL
) ON [PRIMARY]
GO

-- Generate synthetic transactions table (100M)
INSERT TOP (100000000)  
	INTO transactions (code,obj_codes_by,part_aggregate)
SELECT 
	REPLACE(CONVERT(VARCHAR,(RAND(CHECKSUM(NEWID())) * 30000 + CAST('1945' AS DATETIME)),23) ,'-','') + REPLACE(STR(CONVERT(INT,(RAND(CHECKSUM(NEWID())) * 3000)), 10), ' ' , '0') + REPLACE(STR(CONVERT(INT,(RAND(CHECKSUM(NEWID())) * 3000)), 10), ' ' , '0') + REPLACE(STR(CONVERT(INT,(RAND(CHECKSUM(NEWID())) * 3000)), 10), ' ' , '0'),
	'{\"'+ REPLACE(CONVERT(VARCHAR,(RAND(CHECKSUM(NEWID())) * 30000 + CAST('1945' AS DATETIME)),23) ,'-','') + REPLACE(STR(CONVERT(INT,(RAND(CHECKSUM(NEWID())) * 3000000)), 10), ' ' , '0') + REPLACE(STR(CONVERT(INT,(RAND(CHECKSUM(NEWID())) * 3000000)), 10), ' ' , '0') + REPLACE(STR(CONVERT(INT,(RAND(CHECKSUM(NEWID())) * 3000000)), 10), ' ' , '0') +'\": [{\"canale\": \"SDP\", \"objcods\": [{\"code\": \"'+REPLACE(STR(CONVERT(INT,(RAND(CHECKSUM(NEWID())) * 3000000)), 12), ' ' , '0')+'\"}, {\"code\": \"'+REPLACE(STR(CONVERT(INT,(RAND(CHECKSUM(NEWID())) * 3000000)), 12), ' ' , '0')+'\"}, {\"code\": \"'+REPLACE(STR(CONVERT(INT,(RAND(CHECKSUM(NEWID())) * 3000000)), 12), ' ' , '0')+'\"}], \"sportello\": \"1\", \"datasistema\": \"20190304125114234\", \"frazionario\": \"1\", \"progressivo\": 1, \"datacontabile\": {\"anno\": \"2019\", \"mese\": \"04\", \"giorno\": \"04\"}, \"currentTimestamp\": 1554374375162, \"numeroOperazione\": 1}], \"20190404000000000100000000010000000002\": [{\"canale\": \"OMP\", \"objcods\": [{\"code\": \"149206769258\"}, {\"code\": \"149206769269\"}, {\"code\": \"149206769281\"}], \"sportello\": \"1\", \"datasistema\": \"20190304125114234\", \"frazionario\": \"1\", \"progressivo\": 2, \"datacontabile\": {\"anno\": \"2019\", \"mese\": \"04\", \"giorno\": \"04\"}, \"currentTimestamp\": 1554374382497, \"numeroOperazione\": 2}, {\"canale\": \"OMP\", \"objcods\": [{\"code\": \"149206769258\"}, {\"code\": \"149206769269\"}, {\"code\": \"149206769281\"}], \"sportello\": \"1\", \"datasistema\": \"20190304125114234\", \"frazionario\": \"1\", \"progressivo\": 2, \"datacontabile\": {\"anno\": \"2019\", \"mese\": \"04\", \"giorno\": \"04\"}, \"currentTimestamp\": 1554374409363, \"numeroOperazione\": 0}]}',
	'{\"currProgressive\": 2}'
FROM 
	syscolumns sc1, syscolumns sc2, syscolumns sc3

-- Create non-clustered index to support key lookup queries on "code" column
CREATE NONCLUSTERED INDEX nclTran ON transactions(code)
	
-- Generate synthetic object_code table (5M)
INSERT TOP (5000000)
	INTO object_code (acceptance_date,code,dati,expiration_date,product_details,sale_date,status,transactions)
SELECT
	(RAND(CHECKSUM(NEWID())) * 30000 + CAST('1945' AS DATETIME)),
	REPLACE(STR(CONVERT(INT,(RAND(CHECKSUM(NEWID())) * 3000000)), 12), ' ' , '0'),
	'{\"reale\": {\"peso\": 5000, \"altezza\": \"005\", \"larghezza\": \"008\", \"lunghezza\": \"004\"}, \"prezzo\": {\"iva\": 0, \"sconto\": 0, \"regimeIVA\": \"F8\", \"imponibile\": 1350, \"ivaservizi\": 600, \"preregolato\": \"\", \"dirittiDoganali\": 0, \"imponibileservizi\": 300}, \"servizi\": {\"AC1\": {\"iva\": 22, \"regimeIVA\": \"F8\", \"imponibile\": \"100\"}, \"AS1\": {\"iva\": 0, \"regimeIVA\": \"N4\", \"imponibile\": 300, \"importoassicurato\": \"10293\"}, \"CC1\": {\"iva\": 110, \"iban\": \"231236876128381\", \"regimeIVA\": \"F8\", \"imponibile\": 500}, \"CND\": {\"iva\": 0, \"regimeIVA\": \"F8\", \"imponibile\": 0}, \"CV1\": {\"iva\": 110, \"regimeIVA\": \"F8\", \"imponibile\": 500}, \"PKU\": {\"iva\": 0, \"regimeIVA\": \"F8\", \"imponibile\": 0}, \"cisaouid\": {\"meraviglio\": \"ciaciao\"}}, \"copieLDV\": 1, \"mittente\": {\"cap\": null, \"civico\": null, \"comune\": null, \"nazione\": null, \"indirizzo\": null, \"provincia\": null, \"nomeCongome\": null}, \"attributi\": {\"DO_PREP\": \"99\", \"IMP_CTRS\": \"600\", \"VALO_ASSI\": \"12300\"}, \"contenuto\": {}, \"dichiarato\": {\"peso\": 5000, \"altezza\": \"005\", \"larghezza\": \"008\", \"lunghezza\": \"004\"}, \"codicePadre\": \"\", \"destinatario\": {\"cap\": 88100, \"civico\": null, \"comune\": null, \"nazione\": \"ITA1\", \"indirizzo\": null, \"provincia\": null, \"nomeCongome\": null}}',
	(RAND(CHECKSUM(NEWID())) * 30000 + CAST('1945' AS DATETIME)),
	'{\"id\": 5, \"esito\": {\"code\": 0, \"message\": \"\"}, \"barcode\": \"149206769258\", \"emitter\": [\"NBEP\"], \"formato\": \"B\", \"prodotto\": \"B\", \"scadenza\": 365, \"tipoProdotto\": \"P\", \"sottoprodotto\": \"B--LS\"}',
	(RAND(CHECKSUM(NEWID())) * 30000 + CAST('1945' AS DATETIME)),
	'ACCETTATO',
	'[{\"code3\": \"2019040400000000010000000001\", \"code4\": \"20190404000000000100000000010000000001\", \"canale\": \"SDP\", \"nextState\": \"PREPAGATO\", \"sportello\": \"1\", \"dataSistema\": \"20190304125114234\", \"frazionario\": \"1\", \"progressivo\": 1, \"currentState\": \"EMESSO\", \"datacontabile\": {\"anno\": \"2019\", \"mese\": \"04\", \"giorno\": \"04\"}, \"currentTimestamp\": 1554374375126, \"idRefTransazione\": null, \"numeroOperazione\": 1}, {\"code3\": \"2019040400000000010000000001\", \"code4\": \"20190404000000000100000000010000000002\", \"canale\": \"OMP\", \"nextState\": \"ACCETTATO\", \"sportello\": \"1\", \"dataSistema\": \"20190304125114234\", \"frazionario\": \"1\", \"progressivo\": 2, \"currentState\": \"PREPAGATO\", \"datacontabile\": {\"anno\": \"2019\", \"mese\": \"04\", \"giorno\": \"04\"}, \"currentTimestamp\": 1554374382493, \"idRefTransazione\": \"20190404000000000100000000010000000001\", \"numeroOperazione\": 2}, {\"code3\": \"2019040400000000020000000002\", \"code4\": \"20190404000000000200000000020000000003\", \"canale\": \"OMP\", \"nextState\": \"PREPAGATO\", \"sportello\": \"2\", \"dataSistema\": \"20190304125114234\", \"frazionario\": \"2\", \"progressivo\": 3, \"currentState\": \"ACCETTATO\", \"datacontabile\": {\"anno\": \"2019\", \"mese\": \"04\", \"giorno\": \"04\"}, \"currentTimestamp\": 1554374400100, \"idRefTransazione\": \"20190404000000000100000000010000000002\", \"numeroOperazione\": 3}, {\"code3\": \"2019040400000000010000000001\", \"code4\": \"20190404000000000100000000010000000002\", \"canale\": \"OMP\", \"nextState\": \"ACCETTATO\", \"sportello\": \"1\", \"dataSistema\": \"20190304125114234\", \"frazionario\": \"1\", \"progressivo\": 2, \"currentState\": \"PREPAGATO\", \"datacontabile\": {\"anno\": \"2019\", \"mese\": \"04\", \"giorno\": \"04\"}, \"currentTimestamp\": 1554374409306, \"idRefTransazione\": \"20190404000000000200000000020000000003\", \"numeroOperazione\": 0}]'
FROM 
syscolumns sc1, syscolumns sc2, syscolumns sc3

-- Create non-clustered index to support key lookup queries on "code" column
CREATE NONCLUSTERED INDEX nclObject ON object_code(code)

----------------------------------
-- Test queries
----------------------------------

-- Size on disk and rows
sp_spaceused transactions
sp_spaceused object_code

SET STATISTICS IO ON
SET STATISTICS TIME ON

-- NBEP and SDA use case
SELECT * FROM transactions WHERE code = '19980131000000286700000026390000002536'
SELECT * FROM object_code WHERE code in ('000001419421', '000002207448', '000002302602' )

-- NBEP update transactions table use case
DECLARE @P0 AS nvarchar(4000)
SELECT @P0=obj_codes_by FROM transactions WHERE code = '19980131000000286700000026390000002536'
UPDATE transactions SET obj_codes_by = '{"20000216000074191500025231770001314917": [{"canale": "SDP", "objcods": [{"code": "000001342734"}, {"code": "000000020915"}, {"code": "000000539449"}], "sportello": "1", "datasistema": "20190304125114234", "frazionario": "1", "progressivo": 1, "datacontabile": {"anno": "2019", "mese": "04", "giorno": "04"}, "currentTimestamp": 1554374375162, "numeroOperazione": 1}], "20190404000000000100000000010000000002": [{"canale": "OMP", "objcods": [{"code": "149206769258"}, {"code": "149206769269"}, {"code": "149206769281"}], "sportello": "1", "datasistema": "20190304125114234", "frazionario": "1", "progressivo": 2, "datacontabile": {"anno": "2019", "mese": "04", "giorno": "04"}, "currentTimestamp": 1554374382497, "numeroOperazione": 2}, {"canale": "OMP", "objcods": [{"code": "149206769258"}, {"code": "149206769269"}, {"code": "149206769281"}], "sportello": "1", "datasistema": "20190304125114234", "frazionario": "1", "progressivo": 2, "datacontabile": {"anno": "2019", "mese": "04", "giorno": "04"}, "currentTimestamp": 1554374409363, "numeroOperazione": 0}]}' WHERE code = '19980131000000286700000026390000002536'

-- Extract sample codes for testing client random calls
SELECT TOP 10000 code FROM transactions TABLESAMPLE(0.01 PERCENT)

-- Extract JSON fragments as relational attributes
DECLARE @objcodes NVARCHAR(MAX)
SELECT TOP 1 
	@objcodes=JSON_QUERY(REPLACE(obj_codes_by,'\',''),'$."20000216000074191500025231770001314917"[0].objcods')
FROM transactions t
WHERE code = '19980131000000286700000026390000002536'
SELECT y.[value] as code FROM OPENJSON(@objcodes,'$') as x
					CROSS APPLY OPENJSON(x.[value],'$') as y

-- Add calculated column
ALTER TABLE transactions
ADD vCalcCode AS JSON_VALUE(REPLACE(obj_codes_by,'\',''),'$."20000216000074191500025231770001314917"[0].objcods[0].code')

-- Create index on calculated column
CREATE INDEX idx_transaction_json_vCode	ON transactions(vCalcCode)  

-- Key lookup and calculated column (test comparison with client statistics)
-- before
SELECT * FROM transactions WHERE code = '19980131000000286700000026390000002536'
-- after
SELECT code, vCalcCode FROM transactions t WHERE code = '19980131000000286700000026390000002536'

-- Update partial fragment on the JSON document (test comparison with client statistics)
-- before
UPDATE transactions SET  obj_codes_by =	'{"20000216000074191500025231770001314917": [{"canale": "SDP", "objcods": [{"code": "000001342734"}, {"code": "000000020915"}, {"code": "000000539449"}], "sportello": "1", "datasistema": "20190304125114234", "frazionario": "1", "progressivo": 1, "datacontabile": {"anno": "2019", "mese": "04", "giorno": "04"}, "currentTimestamp": 1554374375162, "numeroOperazione": 1}], "20190404000000000100000000010000000002": [{"canale": "OMP", "objcods": [{"code": "149206769258"}, {"code": "149206769269"}, {"code": "149206769281"}], "sportello": "1", "datasistema": "20190304125114234", "frazionario": "1", "progressivo": 2, "datacontabile": {"anno": "2019", "mese": "04", "giorno": "04"}, "currentTimestamp": 1554374382497, "numeroOperazione": 2}, {"canale": "OMP", "objcods": [{"code": "149206769258"}, {"code": "149206769269"}, {"code": "149206769281"}], "sportello": "1", "datasistema": "20190304125114234", "frazionario": "1", "progressivo": 2, "datacontabile": {"anno": "2019", "mese": "04", "giorno": "04"}, "currentTimestamp": 1554374409363, "numeroOperazione": 0}]}' WHERE code = '19980131000000286700000026390000002536'
-- after
UPDATE transactions SET  obj_codes_by = JSON_MODIFY (REPLACE(obj_codes_by,'\',''), '$."20000216000074191500025231770001314917"[0].objcods[0].code', '000001342734' ) WHERE code = '19980131000000286700000026390000002536'

SET STATISTICS IO OFF
SET STATISTICS TIME OFF
----------------------------------

