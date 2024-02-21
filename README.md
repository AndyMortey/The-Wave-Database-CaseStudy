# The-Wave-Database-CaseStudy
## Introduction
This case study employs SQL to answer questions about a money transfer business operated by a company called Wave. A schema was provided which shared a partial view of some tables from Wave's actual PostgreSQL schema. These tables include; agents table,transfers table,agent_transactions table, users table and wallet table. The purpose of the case study is to deduce some insights from the operations of the money transfer company. It provides a set of questions that are answered using SQL queries. 

## Background
These are the questions the case study seeks to answer using SQL queries.
### Question One: How many agent_transactions did we have in the months of 2022(broken down by month)? An agent transaction (often abbreviated atx) is when someone deposits or withdraws money from a Wave agent, and an agent is a person or business that is contracted to facilitate transactions for users. The most important of these are cash-in and cash-out (i.e. loading value into the mobile money system, and then converting it back out again).
### Question Two: Over the course of the first half of 2022, how many Wave agents were 'net depositors' vrs 'net withdrawers'? A net depositor is an agent who received more deposit volume than withdrawal volume over some given time frame (and vise versa for a net withdrawer). Whether an agent transaction is a deposit or a withdrawal depends on the sign of its amount; a negative amount is a deposit, a positive amount is a withdrawal and zero amounts are not allowed. 
### Question Three: Build an 'atx volume city summary' table: find the volume of agent transactions created in the first half of 2022, grouped by city. You can determine the city where the agent transaction took place from the agent's city field.
### Question Four: Now seperate the atx volume by country as well (so your columns should be country,city,volume).
### Question Five: Build a 'send volume by country and kind' table: find the total volume of transfers (by send_amount_scalar) sent in the first half of 2022, grouped by country and transfer kind. There are a few different kinds of Wave transfers, e.g. a 'P2P' transfer between a Wave user and a mobile number, or a payment from a Wave user to a merchant. The country a transfer was sent from isn't stored on the transfers table itself, but rather on the wallet table's ledger_location field (and each transfer has a source_wallet_id). Your columns should be country, transfer kind, and volume. 
### Question Six: Then add columns for transaction count and number of unique senders(still broken down by country and transfer kind). 
### Question Seven: Finally, which wallets sent more than 1,000,000 CFA in transfers in the first quarter(as identified by the source_wallet_id columnon the transfers table) and how much did they send?

## Appreciation
I highly recommend Azubi Africa for their comprehensive and effective programs. Read More articles about [Azubi Africa here](https://medium.com/@azubiafrica) and take a few minutes to visit this link to learn more about Azubi Africa life-changing [programs](https://bit.ly/41CGCwK)

## Tags
[Azubi Data Science](https://bit.ly/3ARq742)
