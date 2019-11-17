USE [HappyScoopers_DW]
GO

--Drop the fact table, to make sure you create it from scratch
DROP TABLE IF EXISTS [dbo].[Fact_Sales]
GO

-- Create the fact table
CREATE TABLE [dbo].[Fact_Sales](
	[Sale Key] [bigint] IDENTITY(1,1) NOT NULL,
	[Customer Key] [int] NOT NULL,
	[Employee Key] [int] NOT NULL,
	[Product Key] [int] NOT NULL,
	[Payment Type Key] [int] NOT NULL,
	[Order Date Key] [int] NOT NULL,
	[Delivery Date Key] [int] NULL,
	[Delivery Location Key] [int] NULL,
	[Promotion Key] [int] NOT NULL,
	[Description] [nvarchar](100) NOT NULL,
	[Package] [nvarchar](50) NOT NULL,
	[Quantity] [int] NULL,
	[Unit Price] [decimal](18, 2) NULL,
	[VAT Rate] [decimal](18, 3) NULL,
	[Total Excluding VAT] [decimal](18, 2) NULL,
	[VAT Amount] [decimal](18, 2) NULL,
	[Total Including VAT] [decimal](18, 2) NULL,
	[_SourceOrder] [nvarchar](50) NOT NULL,
	[_SourceOrderLine] [nvarchar](50) NOT NULL,
	[Lineage Key] [int] NOT NULL
) ON [PRIMARY]
GO

-- Add the foreign keys for the dimension tables
ALTER TABLE [dbo].[Fact_Sales]  WITH CHECK ADD  CONSTRAINT [FK_Fact_Sales_Dim_Customer] FOREIGN KEY([Customer Key])
REFERENCES [dbo].[Dim_Customer] ([Customer Key])
GO

ALTER TABLE [dbo].[Fact_Sales] CHECK CONSTRAINT [FK_Fact_Sales_Dim_Customer]
GO

ALTER TABLE [dbo].[Fact_Sales]  WITH CHECK ADD  CONSTRAINT [FK_Fact_Sales_Dim_Date] FOREIGN KEY([Delivery Date Key])
REFERENCES [dbo].[Dim_Date] ([Date Key])
GO

ALTER TABLE [dbo].[Fact_Sales] CHECK CONSTRAINT [FK_Fact_Sales_Dim_Date]
GO

ALTER TABLE [dbo].[Fact_Sales]  WITH CHECK ADD  CONSTRAINT [FK_Fact_Sales_Dim_Date1] FOREIGN KEY([Order Date Key])
REFERENCES [dbo].[Dim_Date] ([Date Key])
GO

ALTER TABLE [dbo].[Fact_Sales] CHECK CONSTRAINT [FK_Fact_Sales_Dim_Date1]
GO

ALTER TABLE [dbo].[Fact_Sales]  WITH CHECK ADD  CONSTRAINT [FK_Fact_Sales_Dim_Employee] FOREIGN KEY([Employee Key])
REFERENCES [dbo].[Dim_Employee] ([Employee Key])
GO

ALTER TABLE [dbo].[Fact_Sales] CHECK CONSTRAINT [FK_Fact_Sales_Dim_Employee]
GO

ALTER TABLE [dbo].[Fact_Sales]  WITH CHECK ADD  CONSTRAINT [FK_Fact_Sales_Dim_Location] FOREIGN KEY([Delivery Location Key])
REFERENCES [dbo].[Dim_Location] ([Location Key])
GO

ALTER TABLE [dbo].[Fact_Sales] CHECK CONSTRAINT [FK_Fact_Sales_Dim_Location]
GO

ALTER TABLE [dbo].[Fact_Sales]  WITH CHECK ADD  CONSTRAINT [FK_Fact_Sales_Dim_PaymentType] FOREIGN KEY([Payment Type Key])
REFERENCES [dbo].[Dim_PaymentType] ([Payment Type Key])
GO

ALTER TABLE [dbo].[Fact_Sales] CHECK CONSTRAINT [FK_Fact_Sales_Dim_PaymentType]
GO

ALTER TABLE [dbo].[Fact_Sales]  WITH CHECK ADD  CONSTRAINT [FK_Fact_Sales_Dim_Product] FOREIGN KEY([Product Key])
REFERENCES [dbo].[Dim_Product] ([Product Key])
GO

ALTER TABLE [dbo].[Fact_Sales] CHECK CONSTRAINT [FK_Fact_Sales_Dim_Product]
GO

ALTER TABLE [dbo].[Fact_Sales]  WITH CHECK ADD  CONSTRAINT [FK_Fact_Sales_Dim_Promotion] FOREIGN KEY([Promotion Key])
REFERENCES [dbo].[Dim_Promotion] ([Promotion Key])
GO

ALTER TABLE [dbo].[Fact_Sales] CHECK CONSTRAINT [FK_Fact_Sales_Dim_Promotion]
GO


