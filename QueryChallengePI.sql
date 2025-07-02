-- Creacion tabla Unificado_Test
CREATE TABLE [dbo].[Unificado_Test](
	[CHROM] [varchar](20) NULL,
	[POS] [varchar](20) NULL,
	[ID] [varchar](50) NULL,
	[REF] [varchar](30) NULL,
	[ALT] [varchar](20) NULL,
	[QUAL] [varchar](30) NULL,
	[FILTER] [varchar](10) NULL,
	[INFO] [varchar](700) NULL,
	[FORMAT] [varchar](100) NULL,
	[MUESTRA] [varchar](20) NULL,
	[VALOR] [varchar](100) NULL,
	[ORIGEN] [varchar](900) NULL,
	[FECHA_COPIA] [datetime] NULL,
	[RESULTADO] [nvarchar](20) NULL
) ON [PRIMARY]

-- Carga de tabla con los datos de la tabla original
INSERT INTO [dbo].[Unificado_Test]
SELECT * FROM [dbo].[Unificado];

-- Limpieza de duplicados previa a carga
WITH duplicados AS(

	SELECT
		ID,
		MUESTRA,
		RESULTADO,
		FECHA_COPIA,
		ROW_NUMBER() OVER (PARTITION BY ID, MUESTRA, RESULTADO ORDER BY FECHA_COPIA DESC) as cant
	FROM [dbo].[Unificado_Test]
)

DELETE FROM [dbo].[Unificado_Test]
WHERE EXISTS(
	SELECT 1
	FROM duplicados
	WHERE duplicados.ID = [dbo].[Unificado_Test].ID
	AND duplicados.MUESTRA =[dbo].[Unificado_Test].MUESTRA
	AND duplicados.RESULTADO = [dbo].[Unificado_Test].RESULTADO
	AND duplicados.cant > 1
	AND duplicados.FECHA_COPIA = [dbo].[Unificado_Test].FECHA_COPIA
);

-- Creacion tabla Log
CREATE TABLE dbo.logs_Unificado_Test(
	ID int IDENTITY(1,1) NOT NULL,
	Archivo varchar(255) NULL,
	Registro_Tabla int NULL,
	Registros_Archivo int NULL,
	Insertados int NULL,
	Actualizados int NULL,
	Fecha_Inicio_Proceso DATETIME NULL,
	Fecha_Fin_Proceso DATETIME NULL,
	Usuario varchar(255) NULL
)




