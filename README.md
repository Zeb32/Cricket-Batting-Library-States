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
4. [Format-Specific Questions](#format-specific-questions)
   - [Highest Individual ODI Score](#highest-individual-odi-score)
   - [Players with Centuries in All Formats](#players-with-centuries-in-all-formats)
   - [Test Avg > 50 and T20 Avg < 30](#test-avg-50-and-t20-avg-30)
5. [Aggregation and Grouping](#aggregation-and-grouping)
   - [Total Runs Across Formats](#total-runs-across-formats)
   - [Player with Most ODI Centuries](#player-with-most-odi-centuries)
   - [Average Runs by Country in T20](#average-runs-by-country-in-t20)
6. [Filtering and Conditions](#filtering-and-conditions)
   - [Test Players with Innings of 200+](#test-players-with-innings-of-200)
   - [Players with 100+ T20 Sixes](#players-with-100-t20-sixes)
   - [ODI Avg > 40 and Matches < 50](#odi-avg-40-and-matches-50)
7. [Ranking and Sorting](#ranking-and-sorting)
   - [Rank Players by ODI Runs](#rank-players-by-odi-runs)
   - [Sort Players by Test Fifties](#sort-players-by-test-fifties)
8. [Joins and Advanced Queries](#joins-and-advanced-queries)
   - [5000+ Runs and 100+ ODI Wickets](#5000-runs-and-100-odi-wickets)
   - [Test Players Aged 35+ with Avg > 40](#test-players-aged-35-with-avg-40)
   - [Top 5 T20 Strike Rates (500+ Balls Faced)](#top-5-t20-strike-rates-500-balls-faced)
9. [Statistical and Analytical Queries](#statistical-and-analytical-queries)
   - [Overall Batting Average](#overall-batting-average)
   - [Top 10 Test Ducks](#top-10-test-ducks)
   - [Percentage of Fifty+ Scores in ODIs](#percentage-of-fifty-scores-in-odis)

---

## Cleaning Data

### Change Column Name
```sql
EXEC sp_rename 'Batting_ODI_data.column1', 'ID', 'COLUMN';
EXEC sp_rename 'Batting_test.column1', 'ID', 'COLUMN';
EXEC sp_rename 'Batting_t20.column1', 'ID', 'COLUMN';
