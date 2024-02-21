CREATE DATABASE wave1;
CREATE TABLE `users` (
  `u_id` integer PRIMARY KEY,
  `name` text NOT NULL,
  `mobile` text NOT NULL,
  `wallet_id` integer NOT NULL,
  `when_created` timestamp NOT NULL
);

CREATE TABLE `transfers` (
    `transfer_id` INTEGER PRIMARY KEY,
    `u_id` INTEGER NOT NULL,
    `source_wallet_id` INTEGER NOT NULL,
    `dest_wallet_id` INTEGER NOT NULL,
    `send_amount_currency` TEXT NOT NULL,
    `send_amount_scalar` NUMERIC NOT NULL,
    `receive_amount_currency` TEXT NOT NULL,
    `receive_amount_scalar` NUMERIC NOT NULL,
    `kind` TEXT NOT NULL,
    `dest_mobile` TEXT,
    `dest_merchant_id` INTEGER,
    `when_created` TIMESTAMP NOT NULL
);

CREATE TABLE `agents` (
  `agent_id` integer PRIMARY KEY,
  `name` text,
  `country` text NOT NULL,
  `region` text,
  `city` text,
  `subcity` text,
  `when_created` timestamp NOT NULL
);

CREATE TABLE `agent_transactions` (
  `atx_id` integer PRIMARY KEY,
  `u_id` integer NOT NULL,
  `agent_id` integer NOT NULL,
  `amount` numeric NOT NULL,
  `fee_amount_scalar` numeric NOT NULL,
  `when_created` timestamp NOT NULL
);

CREATE TABLE `wallets` (
  `wallet_id` integer PRIMARY KEY,
  `currency` text NOT NULL,
  `ledger_location` text NOT NULL,
  `when_created` timestamp NOT NULL
);

/*Imported the data using the Table Data Import Wizard 
so had to indicate the columns that are primary keys in
the tables */

ALTER TABLE transfers CHANGE user_id u_id INTEGER NOT NULL; 
ALTER TABLE users ADD PRIMARY KEY (u_id);
ALTER TABLE transfers ADD PRIMARY KEY (transfer_id);
ALTER TABLE agents ADD PRIMARY KEY (agent_id);
ALTER TABLE agent_transactions ADD PRIMARY KEY (atx_id);
ALTER TABLE wallets ADD PRIMARY KEY (wallet_id);

/*This is to indicate the foreign keys*/
ALTER TABLE transfers ADD FOREIGN KEY (u_id) REFERENCES users (u_id);

ALTER TABLE agent_transactions ADD FOREIGN KEY (agent_id) REFERENCES agents (agent_id);

ALTER TABLE users ADD FOREIGN KEY (wallet_id) REFERENCES wallets (wallet_id);

ALTER TABLE transfers ADD FOREIGN KEY (source_wallet_id) REFERENCES wallets (wallet_id);

ALTER TABLE users ADD FOREIGN KEY (wallet_id) REFERENCES wallets (wallet_id);






