--<ScriptOptions statementTerminator=";"/>

--    This DDL creates the RAILS IBM DB2 database 
--    Copyright (C) 2017  David J Bristow

--    This program is free software: you can redistribute it and/or modify
--    it under the terms of the GNU General Public License as published by
--    the Free Software Foundation, either version 3 of the License, or
--    (at your option) any later version.

--    This program is distributed in the hope that it will be useful,
--    but WITHOUT ANY WARRANTY; without even the implied warranty of
--    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--    GNU General Public License for more details.

--    You should have received a copy of the GNU General Public License
--    along with this program.  If not, see <http://www.gnu.org/licenses/>.

CREATE SCHEMA "RAILS";

CREATE SEQUENCE "RAILS"."COMPANY_SEQ" AS INTEGER  START WITH 100 INCREMENT BY 50 MINVALUE 1 MAXVALUE 2147483647 NO CYCLE NO CACHE NO ORDER;

CREATE SEQUENCE "RAILS"."DCC_SEQ" AS INTEGER  START WITH 100 INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 NO CYCLE CACHE 20 NO ORDER;

CREATE SEQUENCE "RAILS"."IMAGE_SEQ" AS INTEGER  START WITH 100 INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 NO CYCLE CACHE 20 NO ORDER;

CREATE SEQUENCE "RAILS"."MQTT_MSG_SEQ" AS INTEGER  START WITH 100 INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 NO CYCLE NO CACHE NO ORDER;

CREATE SEQUENCE "RAILS"."PROJECT_ITEM_SEQ" AS INTEGER  START WITH 100 INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 NO CYCLE NO CACHE NO ORDER;

CREATE SEQUENCE "RAILS"."PROJECT_SEQ" AS INTEGER  START WITH 100 INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 NO CYCLE NO CACHE NO ORDER;

CREATE SEQUENCE "RAILS"."PURCHASEDITEM_SEQ" AS INTEGER  START WITH 100 INCREMENT BY 50 MINVALUE 1 MAXVALUE 2147483647 NO CYCLE NO CACHE NO ORDER;

CREATE SEQUENCE "RAILS"."PURCHASE_SEQ" AS INTEGER  START WITH 100 INCREMENT BY 50 MINVALUE 1 MAXVALUE 2147483647 NO CYCLE NO CACHE NO ORDER;

CREATE SEQUENCE "RAILS"."ROLLINGSTOCK_SEQ" AS INTEGER  START WITH 100 INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 NO CYCLE CACHE 20 NO ORDER;

CREATE SEQUENCE "RAILS"."TURNOUT_SEQ" AS INTEGER  START WITH 100 INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 NO CYCLE NO CACHE NO ORDER;

CREATE TABLE "RAILS"."AAR" (
		"AAR_CODE" CHAR(5 OCTETS) NOT NULL, 
		"DEFINITION" VARCHAR(2048 OCTETS)
	)
	ORGANIZE BY ROW
	DATA CAPTURE NONE 
	IN "USERSPACE1"
	COMPRESS NO;

CREATE TABLE "RAILS"."COMPANY" (
		"CO_ID" INTEGER NOT NULL, 
		"CO_TYPE" CHAR(1 OCTETS), 
		"CO_NAME" VARCHAR(50 OCTETS), 
		"CO_DESCRIPTION" VARCHAR(1000 OCTETS), 
		"URL" VARCHAR(100 OCTETS), 
		"PHONE" VARCHAR(15 OCTETS), 
		"STREET" VARCHAR(50 OCTETS), 
		"CITY" VARCHAR(25 OCTETS), 
		"STATE" CHAR(2 OCTETS), 
		"ZIP" VARCHAR(10 OCTETS), 
		"COUNTRY" VARCHAR(20 OCTETS)
	)
	ORGANIZE BY ROW
	DATA CAPTURE NONE 
	IN "USERSPACE1"
	COMPRESS NO;

CREATE TABLE "RAILS"."DCC_ATTRIBUTE" (
		"DCC_ATTR_ID" INTEGER NOT NULL, 
		"ATTR_NAME" CHAR(5 OCTETS), 
		"ATTR_VALUE" CHAR(5 OCTETS), 
		"RS_ID" INTEGER
	)
	ORGANIZE BY ROW
	DATA CAPTURE NONE 
	IN "USERSPACE1"
	COMPRESS NO;

CREATE TABLE "RAILS"."IMAGES" (
		"IMAGE_ID" INTEGER NOT NULL, 
		"TITLE" VARCHAR(25 OCTETS), 
		"PIC" BLOB(4096) INLINE LENGTH 92
	)
	ORGANIZE BY ROW
	DATA CAPTURE NONE 
	IN "USERSPACE1"
	COMPRESS NO;

