# PMG-SQL-Assessment
Hi guys! I am Jiaxin and here is my SQL Assessment for Data Analytics track. 

:point_right: [SQL File ](https://github.com/yjjjjxx/PMG-SQL-Assessment/blob/main/PMG.sql)

:point_down: **For our ease of reference**

**Question #0 Select the first 2 rows from the marketing data**

```mysql
select * from PMG.marketing_data
limit 2;
```

| date       | geo  | impressions | clicks |
| ---------- | ---- | ----------- | ------ |
| 2016-01-01 | TX   | 2532        | 45     |
| 2016-01-01 | CA   | 3425        | 63     |

**Question #1 Generate a query to get the sum of the clicks of the marketing data**

```mysql
select sum(clicks) as "total clicks" from PMG.marketing_data;
```

| total clicks |
| ------------ |
| 1792         |

**Question #2 Generate a query to gather the sum of revenue by store_location from the store_revenue table**

```mysql
select store_location, sum(revenue) as loc_revenue
from PMG.store_revenue
group by store_location
order by store_location;
```

| store_location   | loc_revenue |
| ---------------- | ----------- |
| United States-CA | 235237      |
| United States-NY | 51984       |
| United States-TX | 9629        |

**Question #3 Merge these two datasets so we can see impressions, clicks, and revenue together by date and geo** 

Please ensure all records from each table are accounted for.

```mysql
select *
from PMG.store_revenue left join PMG.marketing_data
on PMG.store_revenue.date = PMG.marketing_data.date
and right(store_location,2) = geo
UNION
select *
from PMG.store_revenue right join PMG.marketing_data
on PMG.store_revenue.date = PMG.marketing_data.date
and right(store_location,2) = geo;
```

| date       | brand_id | store_location   | revenue | date       | geo  | impressions | clicks |
| ---------- | -------- | ---------------- | ------- | ---------- | ---- | ----------- | ------ |
| 2016-01-01 | 1        | United States-CA | 100     | 2016-01-01 | CA   | 3425        | 63     |
| 2016-01-01 | 1        | United States-TX | 420     | 2016-01-01 | TX   | 2532        | 45     |
| 2016-01-01 | 1        | United States-NY | 142     | 2016-01-01 | NY   | 3532        | 25     |
| 2016-01-02 | 1        | United States-CA | 231     | 2016-01-02 | CA   | 1354        | 53     |
| 2016-01-02 | 1        | United States-TX | 2342    | 2016-01-02 | TX   | 3643        | 23     |
| 2016-01-02 | 1        | United States-NY | 232     | 2016-01-02 | NY   | 4643        | 85     |
| 2016-01-03 | 1        | United States-CA | 100     | 2016-01-03 | CA   | 5258        | 36     |
| 2016-01-03 | 1        | United States-TX | 420     | 2016-01-03 | TX   | 2353        | 57     |
| 2016-01-03 | 1        | United States-NY | 3245    | 2016-01-03 | NY   | 4735        | 63     |
| 2016-01-04 | 1        | United States-CA | 34      | 2016-01-04 | CA   | 7854        | 85     |
| 2016-01-04 | 1        | United States-TX | 3       | 2016-01-04 | TX   | 5783        | 47     |
| 2016-01-04 | 1        | United States-NY | 54      | 2016-01-04 | NY   | 4754        | 36     |
| 2016-01-05 | 1        | United States-CA | 45      | 2016-01-05 | CA   | 4678        | 73     |
| 2016-01-05 | 1        | United States-TX | 423     | 2016-01-05 | TX   | 2535        | 63     |
| 2016-01-05 | 1        | United States-NY | 234     | 2016-01-05 | NY   | 2364        | 33     |
| 2016-01-01 | 2        | United States-CA | 234     | 2016-01-01 | CA   | 3425        | 63     |
| 2016-01-01 | 2        | United States-TX | 234     | 2016-01-01 | TX   | 2532        | 45     |
| 2016-01-01 | 2        | United States-NY | 142     | 2016-01-01 | NY   | 3532        | 25     |
| 2016-01-02 | 2        | United States-CA | 234     | 2016-01-02 | CA   | 1354        | 53     |
| 2016-01-02 | 2        | United States-TX | 3423    | 2016-01-02 | TX   | 3643        | 23     |
| 2016-01-02 | 2        | United States-NY | 2342    | 2016-01-02 | NY   | 4643        | 85     |
| 2016-01-03 | 2        | United States-CA | 234234  | 2016-01-03 | CA   | 5258        | 36     |
| 2016-01-06 | 3        | United States-TX | 3       |            |      | 0           | 0      |
| 2016-01-03 | 2        | United States-TX | 3       | 2016-01-03 | TX   | 2353        | 57     |
| 2016-01-03 | 2        | United States-NY | 234     | 2016-01-03 | NY   | 4735        | 63     |
| 2016-01-04 | 2        | United States-CA | 2       | 2016-01-04 | CA   | 7854        | 85     |
| 2016-01-04 | 2        | United States-TX | 2354    | 2016-01-04 | TX   | 5783        | 47     |
| 2016-01-04 | 2        | United States-NY | 45235   | 2016-01-04 | NY   | 4754        | 36     |
| 2016-01-05 | 2        | United States-CA | 23      | 2016-01-05 | CA   | 4678        | 73     |
| 2016-01-05 | 2        | United States-TX | 4       | 2016-01-05 | TX   | 2535        | 63     |
| 2016-01-05 | 2        | United States-NY | 124     | 2016-01-05 | NY   | 2364        | 33     |
| NULL       | NULL     | NULL             | NULL    | 2016-01-01 | MN   | 1342        | 784    |
| NULL       | NULL     | NULL             | NULL    | 2016-01-02 | MN   | 2366        | 85     |
| NULL       | NULL     | NULL             | NULL    | 2016-01-03 | MN   | 5783        | 87     |
| NULL       | NULL     | NULL             | NULL    | 2016-01-04 | MN   | 9345        | 24     |
| NULL       | NULL     | NULL             | NULL    | 2016-01-05 | MN   | 3452        | 25     |

**Question #4 In your opinion, what is the most efficient store and why?**

```mysql
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
```

| brand_id | geo  | ctr    | eCPM       |
| -------- | ---- | ------ | ---------- |
| 1        | CA   | 1.3736 | 22.5974    |
| 1        | TX   | 1.395  | 214.1755   |
| 1        | NY   | 1.2083 | 195.0769   |
| 2        | CA   | 1.3736 | 10400.4165 |
| 2        | TX   | 1.395  | 357.2361   |
| 2        | NY   | 1.2083 | 2400.4893  |
| 3        | NULL | NULL   | NULL       |
| NULL     | MN   | 4.5092 | NULL       |

The most efficient store is brand 2's store in CA which has 1.3736% click through rate (CTR) and gets an effective earning of $10400.4165 for every 1000 ad impressions (eCPM). In order to evaluate each store's efficiency, I grouped the brand id and store location to calcuate the click through rate (CTR) and Effective Cost per Mille (eCPM) for each brand's store in different locations. For click through rate, the highest rate appears in MN but there is no corresponding MN's data in store_revenue dataset. And the CTR rates are pretty similar for the rest of stores. For Effective Cost per Mille (eCPM), the highest value is brand 2' store in CA which is much more higher than other stores. Thus, the most efficient store is brand 2's store in CA. 

**Question #5 (Challenge) Generate a query to rank in order the top 10 revenue producing states**

```mysql
select *, rank() over (order by loc_revenue desc) as ranking
from (select store_location, sum(revenue) as loc_revenue
	  from PMG.store_revenue
	  group by store_location
	  limit 10) x;
```

| store_location   | loc_revenue | ranking |
| ---------------- | ----------- | ------- |
| United States-CA | 235237      | 1       |
| United States-NY | 51984       | 2       |
| United States-TX | 9629        | 3       |
