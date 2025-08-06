# Google Data Analytics Capstone
Capstone Project for the Google Data Analytics Certificate. Analyzes 2019 Cyclistic trip data to compare differences in Customer and Subscriber ride behavior. Involves data cleaning, SQL queries, and Tableau visualizations to uncover trends and support data-driven marketing strategy recommendations.
# Introduction
I have recently completed the Google Data Analytics Professional Certificate, learning about the data analysis process and the basics of popular data analysis tools. The six steps of the data analysis process taught in the course are Ask, Prepare, Process, Analyze, Share, and Act. I learned the basics of data analysis tools such as spreadsheets, SQL, R, and Tableau to work through the data analysis process. At the end of the course, we are assigned a case study, where I am a junior data analyst for the marketing team at the fictional company, Cyclistic. 
# Background
Cyclistic is bike sharing program with 5,824 bicycles and 692 docking stations throughout Chicago, allowing consumers to rent bikes at any station and return them to any other location, anytime. In the past, Cyclistic’s marketing strategy included building brand awareness and trying to appeal to as many consumers as possible. This has led to a pricing strategy of single-ride passes, full-day passes, and annual memberships. While this flexibility in purchase options allows us to attract more customers, annual members is what will drive our future growth. This is because our financial analysts have found that annual members (Subscribers) are more profitable than casual members (Customers). 

Because of this, our focus in this case study will be on differences in how annual and casual members use Cyclistic. Any recommendations must be approved by the executive team.
# Ask
Lily Moreno has made the goal clear: “Design marketing strategies aimed at converting casual riders into annual members. In order to do that, however, the team needs to better understand how annual members and casual riders differ, why casual riders would buy a membership, and how digital media could affect their marketing tactics. Moreno and her team are interested in analyzing the Cyclistic historical bike trip data to identify trends.”
We have been given three questions that are being used to guide the future marketing campaign,

   •	How do annual member and casual riders use Cyclistic bikes differently?

   •	Why would casual riders buy cyclistic annual memberships?

   •	How can cyclistic use digital media to influence casual riders to become members?

I have been assigned the task of: “How do annual members and casual riders use Cyclistic bikes differently?”
# Prepare
The data sources used in this analysis are from Cyclistic’s historical trip data. Since we are not using R, we will download 12 months of Cyclistic trip data, from Q1, Q2, Q3, Q4 of 2019. Cyclistic is a fictional company, so the data has been made available by Motivate International Inc. with the below license. 

•	https://divvybikes.com/data-license-agreement

•	https://divvy-tripdata.s3.amazonaws.com/index.html

This data is publicly available with limitations. Data-privacy issues do not allow for us to analyze riders’ identifiable personal information. This does hinder a bit of our analysis, for example, we won’t be able to connect credit card information to single-pass purchases to determine if this is the customers first purchase or if they have previously purchased a pass.  
# Process
For this case study, I will be using SQL for data cleaning and preparation, and Tableau for data visualizations. These tools have high data processing capacities, which makes them ideal for the data sets used in this analysis, as they contain a total of 3,818,004 records.

To ensure that the data is clean and ready for analysis, I will run numerous SQL queries on BigQuery:

1.	Check for nulls in each column of the dataset, the only columns with null values are gender and birthyear.

   <img width="253" height="56" alt="Image" src="https://github.com/user-attachments/assets/39e03e1f-3b3c-4b06-adf0-7c48c018cd85" />

2.	After finding null values, I will see if one usertype has a high amount of null values. I find that most nulls are in the “Customer” usertype. I will leave records with null values but will not do gender or birthyear analysis on either usertype to avoid skewed data.

   <img width="449" height="84" alt="Image" src="https://github.com/user-attachments/assets/55bec800-672c-4d9d-9eee-07cfc52722a7" />

3.	Check for duplicate rows, no duplicate rows returned.
4.	Rename columns in Q2 dataset to match Q1, Q3, and Q4 datasets before combining all into one table.
5.	Combine datasets Q1, Q2, Q3, Q4 into one table.
6.	Verify total record count for combined table, returning 3,818,004 records.
7.	Add day_of_week column into combined table. 
8.	Populate day_of_week column using start_time column and extracting.

These steps help to ensure that our dataset is ready for analysis. Now, we are ready to begin exploring and analyzing the data.
# Analyze
It is important to remember the goal of our analysis, how do annual members (subscribers) and casual riders (customers) use Cyclistic bikes differently?

Lets look at the total trips taken per day and by month for both usertypes.

<img width="1842" height="817" alt="Image" src="https://github.com/user-attachments/assets/c41acb05-b3f1-4509-8fce-9bbfa7f6e281" />
<img width="1602" height="790" alt="Image" src="https://github.com/user-attachments/assets/9ccaa842-684e-4632-a84f-c98984783a45" />
Looking at the per day chart, we can see that subscribers take many more trips per day than customers, which is expected given that subscribers outnumber customers 2,937,367 to 880,637 but that is not the main takeaway. The main takeaway is the weekend activity from both groups relative to their weekday activity. We can see that the total trips taken by subscribers drops roughly 43% from weekdays to weekends, while customer total trips increases roughly 88% from weekdays to weekends.

Next, we can look at the per month chart.    

Looking at the chart, we can see that both groups follow a similar trend, with high usage in the spring and summer months, and a significant decrease in fall and winter months. Given Cyclistic operates in Chicago, this is an expected trend because of weather patterns in Chicago.

With our first two charts, we could start to infer that the main difference in how customers and subscribers use cyclistic bikes is the purpose behind the usage. We see customers usage increasing on weekends, while subscribers usage decreases. Also, while both groups usage decrease in winter months, the decrease for subscribers is significantly less, indicating that subscribers may use Cyclistic for work or transportation, while customers use Cyclistic for leisure and activity.

The next vizualization 
