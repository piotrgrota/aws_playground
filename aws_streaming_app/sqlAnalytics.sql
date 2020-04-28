CREATE OR REPLACE STREAM "DESTINATION_SQL_STREAM" ("userName" VARCHAR(8), User_Counter INTEGER, Min_Balance INTEGER, Max_balance INTEGER, Avg_balance double);
-- Create pump to insert into output 
CREATE OR REPLACE PUMP "STREAM_PUMP" AS INSERT INTO "DESTINATION_SQL_STREAM"
-- Select all columns from source stream

    SELECT STREAM 
        "userName",
        count(*) as User_Counter,
        MIN("balance") AS Min_Balance,
        MAX("balance")  AS Max_Balance,
       AVG("balance") AS Avg_Balance
from "BalanceApplication_001"
GROUP BY "userName", 
    STEP("BalanceApplication_001".ROWTIME BY INTERVAL '3' MINUTE ),
    STEP("BalanceApplication_001"."eventTime" BY INTERVAL '3' MINUTE);
