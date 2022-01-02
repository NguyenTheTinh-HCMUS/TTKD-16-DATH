USE MASTER
GO
IF DB_ID ('UCA_NDS') IS NOT NULL DROP DATABASE [UCA_NDS]
GO
CREATE DATABASE [UCA_NDS]
GO
USE [UCA_NDS]
/****** Object:  Table [dbo].[Accidents_NDS]    Script Date: 10/21/2021 12:19:23 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
-- select Accident_Index, Time, RIGHT('00' + CAST(DATEPART(HOUR, Time) AS VARCHAR),2) from Accidents_NDS
CREATE TABLE [dbo].[Accidents_NDS](
	[Accident_Index] [int] IDENTITY(1,1) NOT NULL,
    [Accident_NK] varchar(50),
    [Accident_Severity] int,
    [Number_of_Vehicles] int,
    [Number_of_Casualties] int,
    [Date] datetime,
    [Day_of_Week] int,
    [Time] datetime,
    [Local_Authority_(District)] int,	--[Local_Authority_Id]
    [Road_Type] int,
    [Speed_limit] int,
    [Road_Surface_Conditions] int,
    [Special_Conditions_at_Site] int,
    [Carriageway_Hazards] int,
    [Urban_or_Rural_Area] int,
    [LSOA_of_Accident_Location] varchar(50),
	[CreatedDate] [datetime] NULL,
	[UpdatedDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Accident_Index] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[Local_Authority_NDS]    Script Date: 10/21/2021 12:19:23 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO  

CREATE TABLE [dbo].[Local_Authority_NDS](
	[Local_Authority_(District)_Id] [int] IDENTITY(1,1) NOT NULL,
    [Local_Authority_(District)] int,
--	[Local_Authority_(District_name)] nvarchar(255),
    [Local_Authority_(Highway)] varchar(50),
	[CreatedDate] [datetime] NULL,
	[UpdatedDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Local_Authority_(District)_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


/****** Object:  Table [dbo].[Vehicles_NDS]    Script Date: 10/21/2021 12:19:23 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [Vehicles_NDS] (
	[Vehicles_Id] [int] IDENTITY(1,1) NOT NULL,
    [Accident_Index] int,
	[Vehicle_Reference] int,
    [Vehicle_Type] int,
    [Journey_Purpose_of_Driver] int,
    [Age_of_Driver] int,
    [Age_of_Vehicle] int,
	[CreatedDate] [datetime] NULL,
	[UpdatedDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Vehicles_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[Casualties_NDS]    Script Date: 10/21/2021 12:19:23 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [Casualties_NDS] (
	[Casualties_Id] [int] IDENTITY(1,1) NOT NULL,
    [Accident_Index] int,
	[Vehicle_Reference] int,
    [Sex_of_Casualty] int,
    [Age_of_Casualty] int,
    [Casualty_Severity] int,
    [Casualty_Type] int,
	[CreatedDate] [datetime] NULL,
	[UpdatedDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Casualties_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[Age_of_Casualty_NDS]    Script Date: 10/21/2021 12:19:23 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [Age_of_Casualty_NDS] (
	[Age_of_Casualty_Id] [int] IDENTITY(1,1) NOT NULL,
    [Age_of_Casualty] int,
    [Age_Band_of_Casualty] int,
--  [Age_Band_Name] nvarchar(255),
	[CreatedDate] [datetime] NULL,
	[UpdatedDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Age_of_Casualty_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[Accident_location_NDS]    Script Date: 10/21/2021 12:19:23 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Accident_location_NDS] (
	[Accident_location_Id] [int] IDENTITY(1,1) NOT NULL,
	[Accident_Index] int,
	[city] varchar(50),
    [county] varchar(50),
    [country_name] varchar(50),
    [region_name] varchar(50),
	[CreatedDate] [datetime] NULL,
	[UpdatedDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Accident_location_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


ALTER TABLE [dbo].[Accidents_NDS]  WITH CHECK ADD  CONSTRAINT [FK_Accident_Local] FOREIGN KEY([Local_Authority_(District)])
REFERENCES [dbo].[Local_Authority_NDS] ([Local_Authority_(District)_Id])
GO
ALTER TABLE [dbo].[Accident_location_NDS]  WITH CHECK ADD  CONSTRAINT [FK_Accident_Location_Accident] FOREIGN KEY([Accident_Index])
REFERENCES [dbo].[Accidents_NDS] ([Accident_Index])
GO

ALTER TABLE [dbo].[Vehicles_NDS]  WITH CHECK ADD  CONSTRAINT [FK_Vehicles_Accident] FOREIGN KEY([Accident_Index])
REFERENCES [dbo].[Accidents_NDS] ([Accident_Index])
GO


ALTER TABLE [dbo].[Casualties_NDS]  WITH CHECK ADD  CONSTRAINT [FK_Casualties_Accident] FOREIGN KEY([Accident_Index])
REFERENCES [dbo].[Accidents_NDS] ([Accident_Index])
GO



ALTER TABLE [dbo].[Casualties_NDS]   WITH CHECK ADD  CONSTRAINT [FK_Casualties_Age_of_Casualty] FOREIGN KEY( [Age_of_Casualty])
REFERENCES [dbo].[Age_of_Casualty_NDS] ( [Age_of_Casualty_Id])
GO
