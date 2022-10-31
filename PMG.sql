# Question #0 Select the first 2 rows from the marketing data​
select * from PMG.marketing_data
limit 2;

# Question #1 Generate a query to get the sum of the clicks of the marketing data​
select sum(clicks) as "total clicks" from PMG.marketing_data;

# Question #2 Generate a query to gather the sum of revenue by store_location from the store_revenue table
select store_location, sum(revenue) as loc_revenue
from PMG.store_revenue
group by store_location
order by store_location;

# Question #3 Merge these two datasets so we can see impressions, clicks, and revenue together by date and geo. 
#Please ensure all records from each table are accounted for.​
select *
from PMG.store_revenue left join PMG.marketing_data
on PMG.store_revenue.date = PMG.marketing_data.date
and right(store_location,2) = geo
UNION
select *
from PMG.store_revenue right join PMG.marketing_data
on PMG.store_revenue.date = PMG.marketing_data.date
and right(store_location,2) = geo;

# Question #4 In your opinion, what is the most efficient store and why?​
create temporary table PMG.temp as
	select PMG.marketing_data.date, brand_id, geo, impressions, clicks, revenue
	from PMG.store_revenue left join PMG.marketing_data
	on PMG.store_revenue.date = PMG.marketing_data.date
	and right(store_location,2) = geo
	UNION
	select PMG.marketing_data.date, brand_id, geo, impressions, clicks, revenue
	from PMG.store_revenue right join PMG.marketing_data
	on PMG.store_revenue.date = PMG.marketing_data.date
	and right(store_location,2) = geo;
select * from PMG.temp;
select brand_id, geo, (sum(clicks) / sum(impressions))*100 as ctr, (sum(revenue) / sum(impressions))*1000 as eCPM
from PMG.temp
group by brand_id, geo;
# The most efficient store is brand 2's store in CA which has 1.3736% click through rate (CTR) 
# and gets an effective earning of $10400.4165 for every 1000 ad impressions (eCPM). 
# In order to evaluate each store's efficiency, I grouped the brand id and store location 
# to calcuate the click through rate (CTR) and Effective Cost per Mille (eCPM) for each brand's store in different locations.
# For click through rate, the highest rate appears in MN but there is no corresponding MN's data in store_revenue dataset. 
# And the CTR rates are pretty similar for the rest of stores. 
# For Effective Cost per Mille (eCPM), the highest value is brand 2' store in CA which is much more higher than other stores.
# Thus, the most efficient store is brand 2's store in CA. 

# Question #5 (Challenge) Generate a query to rank in order the top 10 revenue producing states​
select *, rank() over (order by loc_revenue) as ranking
from (select store_location, sum(revenue) as loc_revenue
	  from PMG.store_revenue
	  group by store_location
	  limit 10) x;
