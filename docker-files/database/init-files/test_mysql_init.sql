-- 作成
CREATE DATABASE auction;
\c auction

-- テストデータ生成
CREATE TABLE "auctions" (
	"auction_id" UUID NOT NULL UNIQUE,
	"created_at" TIMESTAMP NOT NULL,
	"updated_at" TIMESTAMP NOT NULL,
	"employee_id" UUID NOT NULL,
	"duration" INTERVAL NOT NULL,
	"begin_time" TIMESTAMP NOT NULL,
	PRIMARY KEY("auction_id")
);


CREATE TABLE "stocks" (
	"stock_id" UUID NOT NULL UNIQUE,
	"created_at" TIMESTAMP NOT NULL,
	"updated_at" TIMESTAMP NOT NULL,
	"auction_id" UUID NOT NULL,
	"vehicle_id" UUID NOT NULL,
	"sold_status_id" UUID NOT NULL,
	"begin_time" TIMESTAMP NOT NULL,
	PRIMARY KEY("stock_id")
);


CREATE TABLE "vehicles" (
	"vehicle_id" UUID NOT NULL UNIQUE,
	"created_at" TIMESTAMP NOT NULL,
	"update_at" TIMESTAMP NOT NULL,
	"series_id" UUID NOT NULL,
	"employee_id" UUID NOT NULL,
	PRIMARY KEY("vehicle_id")
);


CREATE TABLE "series" (
	"series_id" UUID NOT NULL UNIQUE,
	"name" VARCHAR(255),
	PRIMARY KEY("series_id")
);


CREATE TABLE "employees" (
	"employee_id" UUID NOT NULL UNIQUE,
	"name" VARCHAR(255) NOT NULL,
	"job_type_id" UUID NOT NULL,
	PRIMARY KEY("employee_id")
);


CREATE TABLE "job_types" (
	"job_type_id" UUID NOT NULL UNIQUE,
	"name" VARCHAR(255) NOT NULL,
	PRIMARY KEY("job_type_id")
);


CREATE TABLE "notifications" (
	"notification_id" UUID NOT NULL UNIQUE,
	"title" VARCHAR(255) NOT NULL,
	"body" VARCHAR(255),
	"created_at" TIMESTAMP NOT NULL,
	"updated_at" TIMESTAMP NOT NULL,
	"emplyee_id" UUID NOT NULL,
	"deploy_schedule" TIMESTAMP,
	"deploy_status_id" UUID,
	PRIMARY KEY("notification_id")
);


CREATE TABLE "deploy_statuses" (
	"deploy_status_id" UUID NOT NULL UNIQUE,
	"name" VARCHAR(255) NOT NULL,
	PRIMARY KEY("deploy_status_id")
);


CREATE TABLE "contacts" (
	"contact_id" UUID NOT NULL UNIQUE,
	"customer_id" UUID NOT NULL,
	"title" VARCHAR(255) NOT NULL,
	"body" VARCHAR(255) NOT NULL,
	"employee_id" UUID,
	"created_at" TIMESTAMP,
	"updated_at" TIMESTAMP,
	PRIMARY KEY("contact_id")
);


CREATE TABLE "sold_statuses" (
	"sold_status_id" UUID NOT NULL UNIQUE,
	"name" VARCHAR(255) NOT NULL,
	PRIMARY KEY("sold_status_id")
);


CREATE TABLE "bids" (
	"bid_id" UUID NOT NULL UNIQUE,
	"customer_id" UUID NOT NULL,
	"stock_id" UUID NOT NULL,
	"price" NUMERIC,
	"created_at" TIMESTAMP,
	PRIMARY KEY("bid_id")
);


CREATE TABLE "customers" (
	"customer_id" UUID NOT NULL UNIQUE,
	"name" VARCHAR(255) NOT NULL,
	"email" VARCHAR(255) NOT NULL,
	"prefecture" VARCHAR(255),
	"city" VARCHAR(255),
	"address" VARCHAR(255),
	"post_code" VARCHAR(7),
	"password_hash" VARCHAR(255) NOT NULL,
	"created_at" TIMESTAMP,
	"updated_at" TIMESTAMP,
	PRIMARY KEY("customer_id")
);


ALTER TABLE "auctions"
ADD FOREIGN KEY("auction_id") REFERENCES "stocks"("auction_id")
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE "stocks"
ADD FOREIGN KEY("vehicle_id") REFERENCES "vehicles"("vehicle_id")
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE "vehicles"
ADD FOREIGN KEY("series_id") REFERENCES "series"("series_id")
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE "vehicles"
ADD FOREIGN KEY("employee_id") REFERENCES "employees"("employee_id")
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE "employees"
ADD FOREIGN KEY("job_type_id") REFERENCES "job_types"("job_type_id")
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE "auctions"
ADD FOREIGN KEY("employee_id") REFERENCES "employees"("employee_id")
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE "employees"
ADD FOREIGN KEY("employee_id") REFERENCES "notifications"("emplyee_id")
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE "notifications"
ADD FOREIGN KEY("deploy_status_id") REFERENCES "deploy_statuses"("deploy_status_id")
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE "contacts"
ADD FOREIGN KEY("employee_id") REFERENCES "employees"("employee_id")
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE "sold_statuses"
ADD FOREIGN KEY("sold_status_id") REFERENCES "stocks"("sold_status_id")
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE "bids"
ADD FOREIGN KEY("stock_id") REFERENCES "stocks"("stock_id")
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE "bids"
ADD FOREIGN KEY("customer_id") REFERENCES "customers"("customer_id")
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE "contacts"
ADD FOREIGN KEY("customer_id") REFERENCES "customers"("customer_id")
ON UPDATE NO ACTION ON DELETE NO ACTION;