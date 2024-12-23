-- cleaning data --Change column name
EXEC sp_rename 'Batting_ODI_data.column1','ID','COLUMN';

EXEC sp_rename 'Batting_test.column1','ID','COLUMN';

EXEC sp_rename 'Batting_t20.column1', 'ID', 'COLUMN';

-- cleaning data --Delete column 
ALTER TABLE Batting_test
drop column Unnamed_11;

ALTER TABLE Batting_t20
drop column Unnamed_15;

-- cleaning data --filtering out the null
delete  from Batting_test
 where inns is null;
 delete  from Batting_ODI_data
 where inns is null;
  delete  from Batting_t20
 where inns is null;

-- Retreiving data
-- select everything form table
select * from Batting_test
select * from batting_odi_data
select * from Batting_t20 

-- Count Rows in data
select COUNT(*) from Batting_test

-- Retriev specicfic data for player
select player,mat,runs,hs,Ave,_100,_50
from Batting_ODI_data
select player,mat,runs,hs,Ave,_100,_50
from Batting_t20
select player,mat,runs,hs,Ave,_100,_50
from Batting_test

-- Retrive by maximum hundrud
select player,mat,runs,hs,Ave,_100,_50
from Batting_ODI_data
order by _100 desc
select player,mat,runs,hs,Ave,_100,_50
from Batting_t20
order by _100 desc
select player,mat,runs,hs,Ave,_100,_50
from Batting_test
order by _100 desc

-- retreiev state for specific player (babar & virat)
select player,mat,runs,hs,Ave,_100,_50
from Batting_ODI_data
where Player like '%babar azam%' or Player like '%kohli%';
select player,mat,runs,hs,Ave,_100,_50
from Batting_test
where Player like '%babar azam%' or Player like '%kohli%'
select player,mat,runs,hs,Ave,_100,_50
from Batting_t20
where Player like '%babar azam%' or Player like '%kohli%'

--top 10 players by score
select top (10) player,mat,runs,hs,Ave,_100,_50
from Batting_ODI_data
order by Runs desc
select top (10) player,mat,runs,hs,Ave,_100,_50
from Batting_test
order by runs desc
select top (10) player,mat,runs,hs,Ave,_100,_50
from Batting_t20
order by runs desc

-- Combine state from all formate Most Runs
select BO.player,BO.runs AS ODI_RUNS,BS.Runs AS TEST_RUNS,BT.Runs as T20_RUNS
from Batting_ODI_data BO
full outer join Batting_test BS
on BS.Player = BO.Player
FULL OUTER JOIN Batting_t20 BT
ON BS.Player = BT.Player
WHERE BO.Player IS NOT NULL AND BT.Player IS NOT NULL

--Retrieve the top 10 players with the highest overall batting average in all formats.
select top (10) BO.player, round(BO.ave,2) AS ODI_AVG, round(BS.ave,2) as TEST_AVG,round(BT.Ave,2) AS T20_AVG
from Batting_t20 BT
inner JOIN Batting_test BS
ON BT.Player = BS.Player
inner JOIN Batting_ODI_data BO
ON BS.Player = BO.Player
where BO.player is not null
ORDER BY ODI_AVG DESC

-- List all players who have scored more than 10,000 runs in Test matches.
select player,Runs 
from Batting_test
where Runs >10000

--Find players with more 10 or more than 10 100 and gone for duck more than 10 times in ODI matches 
select player, _100,_0
from Batting_ODI_data
where _100  >= 10 and _0  > 10

--Format-Specific Questions

--Which player has the highest individual score in ODI cricket?
select TOP (1) Player, HS
from Batting_ODI_data
order by HS DESC


--Retrieve the names of players who have centuries in all three formats.
SELECT  BO.Player,BO._100 as ODI100,BT._100 AS T20100,BS._100 AS TEST100
FROM Batting_ODI_data BO
JOIN Batting_t20 BT
ON BO.Player = BT.Player
JOIN Batting_test BS
ON BT.Player = BS.Player
WHERE BO._100 >0 AND BT._100> 0 AND BS._100>0
order by BO._100 desc 



--Find players with an average above 50 in Test matches but below 30 in T20s.
select BS.Player,ROUND(BS.AVE,2) AS TESTAVG,ROUND(BT.AVE,2) AS T2OAVQ
FROM Batting_test BS
JOIN Batting_t20 BT
ON BS.Player = BT.Player
WHERE BS.AVE >50 AND BT.AVE < 30




