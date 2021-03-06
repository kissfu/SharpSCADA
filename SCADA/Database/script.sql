USE [master]
GO
/****** Object:  Database [SCADA]    Script Date: 2017/9/29 17:18:52 ******/
CREATE DATABASE [SCADA]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'MYCOS_DATA', FILENAME = N'D:\MYCOS_DATA.mdf' , SIZE = 18432KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'MYCOS_DATA_log', FILENAME = N'D:\MYCOS_DATA_1.ldf' , SIZE = 43264KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [SCADA] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [SCADA].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [SCADA] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [SCADA] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [SCADA] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [SCADA] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [SCADA] SET ARITHABORT OFF 
GO
ALTER DATABASE [SCADA] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [SCADA] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [SCADA] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [SCADA] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [SCADA] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [SCADA] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [SCADA] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [SCADA] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [SCADA] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [SCADA] SET  DISABLE_BROKER 
GO
ALTER DATABASE [SCADA] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [SCADA] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [SCADA] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [SCADA] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [SCADA] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [SCADA] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [SCADA] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [SCADA] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [SCADA] SET  MULTI_USER 
GO
ALTER DATABASE [SCADA] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [SCADA] SET DB_CHAINING OFF 
GO
ALTER DATABASE [SCADA] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [SCADA] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [SCADA] SET DELAYED_DURABILITY = DISABLED 
GO
USE [SCADA]
GO
/****** Object:  User [xjtuzcj]    Script Date: 2017/9/29 17:18:52 ******/
CREATE USER [xjtuzcj] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [ad]    Script Date: 2017/9/29 17:18:52 ******/
CREATE USER [ad] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [ad]
GO
/****** Object:  Table [dbo].[Dictionary]    Script Date: 2017/9/29 17:18:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Dictionary](
	[DictType] [varchar](50) NOT NULL,
	[Code] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](50) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Log_Alarm]    Script Date: 2017/9/29 17:18:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Log_Alarm](
	[StartTime] [datetime] NULL,
	[Source] [nvarchar](50) NULL,
	[ConditionID] [int] NULL,
	[AlarmText] [nvarchar](128) NULL,
	[AlarmValue] [sql_variant] NULL,
	[Duration] [int] NULL,
	[Severity] [int] NULL,
	[SubAlarmType] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Log_Event]    Script Date: 2017/9/29 17:18:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Log_Event](
	[EventType] [int] NULL,
	[Severity] [int] NULL,
	[IsAcked] [bit] NULL CONSTRAINT [DF_Log_Event_IsAcked]  DEFAULT ((0)),
	[ActiveTime] [datetime] NULL,
	[Source] [nvarchar](50) NULL,
	[Comment] [nvarchar](50) NULL,
	[SQLCounter] [int] IDENTITY(1,1) NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Log_HData]    Script Date: 2017/9/29 17:18:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Log_HData](
	[ID] [smallint] NOT NULL,
	[TimeStamp] [datetime] NOT NULL,
	[Value] [real] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Membership]    Script Date: 2017/9/29 17:18:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Membership](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [nvarchar](50) NOT NULL,
	[Password] [nvarchar](50) NOT NULL,
	[Role] [smallint] NOT NULL CONSTRAINT [DF_Membership_Role]  DEFAULT ((0)),
	[Email] [varchar](50) NULL,
	[Phone] [varchar](50) NULL,
 CONSTRAINT [PK_Membership] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Meta_Condition]    Script Date: 2017/9/29 17:18:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Meta_Condition](
	[TypeID] [int] IDENTITY(1,1) NOT NULL,
	[Source] [nvarchar](50) NOT NULL,
	[AlarmType] [int] NOT NULL,
	[EventType] [tinyint] NOT NULL,
	[ConditionType] [tinyint] NOT NULL,
	[Para] [real] NOT NULL,
	[IsEnabled] [bit] NOT NULL,
	[DeadBand] [real] NOT NULL,
	[Delay] [int] NOT NULL,
	[Comment] [nvarchar](50) NULL,
 CONSTRAINT [PK_Meta_Condition] PRIMARY KEY CLUSTERED 
(
	[TypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Meta_Driver]    Script Date: 2017/9/29 17:18:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Meta_Driver](
	[DriverID] [smallint] NOT NULL,
	[DriverType] [int] NOT NULL,
	[DriverName] [nvarchar](64) NOT NULL CONSTRAINT [DF_Meta_Device_DeviceName]  DEFAULT (''),
	[TimeOut] [int] NOT NULL CONSTRAINT [DF_Meta_Device_TimeOut]  DEFAULT ((0)),
	[Server] [varchar](128) NULL,
	[Spare1] [nvarchar](50) NULL,
	[Spare2] [nvarchar](50) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Meta_Group]    Script Date: 2017/9/29 17:18:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Meta_Group](
	[GroupID] [smallint] NOT NULL,
	[DriverID] [smallint] NULL,
	[GroupName] [nvarchar](20) NULL,
	[UpdateRate] [int] NULL,
	[DeadBand] [real] NULL,
	[IsActive] [bit] NOT NULL CONSTRAINT [DF_M_Group_IsActive]  DEFAULT ((1))
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Meta_Scale]    Script Date: 2017/9/29 17:18:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Meta_Scale](
	[ScaleID] [smallint] NOT NULL,
	[ScaleType] [tinyint] NOT NULL,
	[EUHi] [real] NULL,
	[EULo] [real] NULL,
	[RawHi] [real] NULL,
	[RawLo] [real] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Meta_SubCondition]    Script Date: 2017/9/29 17:18:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Meta_SubCondition](
	[ConditionID] [int] NOT NULL,
	[SubAlarmType] [int] NOT NULL,
	[Threshold] [real] NOT NULL,
	[Severity] [tinyint] NOT NULL,
	[Message] [nvarchar](250) NULL,
	[IsEnable] [bit] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Meta_Tag]    Script Date: 2017/9/29 17:18:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Meta_Tag](
	[TagID] [smallint] IDENTITY(1,1) NOT NULL,
	[TagName] [nvarchar](512) NOT NULL,
	[DataType] [tinyint] NOT NULL,
	[DataSize] [smallint] NOT NULL CONSTRAINT [DF_TagMetaData_DataSize]  DEFAULT ((0)),
	[Address] [varchar](64) NOT NULL,
	[GroupID] [smallint] NOT NULL CONSTRAINT [DF_TagMetaData_GroupID]  DEFAULT ((0)),
	[IsActive] [bit] NOT NULL CONSTRAINT [DF_TagMetaData_IsActived]  DEFAULT ((1)),
	[Archive] [bit] NOT NULL CONSTRAINT [DF_Meta_Tag_HasHDA]  DEFAULT ((0)),
	[DefaultValue] [sql_variant] NULL,
	[Description] [nvarchar](128) NULL,
	[Maximum] [real] NOT NULL CONSTRAINT [DF_Meta_Tag_Maximum]  DEFAULT ((0)),
	[Minimum] [real] NOT NULL CONSTRAINT [DF_Meta_Tag_Minimum]  DEFAULT ((0)),
	[Cycle] [int] NOT NULL CONSTRAINT [DF_Meta_Tag_Cycle]  DEFAULT ((0)),
	[RowVersion] [timestamp] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[RegisterModule]    Script Date: 2017/9/29 17:18:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RegisterModule](
	[DriverID] [int] IDENTITY(1,1) NOT NULL,
	[AssemblyName] [nvarchar](255) NULL,
	[ClassName] [varchar](50) NULL,
	[ClassFullName] [varchar](128) NULL,
	[Description] [nvarchar](50) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Meta_Condition] ADD  CONSTRAINT [DF_ALARMSET_AlarmType]  DEFAULT ((0)) FOR [AlarmType]
GO
ALTER TABLE [dbo].[Meta_Condition] ADD  CONSTRAINT [DF_ALARMSET_EventType]  DEFAULT ((0)) FOR [EventType]
GO
ALTER TABLE [dbo].[Meta_Condition] ADD  CONSTRAINT [DF_ALARMSET_ConditionType]  DEFAULT ((0)) FOR [ConditionType]
GO
ALTER TABLE [dbo].[Meta_Condition] ADD  CONSTRAINT [DF_ALARM_Set_Para]  DEFAULT ((0)) FOR [Para]
GO
ALTER TABLE [dbo].[Meta_Condition] ADD  CONSTRAINT [DF_ALARMSET_IsEnabled]  DEFAULT ((1)) FOR [IsEnabled]
GO
ALTER TABLE [dbo].[Meta_Condition] ADD  CONSTRAINT [DF_ALARMSET_DeadBand]  DEFAULT ((0)) FOR [DeadBand]
GO
ALTER TABLE [dbo].[Meta_Condition] ADD  CONSTRAINT [DF_ALARMSET_Delay]  DEFAULT ((0)) FOR [Delay]
GO
ALTER TABLE [dbo].[Meta_SubCondition] ADD  CONSTRAINT [DF_SubCondition_Set_SubAlarmType]  DEFAULT ((0)) FOR [SubAlarmType]
GO
ALTER TABLE [dbo].[Meta_SubCondition] ADD  CONSTRAINT [DF_SubCondition_Set_Threshold]  DEFAULT ((0)) FOR [Threshold]
GO
ALTER TABLE [dbo].[Meta_SubCondition] ADD  CONSTRAINT [DF_SubCondition_Set_Severity]  DEFAULT ((0)) FOR [Severity]
GO
ALTER TABLE [dbo].[Meta_SubCondition] ADD  CONSTRAINT [DF_SubCondition_Set_Message]  DEFAULT ('') FOR [Message]
GO
ALTER TABLE [dbo].[Meta_SubCondition] ADD  CONSTRAINT [DF_SubCondition_Set_IsEnable]  DEFAULT ((1)) FOR [IsEnable]
GO
ALTER TABLE [dbo].[Meta_SubCondition]  WITH NOCHECK ADD  CONSTRAINT [FK_Meta_SubCondition_Meta_Condition] FOREIGN KEY([ConditionID])
REFERENCES [dbo].[Meta_Condition] ([TypeID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Meta_SubCondition] CHECK CONSTRAINT [FK_Meta_SubCondition_Meta_Condition]
GO
/****** Object:  StoredProcedure [dbo].[AddEventLog]    Script Date: 2017/9/29 17:18:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[AddEventLog] 
@StartTime DATETIME ,
@Source NVARCHAR(50),
@Comment NVARCHAR(50) as
--set nocount on 
IF @Comment<>ISNULL((SELECT TOP 1 Comment FROM dbo.LOG_EVENT WHERE EVENTTYPE=2 AND Source=@Source ORDER BY SQLCOUNTER DESC),'')
INSERT INTO dbo.LOG_EVENT(EVENTTYPE,SEVERITY,ACTIVETIME,SOURCE,COMMENT) VALUES(2,0,@StartTime,@Source,@Comment);




GO
/****** Object:  StoredProcedure [dbo].[GetAlarm]    Script Date: 2017/9/29 17:18:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[GetAlarm] 
@StartTime DATETIME ,
@EndTime DATETIME 
AS
--set nocount on 
SELECT StartTime,AlarmText,AlarmValue,SubAlarmType,Severity,ConditionID,Source,Duration FROM LOG_ALARM WHERE StartTime BETWEEN @StartTime AND @EndTime ORDER BY StartTime




GO
/****** Object:  StoredProcedure [dbo].[GetEventTime]    Script Date: 2017/9/29 17:18:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[GetEventTime] 
@EVENTTYPE int ,
@SOURCE nvarchar(50),
@COMMENT nvarchar(50),
@STARTTIME DATETIME OUTPUT,
@ENDTIME DATETIME OUTPUT as
--set nocount on 
DECLARE @ID INT;
SELECT TOP 1 @ID=SQLCOUNTER,@STARTTIME=ACTIVETIME FROM  dbo.LOG_EVENT WHERE EVENTTYPE=@EVENTTYPE AND SOURCE=@SOURCE AND COMMENT=@COMMENT
 ORDER BY ACTIVETIME DESC;
SET @ENDTIME=(SELECT TOP 1 ACTIVETIME FROM  dbo.LOG_EVENT WHERE EVENTTYPE=@EVENTTYPE AND SOURCE=@SOURCE 
AND SQLCOUNTER>@ID ORDER BY SQLCOUNTER);



GO
/****** Object:  StoredProcedure [dbo].[InitServer]    Script Date: 2017/9/29 17:18:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[InitServer]
@TYPE INT --0:服务端；1：客户端；2：控制器端。  
AS
IF @TYPE<>1 SELECT M.DRIVERID,DRIVERNAME,[SERVER],TIMEOUT,R.AssemblyName,R.ClassFullName,Spare1,Spare2 
FROM META_DRIVER M INNER JOIN dbo.RegisterModule R ON M.DRIVERTYPE=R.DriverID;
SELECT COUNT(*) FROM META_TAG;
SELECT TAGID,GROUPID,RTRIM(TAGNAME),[ADDRESS],DATATYPE,DATASIZE,ARCHIVE,MAXIMUM,MINIMUM,CYCLE FROM META_TAG WHERE ISACTIVE=1;
IF @TYPE<>1 SELECT DRIVERID,GROUPNAME,GROUPID,UPDATERATE,DEADBAND,ISACTIVE FROM META_GROUP ;
IF @TYPE=0 SELECT SOURCE FROM META_Condition WHERE EVENTTYPE=2;
IF @TYPE<>2 SELECT TYPEID,SOURCE,ALARMTYPE,A.ISENABLED,CONDITIONTYPE,PARA,ISNULL(COMMENT,''),DEADBAND,DELAY,SUBALARMTYPE,Threshold,SEVERITY,
ISNULL([MESSAGE],''),B.ISENABLE FROM META_Condition a LEFT OUTER JOIN META_SUBCONDITION b ON a.TypeID=b.ConditionID WHERE EVENTTYPE<>2;
-- LEFT OUTER JOIN META_TAG c ON a.SOURCEID=c.TAGID 
SELECT SCALEID,SCALETYPE,EUHI,EULO,RAWHI,RAWLO FROM META_SCALE;













GO
/****** Object:  StoredProcedure [dbo].[ReadALL]    Script Date: 2017/9/29 17:18:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ReadALL] 
@GroupID SMALLINT
AS
SELECT COUNT(*) FROM  META_TAG WHERE GROUPID=@GroupID AND IsActive=1;
SELECT TAGID,DATATYPE,ISNULL(DEFAULTVALUE,0) FROM META_TAG WHERE IsActive=1 AND GROUPID=@GroupID ORDER BY TAGID



GO
/****** Object:  StoredProcedure [dbo].[ReadHData]    Script Date: 2017/9/29 17:18:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[ReadHData] 
@StartTime DATETIME ,
@EndTime DATETIME,
@ID INT as
--set nocount on 
IF @ID IS NULL
SELECT ID,[TIMESTAMP],[VALUE],M.DATATYPE FROM LOG_HDATA L INNER JOIN META_TAG M ON L.ID=M.TAGID WHERE [TIMESTAMP] BETWEEN @StartTime AND @EndTime ORDER BY ID,[TIMESTAMP];
ELSE 
SELECT [TIMESTAMP],[VALUE],M.DATATYPE FROM LOG_HDATA L INNER JOIN META_TAG M ON L.ID=M.TAGID WHERE ID=@ID AND [TIMESTAMP] BETWEEN @StartTime AND @EndTime  ORDER BY [TIMESTAMP];
--select ID,[TIMESTAMP],[VALUE] from HDADATA WHERE [TIMESTAMP] BETWEEN @StartTime AND @EndTime order by [TIMESTAMP]





GO
/****** Object:  StoredProcedure [dbo].[ReadValueByID]    Script Date: 2017/9/29 17:18:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ReadValueByID] 
@ID SMALLINT,
@DATATYPE TinyInt
AS
IF @DATATYPE=1 
SELECT CAST(DEFAULTVALUE AS BIT) FROM META_TAG WHERE TAGID=@ID
ELSE IF @DATATYPE=3
SELECT CAST(DEFAULTVALUE AS TINYINT) FROM META_TAG WHERE TAGID=@ID
ELSE IF @DATATYPE=4
SELECT CAST(DEFAULTVALUE AS SMALLINT) FROM META_TAG WHERE TAGID=@ID
ELSE IF @DATATYPE=7
SELECT CAST(DEFAULTVALUE AS INT) FROM META_TAG WHERE TAGID=@ID
ELSE IF @DATATYPE=8
SELECT CAST(DEFAULTVALUE AS REAL) FROM META_TAG WHERE TAGID=@ID
ELSE IF @DATATYPE=11
SELECT CAST(DEFAULTVALUE AS VARCHAR) FROM META_TAG WHERE TAGID=@ID




GO
/****** Object:  StoredProcedure [dbo].[UpdateValueByID]    Script Date: 2017/9/29 17:18:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[UpdateValueByID] 
@ID INT,
@Value Sql_Variant
AS
UPDATE META_TAG SET DEFAULTVALUE=@Value WHERE TAGID=@ID



GO
/****** Object:  StoredProcedure [dbo].[WriteHData]    Script Date: 2017/9/29 17:18:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[WriteHData] 
@DATE DATETIME
AS
DELETE FROM LOG_HDATA FROM LOG_HDATA L INNER JOIN META_TAG T ON T.TAGID=L.ID WHERE T.DATATYPE=11
SELECT COUNT(*),COUNT(DISTINCT ID) FROM LOG_HDATA WHERE DATEDIFF(DAY,@DATE,[TIMESTAMP])=0;
SELECT H.ID,T.DATATYPE,C FROM( SELECT ID,COUNT(*)C FROM LOG_HDATA WHERE DATEDIFF(DAY,@DATE,[TIMESTAMP])=0 GROUP BY ID)H INNER JOIN META_TAG T ON H.ID=T.TAGID ORDER BY ID --WITH ROLLUP
SELECT [TIMESTAMP],VALUE FROM LOG_HDATA WHERE DATEDIFF(DAY,@DATE,[TIMESTAMP])=0 ORDER BY ID,[TIMESTAMP]
--DELETE FROM LOG_HDATA WHERE DATEDIFF(DAY,@DATE,[TIMESTAMP])=0;






GO
USE [master]
GO
ALTER DATABASE [SCADA] SET  READ_WRITE 
GO
