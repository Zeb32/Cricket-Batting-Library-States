# SQL Batting Data Management README

## Table of Contents
1. [Cleaning Data](#cleaning-data)
   - [Change Column Name](#change-column-name)
   - [Delete Column](#delete-column)
   - [Filtering Out Null Values](#filtering-out-null-values)
2. [Retrieving Data](#retrieving-data)
   - [Select Everything](#select-everything)
   - [Count Rows](#count-rows)
   - [Retrieve Specific Data for Player](#retrieve-specific-data-for-player)
   - [Retrieve by Maximum Centuries](#retrieve-by-maximum-centuries)
   - [Retrieve Stats for Specific Players](#retrieve-stats-for-specific-players)
   - [Top 10 Players by Score](#top-10-players-by-score)
3. [Advanced Queries](#advanced-queries)
   - [Combine Runs Across All Formats](#combine-runs-across-all-formats)
   - [Top Players by Overall Average](#top-players-by-overall-average)
   - [Players with 10,000+ Test Runs](#players-with-10000-test-runs)
   - [ODI Players with 10+ Centuries and 10+ Ducks](#odi-players-with-10-centuries-and-10-ducks)

## Cleaning Data

### Change Column Name
```sql
EXEC sp_rename 'Batting_ODI_data.column1', 'ID', 'COLUMN';
EXEC sp_rename 'Batting_test.column1', 'ID', 'COLUMN';
EXEC sp_rename 'Batting_t20.column1', 'ID', 'COLUMN';
```

### Delete Column
```sql
ALTER TABLE Batting_test DROP COLUMN Unnamed_11;
ALTER TABLE Batting_t20 DROP COLUMN Unnamed_15;
```

### Filtering Out Null Values
```sql
DELETE FROM Batting_test WHERE inns IS NULL;
DELETE FROM Batting_ODI_data WHERE inns IS NULL;
DELETE FROM Batting_t20 WHERE inns IS NULL;
```

---

## Retrieving Data

### Select Everything
```sql
SELECT * FROM Batting_test;
SELECT * FROM Batting_ODI_data;
SELECT * FROM Batting_t20;
```

### Count Rows
```sql
SELECT COUNT(*) FROM Batting_test;
```

### Retrieve Specific Data for Player
```sql
SELECT player, mat, runs, hs, Ave, _100, _50 FROM Batting_ODI_data;
SELECT player, mat, runs, hs, Ave, _100, _50 FROM Batting_t20;
SELECT player, mat, runs, hs, Ave, _100, _50 FROM Batting_test;
```

### Retrieve by Maximum Centuries
```sql
SELECT player, mat, runs, hs, Ave, _100, _50 FROM Batting_ODI_data ORDER BY _100 DESC;
SELECT player, mat, runs, hs, Ave, _100, _50 FROM Batting_t20 ORDER BY _100 DESC;
SELECT player, mat, runs, hs, Ave, _100, _50 FROM Batting_test ORDER BY _100 DESC;
```

### Retrieve Stats for Specific Players
```sql
SELECT player, mat, runs, hs, Ave, _100, _50
FROM Batting_ODI_data
WHERE Player LIKE '%babar azam%' OR Player LIKE '%kohli%';

SELECT player, mat, runs, hs, Ave, _100, _50
FROM Batting_test
WHERE Player LIKE '%babar azam%' OR Player LIKE '%kohli%';

SELECT player, mat, runs, hs, Ave, _100, _50
FROM Batting_t20
WHERE Player LIKE '%babar azam%' OR Player LIKE '%kohli%';
```

### Top 10 Players by Score
```sql
SELECT TOP (10) player, mat, runs, hs, Ave, _100, _50 FROM Batting_ODI_data ORDER BY Runs DESC;
SELECT TOP (10) player, mat, runs, hs, Ave, _100, _50 FROM Batting_test ORDER BY Runs DESC;
SELECT TOP (10) player, mat, runs, hs, Ave, _100, _50 FROM Batting_t20 ORDER BY Runs DESC;
```

---

## Advanced Queries

### Combine Runs Across All Formats
```sql
SELECT BO.player, BO.runs AS ODI_RUNS, BS.Runs AS TEST_RUNS, BT.Runs AS T20_RUNS
FROM Batting_ODI_data BO
FULL OUTER JOIN Batting_test BS ON BS.Player = BO.Player
FULL OUTER JOIN Batting_t20 BT ON BS.Player = BT.Player
WHERE BO.Player IS NOT NULL AND BT.Player IS NOT NULL;
```

### Top Players by Overall Average
```sql
SELECT TOP (10) BO.player, ROUND(BO.ave, 2) AS ODI_AVG, ROUND(BS.ave, 2) AS TEST_AVG, ROUND(BT.Ave, 2) AS T20_AVG
FROM Batting_t20 BT
INNER JOIN Batting_test BS ON BT.Player = BS.Player
INNER JOIN Batting_ODI_data BO ON BS.Player = BO.Player
WHERE BO.player IS NOT NULL
ORDER BY ODI_AVG DESC;
```

### Players with 10,000+ Test Runs
```sql
SELECT player, Runs FROM Batting_test WHERE Runs > 10000;
```

### ODI Players with 10+ Centuries and 10+ Ducks
```sql
SELECT player, _100, _0 FROM Batting_ODI_data WHERE _100 >= 10 AND _0 > 10;
