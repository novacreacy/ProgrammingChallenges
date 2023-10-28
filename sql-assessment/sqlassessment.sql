/* PMG Assesssment */

/* 1. Write a query to get the sum of impressions by day. */ 
SELECT date, sum(impressions) 
FROM marketing_performance 
GROUP BY date 
ORDER BY date desc; 

/* 2. Write a query to get the top three revenue-generating states in order of best to worst. 
How much revenue did the third best state generate? */ 
select state, sum(revenue) as totalrevenue
from website_revenue 
group by state 
order by totalrevenue desc 
LIMIT 3; 
/* The third best state generated $37,577 in revenue. */

/* 3. Write a query that shows total cost, impressions, clicks, and revenue of each campaign.  
Make sure to include the campaign name in the output. */ 
create table revagg4 as
SELECT campaign_id,  sum(revenue) as totalrevenue 
from website_revenue
group by campaign_id;

create table marketingagg as
select a.id, a.name, sum(b.cost) as totalcost, sum(b.impressions) as totalimpressions, sum(b.clicks) as totalclicks
from campaign_info a 
LEFT JOIN marketing_performance b 
on a.id = b.campaign_id 
group by id, name; 

select a.*, b.totalrevenue
from marketingagg a
left join revagg4 b
on a.id = b.campaign_id;

/* 4. Write a query to get the number of conversions of Campaign5 by state. 
Which state generated the most conversions for this campaign? */ 
select sum(conversions) as totalconversions, geo as state 
from marketing_performance  
where campaign_id = 99058240 
group by geo 
ORDER BY sum(conversions) desc; 
/* GA generated the most conversions for this campaign */ 


/* 5. In your opinion, which campaign was the most efficient, and why? */ 
/* I believe that Campaign5 was the most efficient, because it has the lowest cost to revenue ratio of 1%.  
For everyone $1 the company spent on the campaign, they saw a $100 return in revenue. */


/* 6. Write a query that showcases the best day of the week (e.g., Sunday, Monday, Tuesday, etc.) to run ads. */
select DATE_FORMAT(date, "%W"), sum(clicks) as totalclicks, sum(conversions) as totalconversions
from marketing_performance   
group by date
ORDER BY totalconversions desc;


