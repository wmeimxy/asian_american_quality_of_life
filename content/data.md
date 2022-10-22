---
date: 2016-05-05T21:48:51-07:00
title: Data
featured_image: 'images/image2.png'
description: 'About Our Data and Data Cleaning'
---
Cleaned NAAS dataset: https://docs.google.com/spreadsheets/d/1-Gzke_Bwr_kXvb18G_k98h_HGZAo6Qm8uQfQzuRMTE8/edit?usp=sharing

Cleaned AAQoL dataset: https://docs.google.com/spreadsheets/d/1x0KqifZAjVtrV_qkoYiq5h-u1H6P7mUUEA9ZHlReVqI/edit?usp=sharing

Cleaned final dataset: https://docs.google.com/spreadsheets/d/1aD3xVE6X3Bx_Kf8upx1hHnBRqJAiWaa_GUWFM6nmPwM/edit?usp=sharing

Dataset #1: Final Report of the Asian American Quality of Life (AAQoL)
Our first dataset is titled the ‘Final Report of the Asian American Quality of Life’ (AAQoL) and was retrieved from the official City of Austin open data portal: https://data.austintexas.gov/City-Government/Final-Report-of-the-Asian-American-Quality-of-Life/hc5t-p62z/data. The data contains 231 variables from 2,610 subjects. The included variables assess demographics such as language, marital status, ethnicity, educational attainment, and employment status. The data also includes measures to assess mental health, perceived quality of life, and medical history.

Dataset #2: The National Asian American Survey (NAAS) Pre-Election Survey
Our second dataset is The National Asian American Survey (NAAS) Pre-election Survey, [United States], 2016 (ICPSR 37024). The dataset was retrieved https://www.icpsr.umich.edu/web/RCMD/studies/31481/datadocumentation#, The Resource Center for Minority Data website. This data contains 316 total variables and 4,787 observations. Variables include demographic data and questionnaire responses regarding political opinions and views of Asian Americans prior to the 2016 Presidential election.

These data were gathered in response to the rapidly growing Asian American population, in order to better understand the social and health needs of the Asian American population and the unique challenges they face. 

## Data Cleaning

During the data cleaning process, we began by selecting which variables from each that we found most relevant to our project. For both datasets, we selected columns that specified basic demographic information, including:
Age, Gender, Ethnicity, Marital Status, Education Completed, Religion, Employment Status, Occupation, Income
Aside from basic demographic data, our cleaned AALoQ dataset includes: 
US Born, Primary Language, English Speaking, English Difficulties, Familiarity with America, Familiarity with Ethnic Origin, Discrimination, Present Health, Present Mental Health, Hypertension, Health Insurance, Transportation (Medical), Satisfaction With Housing, Housing, Community Shares Values, Close-knit Community, Religious Importance, Togetherness, Successful Family, See Friends, See Family, Helpful Family, Helpful Friends, Disappointment, Satisfied With Life 1,  Quality of Life, Social Networks, Language, Duration of Residency

We then used rename() to rename each column using underscores (_), for example,  ‘Marital Status’ became ‘Marital_Status’. We also used mutate() so that the cleaned dataset would only show data in the state of Texas. 

For our cleaned NAAS dataset, we have some additional columns concerning political attitudes and voting habits: 

RACEETH, RSTATE, EDUC3, S7, S8, S9, RACE, Q1_2, Q1_3A, CITIZEN, Q2_1A, Q2_1B, Q2_1D, Q2_2A, Q2_2D, Q2_3A, Q3_3A, REGISTERED, NOTREGISTERED, NONELIG, Q4_2, Q4_5A , Q4_5B, Q4_7, Q4_10A, Q4_11A, Q4_11B, Q4_11D, Q4_11E, Q5_1_01, Q5_1_02, Q5_1_03, Q5_1_05, Q5_1_08, Q5_2C, Q5_10, Q6_1D, Q6_5_5, Q6_5_3, Q8_6, Q8_701, Q8_901, Q8_15, Q8_18, Q8_22

We renamed each of these variables using the researchers’ codebook as a reference, for ex. RACEETH became Ethnicity; EDUC3 became Education. We then filtered this dataset so that the race was Asian American, and added an Age column using mutate(), where Age = 2016 - Birth_Yr. We also filtered out any Birth_Yr that was 9999. 

In order to successfully join the two datasets, matching formatting in both datasets was required for the variables we would join on. Thus, we performed the following transformations: 

We had to clean the Education, Income, Employment_Status, and Education_Completed columns in AAQoL so that it would match the format of NAAS. 

We had to then also clean the Income, Religion and Marital_Status of NAAS so that it would align with AAQoL. We also had to clean the AAQoL US_Born column so as to make it more organized. 

In the NAAS dataset, each response was preceded by a number, so we removed all strings containing numbers for those responses.

Since the two datasets describe the life of the Asian American population, with AALoQ representing Asian Americans in Texas and NAAS representing a national sample, we incorporated the AALoQ dataset into the NAAS dataset so that we could compare how Asian American behavior across the country. We joined the two cleaned datasets with the following variables: 
Ethnicity, Race, State, Education, Education_Completed, Gender, US_Born, Religion, Marital_Status, Age, clean_Income, Employment_Status 

We used the tidyverse package to clean our data. 

Here are the variables we found most significant in carrying out our EDA: 

* Ban_Muslim - whether the subject supports or opposes the U.S. Muslim ban 
* Chance_Vote - whether the subject plans to vote in the then-upcoming 2016 election 
* clean_Income - the subject’s income level
* Clinton_Impres - whether the subject has a favorable or unfavorable opinion of Hillary Clinton 
* Contact_Rep - whether the subject has contacted a local representative 
* Duration - how many years the subject has lived in the United States 
* Education - highest level of education obtained by the subject 
* Employment_Status - employment status of the subject
* Ethnicity - ethnicity of the subject 
* Gender - gender of the subject 
* Marital_Status - marital status of the subject 
* Mental_Health - mental health quality of the subject 
* Party_Voting - subject’s preferred political party 
* Politic_Donate - whether the subject has donated to political campaigns 
* Protest_Rally - whether the subject has attended a protest 
* Quality_of_Life - quality of life of the subject (ranked 1-10) 
* Religion - religion of the subject 
* State - state in which the subject resides 
* Syrian_Refugee - whether the subject supports or opposes Syrian Refugees entering the U.S. 
* Topic_Important - which political topic is most important to the subject 
* Trump_Impres - whether the subject has a favorable or unfavorable opinion of Donald Trump 

To view our data cleaning code, please visit: https://docs.google.com/document/d/11FaDx0SnMya2sKIiRUg4rrkVNyu4jCPchbdqdCILJ44/edit?usp=sharing
