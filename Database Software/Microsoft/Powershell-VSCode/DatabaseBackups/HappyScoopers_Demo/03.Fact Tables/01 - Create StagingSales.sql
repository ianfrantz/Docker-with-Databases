USE [HappyScoopers_DW]
GO

--Drop the table, to make sure you create it from scratch
DROP TABLE IF EXISTS [dbo].[Staging_Sales]
GO

-- Create the staging table
CREATE TABLE [dbo].[Staging_Sales](
	[Staging Sale Key] [bigint] IDENTITY(1,1) NOT NULL,
	[Customer Key] [int] NULL,
	[Employee Key] [int] NULL,
	[Product Key] [int] NULL,
	[Payment Type Key] [int] NULL,
	[Order Date Key] [int] NULL,
	[Delivery Date Key] [int] NULL,
	[Delivery Location Key] [int] NULL,
	[Promotion Key] [int] NULL,
	[Description] [nvarchar](100) NULL,
	[Package] [nvarchar](50) NULL,
	[Quantity] [int] NULL,
	[Unit Price] [decimal](18, 2) NULL,
	[VAT Rate] [decimal](18, 3) NULL,
	[Total Excluding VAT] [decimal](18, 2) NULL,
	[VAT Amount] [decimal](18, 2) NULL,
	[Total Including VAT] [decimal](18, 2) NULL,
	[ModifiedDate] [datetime] NULL,
	[_SourceOrder] [nvarchar](50) NULL,
	[_SourceOrderLine] [nvarchar](50) NULL,
	[_SourceCustomerKey] [int] NULL,
	[_SourceEmployeeKey] [int] NULL,
	[_SourceProductKey] [int] NULL,
	[_SourcePaymentTypeKey] [int] NULL,
	[_SourceOrderDateKey] [date] NULL,
	[_SourceDeliveryDateKey] [date] NULL,
	[_SourceDeliveryCountryKey] [int] NULL,
	[_SourceDeliveryProvinceKey] [int] NULL,
	[_SourceDeliveryCityKey] [int] NULL,
	[_SourceDeliveryAddressKey] [int] NULL,
	[_SourceDeliveryLocationKey] [nvarchar](50) NULL,
	[_SourcePromotionKey] [int] NULL
) ON [PRIMARY]
GO


