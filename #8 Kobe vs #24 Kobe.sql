USE PortfolioProject
--- First, viewed specific data for 'Kobe Bryant'

SELECT *
FROM [dbo].[Advanced_Stats]
WHERE Player = 'Kobe Bryant'

SELECT *
FROM [dbo].[Total_Stats]
WHERE Player = 'Kobe Bryant'

SELECT *
FROM [dbo].[PerGame_Stats]
WHERE Player = 'Kobe Bryant'

--- Clean and Prepare Data
--- Create new table for only Kobe's career after using JOIN on the three tables to analyze key columns

SELECT Advanced_Stats.Player, Advanced_Stats.Season, Advanced_Stats.Age, Advanced_Stats.G, Advanced_Stats.RSorPO, 
	[TS%], [USG%], [tFG%], [tFGA], [t3P%], [FT%], [tTRB], [tAST], [tSTL], [tBLK], 
	[tPTS],[FG],[FGA], [3P%], [TRB], [AST], [STL], [BLK], [PTS]
INTO KobeBryantCareer
FROM [dbo].[Advanced_Stats]
JOIN Total_Stats
ON Advanced_Stats.Season = Total_Stats.Season AND Advanced_Stats.Age = Total_Stats.Age
	AND Advanced_Stats.G = Total_Stats.G AND Advanced_Stats.Player = Total_Stats.Player 
	AND Advanced_Stats.RSorPO = Total_Stats.RSorPO
JOIN PerGame_Stats
ON PerGame_Stats.Season = Total_Stats.Season AND PerGame_Stats.Age = Total_Stats.Age
	AND PerGame_Stats.G = Total_Stats.G AND PerGame_Stats.Player = Total_Stats.Player 
	AND PerGame_Stats.RSorPO = Total_Stats.RSorPO

--- Deleted uneccsary data for analysis

DELETE FROM Advanced_Stats
WHERE Player = 'Lebron James'
DELETE FROM Advanced_Stats
WHERE Player = 'Michael Jordan';

--- View and Analyze specific columns from dataset for new Kobe table

Select [Season], [PTS], [TRB], [AST]
FROM KobeBryantCareer

Select [Season], [STL], [BLK]
FROM KobeBryantCareer

Select [Season], [tFG%], [3P%], [FT%]
FROM KobeBryantCareer

--- Isolated #8 and #24
--- Apply calculations for career averages on Excel for visualizations on Tableau

SELECT [Season], [Age], [PTS], [TRB], [AST], [STL], [BLK], [tFG%], [3P%], [FT%] 
FROM KobeBryantCareer
WHERE  RSorPO = 'Regular Season' AND Age <28 

SELECT Season, [tFG%],[3P%], [FT%]
FROM KobeBryantCareer
WHERE  RSorPO = 'Regular Season' AND Age <28 
	
SELECT [Season], [Age], [PTS], [TRB], [AST], [STL], [BLK], [tFG%], [3P%], [FT%] 
FROM KobeBryantCareer
WHERE  RSorPO = 'Regular Season' AND Age >27 

SELECT Season, [tFG%],[3P%], [FT%]
FROM KobeBryantCareer
WHERE  RSorPO = 'Regular Season' AND Age >27 

--- Collect career totals stats for visualization

SELECT RSorPO, G, [tPTS], [tTRB], [tAST], [tSTL], [tBLK], [tFG%], [t3P%], [FT%]
FROM KobeBryantCareer
WHERE  RSorPO = 'Regular Season' AND Age <28 

SELECT RSorPO, G, [tPTS], [tTRB], [tAST], [tSTL], [tBLK], [tFG%], [t3P%], [FT%]
FROM KobeBryantCareer
WHERE  RSorPO = 'Regular Season' AND Age >27 
