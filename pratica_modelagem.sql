CREATE DATABASE drivenbank();

CREATE TABLE states (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL
);

CREATE TABLE cities(
	id SERIAL PRIMARY KEY,
	name TEXT NOT NULL,
	"stateId" INTEGER NOT NULL REFERENCES states(id)
);

CREATE TABLE customers(
	id SERIAL PRIMARY KEY,
	"fullName" TEXT NOT NULL,
	cpf VARCHAR(11) UNIQUE NOT NULL,
	email VARCHAR(30) NOT NULL,
	password TEXT NOT NULL
);

CREATE TABLE "customerPhones"(
	id SERIAL PRIMARY KEY,
	"customerId" INTEGER NOT NULL REFERENCES customers(id),
	number INTEGER UNIQUE NOT NULL,
	type TEXT NOT NULL DEFAULT 'mobile'
);

CREATE TABLE "customerAddresses"(
	id SERIAL PRIMARY KEY,
	"customerId" INTEGER UNIQUE NOT NULL REFERENCES customers(id),
	street VARCHAR(30) NOT NULL,
	number INTEGER NOT NULL,
	complement VARCHAR(30),
	"postalCode" VARCHAR(10) NOT NULL,
	"cityId" INTEGER UNIQUE NOT NULL REFERENCES cities(id)
);

CREATE TABLE "bankAccount"(
	id SERIAL PRIMARY KEY,
	"customerId" INTEGER NOT NULL REFERENCES customers(id),
	"accountNumber" INTEGER NOT NULL,
	agency INTEGER NOT NULL,
	"openDate" TIMESTAMP NOT NULL DEFAULT NOW(),
	"closeDate" TIMESTAMP DEFAULT NULL
);

CREATE TABLE transactions(
	id SERIAL PRIMARY KEY,
	"bankAccountId" INTEGER NOT NULL REFERENCES "bankAccount"(id),
	amount INTEGER NOT NULL,
	type TEXT NOT NULL,
	time TIMESTAMP NOT NULL DEFAULT NOW(),
	description TEXT NOT NULL, 
	cancelled BOOLEAN NOT NULL DEFAULT false
);

CREATE TABLE "creditCards"(
	id SERIAL PRIMARY KEY,
	"bankAccountId" INTEGER NOT NULL REFERENCES "bankAccount"(id),
	name TEXT NOT NULL,
	number INTEGER UNIQUE NOT NULL,
	"securityCode" INTEGER NOT NULL,
	"expirationMonth" INTEGER NOT NULL,
	"expirationYear" INTEGER NOT NULL,
	password TEXT NOT NULL,
	"limit" INTEGER NOT NULL
);