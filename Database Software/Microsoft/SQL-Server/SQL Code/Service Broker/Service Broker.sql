USE master;
GO

IF DB_ID('HelloWorld_SSB') IS NOT NULL
BEGIN
	ALTER DATABASE HelloWorld_SSB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE HelloWorld_SSB;
END
GO

CREATE DATABASE HelloWorld_SSB;
GO
ALTER DATABASE HelloWorld_SSB
	SET ENABLE_BROKER;
GO

USE HelloWorld_SSB;
GO

--Create message types
CREATE MESSAGE TYPE
	[HelloWorldMessage]
	VALIDATION = WELL_FORMED_XML;
CREATE MESSAGE TYPE
	[HelloBackMessage]
	VALIDATION = WELL_FORMED_XML;
GO

--View the message types just created
SELECT * 
FROM sys.service_message_types
WHERE message_type_id > 65535;
GO

--Create the contract
CREATE CONTRACT [HelloWorldContract]
	([HelloWorldMessage]
	SENT BY INITIATOR,
	[HelloBackMessage]
	SENT BY TARGET
	);
GO

--View the contract just created
SELECT * 
FROM sys.service_contracts
WHERE service_contract_id > 65535;
GO 

--Create target queue for storage
CREATE QUEUE HelloWorld_TargetQueue;
GO

--View the service queue just created
SELECT * 
FROM sys.service_queues
WHERE is_ms_shipped = 0;
GO

--Create target service
CREATE SERVICE
	[HelloWorld_TargetService]
	ON QUEUE HelloWorld_TargetQueue
	([HelloWorldContract]);
GO

--View the target service just created
SELECT * 
FROM sys.services 
WHERE service_id > 65535;
GO

--Create the initiator queue
CREATE QUEUE HelloWorld_InitiatorQueue;
GO

--View the queue
SELECT *
FROM sys.service_queues
WHERE is_ms_shipped = 0;
GO

--Create initiator Service
CREATE SERVICE
	[HelloWorld_InitiatorService]
	ON QUEUE HelloWorld_InitiatorQueue;
GO

--View the Service
SELECT * 
FROM sys.services 
WHERE service_id > 65535;
GO

-----Sending A Message-----
--Send a message
USE HelloWorld_SSB;
GO

--Begin a conversation and send a request message
DECLARE @conversation_handle UNIQUEIDENTIFIER;
DECLARE @message_body XML;

BEGIN TRANSACTION;

BEGIN DIALOG @conversation_handle
	FROM SERVICE[HelloWorld_InitiatorService]
	TO SERVICE N'HelloWorld_TargetService'
	ON CONTRACT [HelloWorldContract]
	WITH ENCRYPTION = OFF;

SELECT @message_body = N'<HelloWorldMessage>Hello World!</HelloWorldMessage>';

SEND ON CONVERSATION @conversation_handle
	MESSAGE TYPE [HelloWorldMessage]
(@message_body);

COMMIT TRANSACTION;
GO

--View the conversation just created
SELECT * 
FROM sys.conversation_groups;
GO

--View the message in the targets queue
SELECT *, 
	CAST(message_body AS XML) AS message_body_xml
FROM HelloWorld_TargetQueue;
GO

-----Processing A Message-----
USE HelloWorld_SSB;
GO

--Receive the request and send a reply
DECLARE @conversation_handle UNIQUEIDENTIFIER;
DECLARE @message_body XML;
DECLARE @message_type_name sysname;

BEGIN TRANSACTION;

WAITFOR
(RECEIVE TOP(1)
	@conversation_handle = conversation_handle,
	@message_body = message_body,
	@message_type_name = message_type_name
FROM HelloWorld_TargetQueue 
), TIMEOUT 1000;

SELECT @message_body AS ReceivedRequestMsg;

IF (@message_type_name = N'HelloWorldMessage')
BEGIN
	DECLARE @reply_message_body XML;
	SELECT @reply_message_body = N'<HelloBackMessage>Hello Back!</HelloBackMessage>';
	SEND ON CONVERSATION @conversation_handle
		MESSAGE TYPE [HelloBackMessage]
	(@reply_message_body);
END

SELECT @reply_message_body AS SentHelloBackMessage;

COMMIT TRANSACTION;
GO

--View the message in the targets queue
SELECT *, 
	CAST(message_body AS XML) AS message_body_xml
FROM HelloWorld_TargetQueue;
GO

--Check for the reply message in the initiator queue
SELECT *, 
	CAST(message_body AS XML) AS message_body_xml
FROM HelloWorld_InitiatorQueue;
GO

--Receive the reply and end the conversation
DECLARE @conversation_handle UNIQUEIDENTIFIER;
DECLARE @message_body XML;
DECLARE @message_type_name sysname;

BEGIN TRANSACTION;

WAITFOR
(RECEIVE TOP(1)
	@conversation_handle = conversation_handle,
	@message_body = message_body,
	@message_type_name = message_type_name
FROM HelloWorld_InitiatorQueue
), TIMEOUT 1000;

IF (@message_type_name = N'HelloBackMessage')
BEGIN
	END CONVERSATION @conversation_handle;
END

SELECT @message_body AS ReceivedHelloBackMessage;

COMMIT TRANSACTION;
GO

--View the message in the targets queue
SELECT *, 
	CAST(message_body AS XML) AS message_body_xml
FROM HelloWorld_TargetQueue;
GO

--Check for the reply message in the initiator queue
SELECT *, 
	CAST(message_body AS XML) AS message_body_xml
FROM HelloWorld_InitiatorQueue;
GO

--Clear the End Dialog message from the HelloWorld_TargetQueue
DECLARE @conversation_handle UNIQUEIDENTIFIER;
DECLARE @message_body XML;
DECLARE @message_type_name sysname;

BEGIN TRANSACTION;

WAITFOR
(RECEIVE TOP(1)
	@conversation_handle = conversation_handle,
	@message_body = message_body,
	@message_type_name = message_type_name
FROM HelloWorld_TargetQueue 
), TIMEOUT 1000;

SELECT @message_body AS ReceivedRequestMsg;

IF (@message_type_name = N'http://schemas.microsoft.com/SQL/ServiceBroker/EndDialog')
BEGIN
	END CONVERSATION @conversation_handle
END

COMMIT TRANSACTION;
GO

--Check that no more messages are in the targets queue
SELECT *, 
	CAST(message_body AS XML) AS message_body_xml
FROM HelloWorld_TargetQueue;
GO