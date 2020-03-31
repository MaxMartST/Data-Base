USE [master]
GO

/****** Object:  Database [computer_configuration]    Script Date: 16.03.2020 21:18:57 ******/
CREATE DATABASE [computer_configuration]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'computer_configuration', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\computer_configuration.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'computer_configuration_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\computer_configuration_log.ldf' , SIZE = 2048KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO

ALTER DATABASE [computer_configuration] SET COMPATIBILITY_LEVEL = 120
GO

IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [computer_configuration].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO

ALTER DATABASE [computer_configuration] SET ANSI_NULL_DEFAULT OFF 
GO

ALTER DATABASE [computer_configuration] SET ANSI_NULLS OFF 
GO

ALTER DATABASE [computer_configuration] SET ANSI_PADDING OFF 
GO

ALTER DATABASE [computer_configuration] SET ANSI_WARNINGS OFF 
GO

ALTER DATABASE [computer_configuration] SET ARITHABORT OFF 
GO

ALTER DATABASE [computer_configuration] SET AUTO_CLOSE OFF 
GO

ALTER DATABASE [computer_configuration] SET AUTO_SHRINK OFF 
GO

ALTER DATABASE [computer_configuration] SET AUTO_UPDATE_STATISTICS ON 
GO

ALTER DATABASE [computer_configuration] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO

ALTER DATABASE [computer_configuration] SET CURSOR_DEFAULT  GLOBAL 
GO

ALTER DATABASE [computer_configuration] SET CONCAT_NULL_YIELDS_NULL OFF 
GO

ALTER DATABASE [computer_configuration] SET NUMERIC_ROUNDABORT OFF 
GO

ALTER DATABASE [computer_configuration] SET QUOTED_IDENTIFIER OFF 
GO

ALTER DATABASE [computer_configuration] SET RECURSIVE_TRIGGERS OFF 
GO

ALTER DATABASE [computer_configuration] SET  DISABLE_BROKER 
GO

ALTER DATABASE [computer_configuration] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO

ALTER DATABASE [computer_configuration] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO

ALTER DATABASE [computer_configuration] SET TRUSTWORTHY OFF 
GO

ALTER DATABASE [computer_configuration] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO

ALTER DATABASE [computer_configuration] SET PARAMETERIZATION SIMPLE 
GO

ALTER DATABASE [computer_configuration] SET READ_COMMITTED_SNAPSHOT OFF 
GO

ALTER DATABASE [computer_configuration] SET HONOR_BROKER_PRIORITY OFF 
GO

ALTER DATABASE [computer_configuration] SET RECOVERY SIMPLE 
GO

ALTER DATABASE [computer_configuration] SET  MULTI_USER 
GO

ALTER DATABASE [computer_configuration] SET PAGE_VERIFY CHECKSUM  
GO

ALTER DATABASE [computer_configuration] SET DB_CHAINING OFF 
GO

ALTER DATABASE [computer_configuration] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO

ALTER DATABASE [computer_configuration] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO

ALTER DATABASE [computer_configuration] SET DELAYED_DURABILITY = DISABLED 
GO

ALTER DATABASE [computer_configuration] SET  READ_WRITE 
GO


