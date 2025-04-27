create database spotify;
use spotify;

select * from spotifyy;
--------------------------------------------------------------# Intro question of spotify project

#find max duration song
select max(Duration_min) as Max_Duration from spotifyy;


#find min duration song
select min(Duration_min)as Min_Duration from spotifyy;

#find the duration which is 0
select * from spotifyy where Duration_min = 0;

# find the name of the channel in spotify.
select distinct channel from spotifyy;

# find the most played stream music.
select distinct most_playedon from spotifyy;

select count(*) from spotifyy;
#find the name of the artist
select distinct artist from spotifyy;

-----------------------------------------------------------------# Data analyst easy-level question;
#find the name of all the track that have more than 1 billion streams
select Track from spotifyy where stream > 100000000;

#list all the albums with their respective artist.
select distinct Album,Artist from spotifyy ;

# get the total number of the comments for track where tarcke license = true.
select sum(Comments) as Total_comments from spotifyy where licensed = 'TRUE';	

# find all track that being to the album typpe single;
select Track from spotifyy where Album_type = 'single';


#count the total number of track by each artist;
select Artist,count(*) as Total_track from spotifyy group  by Artist;

-----------------------------------------------------# Mid-Level Data analyst Question

### Medium Level
#1. Calculate the average danceability of tracks in each album.
select Album, avg(Danceability) as Total_dance from spotifyy group by Album order by Total_dance;



#2. Find the top 5 tracks with the highest energy values.

select Track,max(Energy) as Max_Energy from spotifyy group by Track order by Max_Energy DESC limit 5;


#3. List all tracks along with their views and likes where `official_video = TRUE`.
select Track,sum(Views) as total_views, sum(Likes) as total_likes from spotifyy where official_video = 'TRUE' group by 1 order by 2; 

#4. For each album, calculate the total views of all associated tracks
select Album,Track, sum(Views) as Total_views from spotifyy group by 1,2;


#5. Retrieve the track names that have been streamed on Spotify more than YouTube.
create view lisst as
select Track ,
 sum(case when most_playedon = 'Youtube' then stream else 0 end) as Total_youtube,
sum(case when most_playedon = 'Spotify' then stream else 0 end) as Total_spotify 
from spotifyy group by 1;
# we convert the code in view form we can just write the one line so that we can get same output.
select * from lisst;
------------------------------------------------------------------# Advanced level question
##1. Find the top 3 most-viewed tracks for each artist using window functions.
with Ranking_artist as
(select Artist ,Track, sum(Views)as Total_view ,
dense_rank() over(partition by Artist order by sum(Views) desc) as Ranks
from spotifyy 
group by Artist , Track order by 1,3 desc)
select * from Ranking_artist  where Ranks <= 3;

## 2. Write a query to find tracks where the liveness score is above the average.

select Track,Artist , avg(EnergyLiveness)as Avg_liveness from spotifyy where EnergyLiveness > 0.19 group by Track,Artist;


## 3. **Use a `WITH` clause to calculate the difference between the highest and lowest energy values for tracks in each album.**
with cte as
(select Album,max(Energy)as Max_energy,
min(Energy)as Lowest_energy from spotifyy
 group by 1) 
 select Album,
 Max_energy - Lowest_energy as Energy_Diff from cte order by  2 desc;
 