--Aggregation and Grouping
--Calculate the total runs scored by each player across all formats.
alter table Batting_test
alter column Runs INT

select * from Batting_t20

SELECT BO.Player,cast(BO.Runs as int)+cast(BT.Runs as int)+cast(BS.Runs as int) as Total_runs
FROM Batting_ODI_data BO
FULL OUTER JOIN Batting_t20 BT
ON BO.Player = BT.Player
FULL OUTER JOIN Batting_test BS
ON BT.Player = BS.Player
order by Total_runs desc

--Find the player with the most centuries in ODI cricket.
-- need to convert tinyint to inr
UPDATE Batting_t20
SET Runs = TRY_CAST(Runs AS INT);

select TOP (1) player,_100
from Batting_ODI_data
ORDER BY _100 DESC

--Group players by country and calculate the average runs scored by players from each country in T20 matches.
-- to extract Country from playername we use substring

SELECT 
    SUBSTRING(Player, CHARINDEX('(', Player) + 1, CHARINDEX(')', Player) - CHARINDEX('(', Player) - 1) AS Country,
    AVG(runs) AS Average_Runs
FROM 
    Batting_t20
GROUP BY 
    SUBSTRING(Player, CHARINDEX('(', Player) + 1, CHARINDEX(')', Player) - CHARINDEX('(', Player) - 1)
	order by 1 

--Filtering and Conditions
--List all players who have scored at least 200 in a Test innings.

select Player,
REPLACE(HS,'*','') AS highest_Score -- MY DATA HAVE VALUE LIKE THIS 100* I NEED TO REMOVE THE STAR
from Batting_test
where REPLACE(HS,'*','') >= 200
order by 2 desc

--Retrieve players who have hit more than 100 or more sixes in T20 cricket.
select Player,_6s
from Batting_t20
where _6s >= 100


--Find players who have played fewer than 50 matches in ODIs but have a batting average above 40.
select Player,Mat,round(Ave,2)
from Batting_ODI_data
where mat < 50 
and
ave > 40

--Ranking and Sorting
--Rank players by their total runs scored in ODI cricket.

SELECT 
    Player,
    sum(Runs) AS Total_Runs,
    ROW_NUMBER() OVER (ORDER BY sum(Runs) DESC) AS Player_Rank -- window function 
FROM 
   Batting_ODI_data
GROUP BY 
    Player
ORDER BY 
    Player_Rank;

--Sort players by the number of fifties scored in Test cricket.
select player,_50
from Batting_test
order by _50 desc

--Joins and Advanced Queries
--If you have a separate table for bowling stats, find players who have scored more than 5000 runs and taken at least 100 wickets in ODIs.
SELECT BT.Player,BT.Runs,DT.sum_of_wkts as Wickets
FROM DATA DT
JOIN Batting_ODI_data BT
ON DT.player = BT.Player
where BT.Runs > 5000 and DT.sum_of_wkts >=100
order by 2 desc,3 desc


--Combine batting stats with player profiles to find players aged 35 or older with an average above 40 in Test cricket.
SELECT Player,Ave
FROM Batting_test
WHERE AVE > 40
ORDER BY AVE DESC

--Retrieve TOP 5 players with the highest strike rate in T20 matches among those who have faced at least 500 balls.
SELECT TOP (5) Player,SR,BF
FROM Batting_t20
WHERE BF >= 500
ORDER BY SR DESC



--Statistical and Analytical Queries
--Calculate the overall batting average across all formats for each player.
SELECT BO.Player,cast(BO.Ave as int)+cast(BT.Ave as int)+cast(BS.Ave as int) as AVGG
FROM Batting_ODI_data BO
FULL OUTER JOIN Batting_t20 BT
ON BO.Player = BT.Player
FULL OUTER JOIN Batting_test BS
ON BT.Player = BS.Player
order by AVGG desc




--Find TOP 10 player with the most ducks (zero runs) in Test matches.
SELECT TOP (10) Player,_0
FROM Batting_test
ORDER BY _0 DESC


--Determine the percentage of matches in which a player scored a fifty or more in ODIs.
SELECT Player,Mat ,_100+_50 AS FIFTY_OR_MORE, ((_100+_50)/Mat)*100
FROM Batting_ODI_data
WHERE _100+_50 > 0


