USE [taxi_trips_2023]
GO

/****** Object:  Table [dbo].[Taxi_Trip]    Script Date: 30/12/2023 19:17:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Taxi_Trip](
	[index] [bigint] NULL,
	[Trip_ID] [varchar](max) NULL,
	[Taxi_ID_New] [bigint] NULL,
	[Trip_Start_Timestamp] [datetime] NULL,
	[Trip_End_Timestamp] [datetime] NULL,
	[Trip_Seconds] [float] NULL,
	[Trip_Hours] [float] NULL,
	[Trip_Miles] [float] NULL,
	[Trip_Speed] [float] NULL,
	[Pickup_Community_Area] [float] NULL,
	[Pickup_in_Chicago] [int] NULL,
	[Dropoff_Community_Area] [float] NULL,
	[Dropoff_in_Chicago] [int] NULL,
	[Fare] [float] NULL,
	[Tips] [float] NULL,
	[Tolls] [float] NULL,
	[Extras] [float] NULL,
	[Trip_Total] [float] NULL,
	[Payment_Type] [varchar](max) NULL,
	[Company] [varchar](max) NULL,
	[customer_rate] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