CREATE TABLE "RAILS"."INDUSTRY" (
		"SHORT_NAME" VARCHAR(10 OCTETS) NOT NULL, 
		"FULL_NAME" VARCHAR(50 OCTETS), 
		"IND_TYPE" VARCHAR(10 OCTETS) NOT NULL, 
		"FUNCTION" VARCHAR(250 OCTETS), 
		"PRODUCT" VARCHAR(25 OCTETS), 
		"RAW_MATERIAL" VARCHAR(25 OCTETS), 
		"PRODUCTION_RATE" DOUBLE, 
		"PRODUCTION_UNIT" CHAR(5 OCTETS), 
		"CONSUMPTION_RATE" DOUBLE, 
		"CONSUMPTION_UNIT" CHAR(5 OCTETS)
	)
	ORGANIZE BY ROW
	DATA CAPTURE NONE 
	IN "USERSPACE1"
	COMPRESS NO;

CREATE TABLE "RAILS"."MQTT_MSG" (
		"MSG_ID" INTEGER NOT NULL, 
		"TOPIC" VARCHAR(25 OCTETS), 
		"CONTENT" VARCHAR(50 OCTETS), 
		"ACTION" CHAR(1 OCTETS), 
		"HANDLED_TIME" TIMESTAMP, 
		"ACTION_TIME" TIMESTAMP
	)
	ORGANIZE BY ROW
	DATA CAPTURE NONE 
	IN "USERSPACE1"
	COMPRESS NO;

CREATE TABLE "RAILS"."PROJECT" (
		"PRJT_ID" INTEGER NOT NULL, 
		"PRJT_TITLE" VARCHAR(50 OCTETS), 
		"PRJT_TYPE" VARCHAR(15 OCTETS), 
		"PRJT_DESCRIPTION" VARCHAR(1000 OCTETS), 
		"START_DATE" DATE, 
		"COMPLETED_DATE" DATE, 
		"PRJT_NOTES" VARCHAR(2000 OCTETS), 
		"PRIORITY" VARCHAR(15 OCTETS)
	)
	ORGANIZE BY ROW
	DATA CAPTURE NONE 
	IN "USERSPACE1"
	COMPRESS NO;

CREATE TABLE "RAILS"."PROJECT_ITEM" (
		"PRJT_ITEM_ID" INTEGER NOT NULL, 
		"ITEM_ID" INTEGER NOT NULL, 
		"PRJT_ID" INTEGER NOT NULL, 
		"QUANTITY" INTEGER NOT NULL, 
		"RS_ID" INTEGER NOT NULL
	)
	ORGANIZE BY ROW
	DATA CAPTURE NONE 
	IN "USERSPACE1"
	COMPRESS NO;

CREATE TABLE "RAILS"."PURCHASE" (
		"PURCHASE_ID" INTEGER NOT NULL, 
		"PURCHASE_DATE" DATE, 
		"VENDOR_ID" INTEGER NOT NULL
	)
	ORGANIZE BY ROW
	DATA CAPTURE NONE 
	IN "USERSPACE1"
	COMPRESS NO;

CREATE TABLE "RAILS"."PURCHASEDITEM" (
		"ITEM_ID" INTEGER NOT NULL, 
		"PURCHASE_ID" INTEGER NOT NULL, 
		"PART_NUMBER" VARCHAR(20 OCTETS) NOT NULL, 
		"DESCRIPTION" VARCHAR(50 OCTETS), 
		"ITEM_QTY" INTEGER, 
		"ITEM_COST" DECFLOAT(16), 
		"UNIT_QTY" INTEGER DEFAULT 1, 
		"NOTES" VARCHAR(200 OCTETS), 
		"MANUFACTURE_ID" INTEGER NOT NULL, 
		"CONSUMED" CHAR(1 OCTETS)
	)
	ORGANIZE BY ROW
	DATA CAPTURE NONE 
	IN "USERSPACE1"
	COMPRESS NO;

