---
title: Very Early EDA
author: WHYM
date: '2020-10-09'
slug: ver-early-eda
categories: []
tags: []
description: 'Very Early EDA'
featured_image: ''
---
The dataset we are using to perform data analysis talks about life quality for Asian Americans. We encountered no issue loading the data. The data contains 231 columns from 2,610 observations, including education level, income level, employment status, measure of mental well beings, social support, and quality of life scale from 1 -10 etc. After our initial assessment of the data, we noticed that we might need to collapse some columns into one. For example, each employment status is currently listed as a separate variable. For the purpose of our analysis, it would make sense to combine these columns into one ‘employment status’ column and dummy code the different statuses, such that “1=unemployed, 2=part time, 3=full time,...etc”. We will likely need to follow similar steps for other survey questions. 