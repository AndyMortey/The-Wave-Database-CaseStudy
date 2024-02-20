USE wave1;
ALTER TABLE transfers CHANGE user_id u_id INTEGER NOT NULL; 
ALTER TABLE transfers ADD FOREIGN KEY (u_id) REFERENCES users (u_id);

#QUESTION ONE:
#How many agent_transactions did we have in the months of 2022(broken down by month)?
SELECT MONTHNAME(when_created) AS transaction_month, COUNT(*) AS number_of_agent_transactions
FROM agent_transactions
GROUP BY transaction_month;

/* This query extracts the month from the when_created column in 
the agent_transactions table and named it as transaction_month and counts the number of 
transactions for each month and named it as number_of_agent_transactions. And finally groups by transaction_month.*/

#QUESTION TWO:
#Over the course of the first half of 2022, how many Wave agents were 'net depositors' vrs 'net withdrawers'?
CREATE TEMPORARY TABLE total_amount AS
SELECT agent_id, SUM(amount) AS total_amount
FROM agent_transactions
WHERE YEAR(when_created) = 2022 AND MONTH(when_created) <= 6 
GROUP BY agent_id;
# Then this counts the number of net depositors and net withdrawers...
SELECT SUM(CASE WHEN total_amount < 0 THEN 1 ELSE 0 END) AS net_depositors,
SUM(CASE WHEN total_amount > 0 THEN 1 ELSE 0 END) AS net_withdrawers
FROM total_amount;
/* This query creates a temporary table named total_amount that contains agent_id, and the sum of deposits and
withdrawals for each agent in the first half of 2022 and grouped by the agent_id. Then the CASE WHEN is used
to count the number of rows in the temporary table that have a negative amount as net depositors and positive
amount as net withdrawers. */


#QUESTION THREE:
#Build an 'atx volume city summary' table: find the volume of agent transactions created in the first half of 2022, grouped by city.
#You can determine the city where the agent transaction took place from the agent's city field. 
SELECT agents.city,SUM(agent_transactions.amount) AS volume_of_transactions
FROM agent_transactions 
INNER JOIN agents ON agent_transactions.agent_id = agents.agent_id
WHERE YEAR(agent_transactions.when_created) = 2022 AND MONTH(agent_transactions.when_created) <= 6
GROUP BY agents.city;

#QUESTION FOUR:
#Now seperate the atx volume by country as well (so your columns should be country,city,volume). 
SELECT agents.country, agents.city, SUM(agent_transactions.amount) AS volume_of_transactions
FROM agent_transactions
JOIN agents ON agent_transactions.agent_id = agents.agent_id
WHERE YEAR(agent_transactions.when_created) = 2022 AND MONTH(agent_transactions.when_created) <= 6
GROUP BY agents.country, agents.city;

#QUESTION FIVE:
#Build a 'send volume by country and kind' table: find the total volume of transfers (by send_amount_scalar)
#sent in the first half of 2022, grouped by country and transfer kind.
SELECT agents.country, transfers.kind, SUM(transfers.send_amount_scalar) AS total_send_volume
FROM transfers
INNER JOIN users ON transfers.u_id = users.u_id
INNER JOIN wallets ON transfers.source_wallet_id = wallets.wallet_id
INNER JOIN agents ON wallets.wallet_id = agents.agent_id
WHERE YEAR(transfers.when_created) = 2022 AND MONTH(transfers.when_created) <= 6
GROUP BY agents.country, transfers.kind;

#QUESTION SIX:
#Then add columns for transaction count and number of unique senders(still broken down by country and transfer kind)
SELECT agents.country, transfers.kind, SUM(transfers.send_amount_scalar) AS total_send_volume,
COUNT(*) AS transaction_count, COUNT(DISTINCT users.u_id) AS number_of_unique_senders
FROM transfers
INNER JOIN users ON transfers.u_id = users.u_id
INNER JOIN wallets ON transfers.source_wallet_id = wallets.wallet_id
INNER JOIN agents ON wallets.wallet_id = agents.agent_id
WHERE YEAR(transfers.when_created) = 2022 AND MONTH(transfers.when_created) <= 6
GROUP BY agents.country, transfers.kind;

#QUESTION SEVEN:
#Finally, which wallets sent more than 1,000,000 CFA in transfers in the first quarter(as identified by the 
#source_wallet_id columnon the transfers table) and how much did they send?
SELECT source_wallet_id, SUM(send_amount_scalar) AS total_sent
FROM transfers
WHERE send_amount_currency = 'CFA' AND send_amount_scalar > 1000000
AND YEAR(when_created) = 2022 AND QUARTER(when_created) = 1
GROUP BY source_wallet_id;