CREATE TABLE "RAILS"."ROLLINGSTOCK" (
		"RS_ID" INTEGER NOT NULL, 
		"RS_TYPE_ID" VARCHAR(15 OCTETS) NOT NULL, 
		"IMAGE_ID" INTEGER, 
		"AAR_CODE" CHAR(5 OCTETS), 
		"BUILT_BY" VARCHAR(10 OCTETS), 
		"ROAD_NAME" VARCHAR(10 OCTETS), 
		"RS_NUMBER" VARCHAR(10 OCTETS) NOT NULL, 
		"RFID" VARCHAR(10 OCTETS), 
		"AVAILABILITY" CHAR(1 OCTETS), 
		"LOCATION_ID" VARCHAR(10 OCTETS), 
		"LENGTH" DECIMAL(10 , 1), 
		"CAPACITY" DECIMAL(10 , 1), 
		"CAP_UNITS" CHAR(5 OCTETS), 
		"MODEL_WEIGHT" DECIMAL(10 , 2), 
		"LT_WEIGHT" INTEGER, 
		"LD_MAX_WEIGHT" INTEGER, 
		"BUILT_DATE" DATE, 
		"IN_SERVICE" DATE, 
		"HEIGHT" DECIMAL(10 , 1), 
		"NOTES" VARCHAR(500 OCTETS), 
		"LAST_MAINTENANCE" DATE, 
		"LAST_UPDATE" TIMESTAMP
	)
	ORGANIZE BY ROW
	DATA CAPTURE NONE 
	IN "USERSPACE1"
	COMPRESS NO;

CREATE TABLE "RAILS"."RS_TYPE" (
		"RS_TYPE" VARCHAR(15 OCTETS) NOT NULL, 
		"CATEGORY" VARCHAR(15 OCTETS) NOT NULL, 
		"DESCRIPTION" VARCHAR(500 OCTETS)
	)
	ORGANIZE BY ROW
	DATA CAPTURE NONE 
	IN "USERSPACE1"
	COMPRESS NO;

CREATE TABLE "RAILS"."TURNOUT" (
		"TURNOUT_ID" INTEGER NOT NULL, 
		"NAME" VARCHAR(50 OCTETS), 
		"TURNOUT_TYPE" VARCHAR(10 OCTETS), 
		"LOCATION" VARCHAR(50 OCTETS), 
		"CNTRLR" VARCHAR(10 OCTETS), 
		"COMMANDED_STATE" VARCHAR(10 OCTETS), 
		"THROWN_SPEED" INTEGER, 
		"CLOSED_SPEED" INTEGER, 
		"KNOWN_STATE" VARCHAR(10 OCTETS), 
		"IS_INVERTED" CHAR(1 OCTETS), 
		"IS_LOCKED" CHAR(1 OCTETS), 
		"LOCKED_MODE" VARCHAR(15 OCTETS), 
		"LOCKED_BY" CHAR(5 OCTETS), 
		"LAST_UPDT" TIMESTAMP
	)
	ORGANIZE BY ROW
	DATA CAPTURE NONE 
	IN "USERSPACE1"
	COMPRESS NO;

ALTER TABLE "RAILS"."AAR" ADD CONSTRAINT "AAR_PK" PRIMARY KEY
	("AAR_CODE");

ALTER TABLE "RAILS"."COMPANY" ADD CONSTRAINT "COMPANY_PK" PRIMARY KEY
	("CO_ID");

ALTER TABLE "RAILS"."DCC_ATTRIBUTE" ADD CONSTRAINT "DCC_ATTRIBUTE_PK" PRIMARY KEY
	("DCC_ATTR_ID");

ALTER TABLE "RAILS"."IMAGES" ADD CONSTRAINT "IMAGES_PK" PRIMARY KEY
	("IMAGE_ID");

ALTER TABLE "RAILS"."INDUSTRY" ADD CONSTRAINT "INDUSTRY_PK" PRIMARY KEY
	("SHORT_NAME");

ALTER TABLE "RAILS"."MQTT_MSG" ADD CONSTRAINT "MQTT_MSG_PK" PRIMARY KEY
	("MSG_ID");

ALTER TABLE "RAILS"."PROJECT" ADD CONSTRAINT "PROJECT_PK" PRIMARY KEY
	("PRJT_ID");

ALTER TABLE "RAILS"."PROJECT_ITEM" ADD CONSTRAINT "PART_PK" PRIMARY KEY
	("PRJT_ITEM_ID");

ALTER TABLE "RAILS"."PURCHASE" ADD CONSTRAINT "PURCHASE_PK" PRIMARY KEY
	("PURCHASE_ID");

ALTER TABLE "RAILS"."PURCHASEDITEM" ADD CONSTRAINT "PURCHASEDITEM_PK" PRIMARY KEY
	("ITEM_ID");

ALTER TABLE "RAILS"."ROLLINGSTOCK" ADD CONSTRAINT "ROLLINGSTOCK_PK" PRIMARY KEY
	("RS_ID");

ALTER TABLE "RAILS"."RS_TYPE" ADD CONSTRAINT "RS_TYPE_PK" PRIMARY KEY
	("RS_TYPE");

ALTER TABLE "RAILS"."TURNOUT" ADD CONSTRAINT "TURNOUT_PK" PRIMARY KEY
	("TURNOUT_ID");

ALTER TABLE "RAILS"."PROJECT_ITEM" ADD CONSTRAINT "PART_PURCHASEDITEM_FK" FOREIGN KEY
	("ITEM_ID")
	REFERENCES "RAILS"."PURCHASEDITEM"
	("ITEM_ID");

ALTER TABLE "RAILS"."PROJECT_ITEM" ADD CONSTRAINT "PROJECT_ITEM_PROJECT_FK" FOREIGN KEY
	("PRJT_ID")
	REFERENCES "RAILS"."PROJECT"
	("PRJT_ID")
	ON DELETE CASCADE;

ALTER TABLE "RAILS"."PURCHASE" ADD CONSTRAINT "PURCHASE_COMPANY_FK" FOREIGN KEY
	("VENDOR_ID")
	REFERENCES "RAILS"."COMPANY"
	("CO_ID")
	ON DELETE CASCADE;

ALTER TABLE "RAILS"."PURCHASEDITEM" ADD CONSTRAINT "PURCHASEDITEM_COMPANY_FK" FOREIGN KEY
	("MANUFACTURE_ID")
	REFERENCES "RAILS"."COMPANY"
	("CO_ID")
	ON DELETE CASCADE
	NOT ENFORCED;

ALTER TABLE "RAILS"."PURCHASEDITEM" ADD CONSTRAINT "PURCHASEDITEM_PURCHASE_FK" FOREIGN KEY
	("PURCHASE_ID")
	REFERENCES "RAILS"."PURCHASE"
	("PURCHASE_ID")
	ON DELETE CASCADE;

ALTER TABLE "RAILS"."ROLLINGSTOCK" ADD CONSTRAINT "ROLLINGSTOCK_AAR_FK" FOREIGN KEY
	("AAR_CODE")
	REFERENCES "RAILS"."AAR"
	("AAR_CODE")
	ON DELETE CASCADE;

ALTER TABLE "RAILS"."ROLLINGSTOCK" ADD CONSTRAINT "ROLLINGSTOCK_COMPANY_FK" FOREIGN KEY
	("ROAD_NAME")
	REFERENCES "RAILS"."INDUSTRY"
	("SHORT_NAME");

ALTER TABLE "RAILS"."ROLLINGSTOCK" ADD CONSTRAINT "ROLLINGSTOCK_INDUSTRY_FK" FOREIGN KEY
	("BUILT_BY")
	REFERENCES "RAILS"."INDUSTRY"
	("SHORT_NAME")
	ON DELETE CASCADE;

ALTER TABLE "RAILS"."ROLLINGSTOCK" ADD CONSTRAINT "ROLLINGSTOCK_RS_TYPE_FK" FOREIGN KEY
	("RS_TYPE_ID")
	REFERENCES "RAILS"."RS_TYPE"
	("RS_TYPE")
	ON DELETE CASCADE;

CREATE TRIGGER "RAILS"."MQTT_MSG_INSRT" 
	BEFORE INSERT ON "RAILS"."MQTT_MSG"
	REFERENCING  NEW AS n
	FOR EACH ROW
	NOT SECURED
SET ACTION_TIME = CURRENT TIMESTAMP;

CREATE TRIGGER "RAILS"."ROLLINGSTOCK_INSRT" 
	BEFORE INSERT ON "RAILS"."ROLLINGSTOCK"
	REFERENCING  NEW AS n
	FOR EACH ROW
	NOT SECURED
SET LAST_UPDATE = CURRENT TIMESTAMP;

CREATE TRIGGER "RAILS"."ROLLINGSTOCK_UPDT" 
	BEFORE UPDATE ON "RAILS"."ROLLINGSTOCK"
	REFERENCING  NEW AS n
	FOR EACH ROW
	NOT SECURED
SET LAST_UPDATE = CURRENT TIMESTAMP;

CREATE TRIGGER "RAILS"."TURNOUT_INSRT" 
	BEFORE INSERT ON "RAILS"."TURNOUT"
	REFERENCING  NEW AS n
	FOR EACH ROW
	NOT SECURED
SET LAST_UPDT = CURRENT TIMESTAMP;

CREATE TRIGGER "RAILS"."TURNOUT_UPDT" 
	BEFORE UPDATE ON "RAILS"."TURNOUT"
	REFERENCING  NEW AS n
	FOR EACH ROW
	NOT SECURED
SET LAST_UPDT = CURRENT TIMESTAMP;
