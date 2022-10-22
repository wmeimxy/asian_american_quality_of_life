library(tidyverse)

AALoQ_full <- read_csv(here::here("dataset", "Final_Report_of_the_Asian_American_Quality_of_Life__AAQoL_ copy.csv"), col_types=cols('Survey ID' = col_double(), Age=col_double(), 'Education Completed' = col_double(), 'Household Size' = col_double(), Grandparent = col_double(), 'Other Relative' = col_double(), Other=col_double(), 'Self Employed Full Time' = col_double(), 'Self Employed Part Time' = col_double(), Disabled = col_double(),Unemployed = col_double(),'Other Employement' = col_double(),'Achieving Ends Meet' = col_double(),'Duration of Residency' = col_double(),'Primary Language' = col_double(), Discrimination = col_double(),'Hygiene Assistance' = col_double(),Smoking = col_double(),Drinking = col_double(), 'Regular Exercise' = col_double()))
##read the AALoQ original data set

AALoQ_clean <- AALoQ_full %>% 
  select(Age, Gender, Ethnicity,'Marital Status', 'Education Completed', Religion, 'Full Time Employment', 'Part Time Employment', 'Self Employed Part Time', 'Self Employed Full Time', Student, Homemaker, Disabled, Retired, Occupation, Income, 'US Born','Primary Language', 'English Speaking', 'English Difficulties', 'Familiarity with America', 'Familiarity with Ethnic Origin', Discrimination, 'Present Health', 'Present Mental Health', Hypertension, 'Health Insurance', 'Transportation (Medical)', 'Satisfaction With Housing.', Housing, 'Community Shares Values', 'Close-knit Community', 'Religious Importance', Togetherness, 'Successful Family', 'See Friends', 'See Family', 'Helpful Family', 'Helpful Friends', Disappointment, 'Satisfied With Life 1',  'Quality of Life', 'Social Networks', Language, 'Duration of Residency') %>% 
  rename(Marital_Status = 'Marital Status', Education_Completed='Education Completed', US_Born= 'US Born', Primary_Language='Primary Language', English_Speaking = 'English Speaking', English_Difficulties = 'English Difficulties', Familiarity_with_America = 'Familiarity with America', Familiarity_with_Ethnic_Origin ='Familiarity with Ethnic Origin', Health = 'Present Health',Mental_Health = 'Present Mental Health', Health_Insurance = 'Health Insurance', Medical_Transport = 'Transportation (Medical)', Sat_with_Housing = 'Satisfaction With Housing.', Com_Shares_Values ='Community Shares Values', Close_knit_Com ='Close-knit Community', Religious_Importance ='Religious Importance',Successful_Family ='Successful Family', See_Friends ='See Friends', See_Family ='See Family', Helpful_Family ='Helpful Family', Helpful_Friends ='Helpful Friends', Sat_with_Life ='Satisfied With Life 1',  Quality_of_Life ='Quality of Life', Social_Networks ='Social Networks', Native_Language=Language, Duration='Duration of Residency',
         Full_Time_Employment='Full Time Employment', Part_Time_Employment='Part Time Employment', Self_Employed_Part_Time= 'Self Employed Part Time', Self_Employed_Full_Time='Self Employed Full Time') %>%
  mutate(emp= paste(Full_Time_Employment, Part_Time_Employment,Self_Employed_Part_Time,Self_Employed_Full_Time, Student, Disabled,Homemaker, Retired, sep="_")) %>% 
  mutate(Employment_Status = str_remove_all(emp, "[NA0_]")) %>% 
  subset(select= -c(emp)) %>% 
  mutate(State="TX")
##change names of columns
##combine employment columns into a single employment status column

library(tidyverse)

load(here::here("dataset", "37024-0001-Data.rda"))
NAAS_full <- da37024.0001
NAAS_clean <- NAAS_full %>% select(RACEETH, RSTATE, EDUC3, S7, S8, S9, RACE, Q1_2, Q1_3A, CITIZEN, Q2_1A, Q2_1B, Q2_1D, 
                                   Q2_2A, Q2_2D, Q2_3A, Q3_3A, REGISTERED, NOTREGISTERED, NONELIG, Q4_2, Q4_5A , Q4_5B, Q4_7, 
                                   Q4_10A, Q4_11A, Q4_11B, Q4_11D, Q4_11E, Q5_1_01, Q5_1_02, Q5_1_03, Q5_1_05, Q5_1_08, Q5_2C, 
                                   Q5_10, Q6_1D, Q6_5_5, Q6_5_3, Q8_6, Q8_701, Q8_901, Q8_15, Q8_18, Q8_22) %>% 
  rename(Ethnicity = 'RACEETH', State = 'RSTATE', Education = 'EDUC3', Gender = 'S7', Highest_Educ = 'S8', US_Born = 'S9', Race = 'RACE', US_Born_Father = 'Q1_2', Birth_Country = 'Q1_3A', Citizenship = 'CITIZEN', Career_Success = 'Q2_1A', Religion_Importance = 'Q2_1B', Help_Other = 'Q2_1D', 
        Race_Id = 'Q2_2A', American_Id = 'Q2_2D', Leader_Qual = 'Q2_3A', Info_Source = 'Q3_3A', Registered_Vote = 'REGISTERED', Not_Registered = 'NOTREGISTERED', Voter_NotElig = 'NONELIG', Chance_Vote ='Q4_2', Candidate = 'Q4_5A', Candidate_Strength = 'Q4_5B', Candidate_Voted = 'Q4_7', 
        Party_Voting ='Q4_10A', Repub_Impres = 'Q4_11A', Dem_Impres = 'Q4_11B', Trump_Impres = 'Q4_11D', Clinton_Impres = 'Q4_11E', Politic_Disc = 'Q5_1_01', Politic_Donate = 'Q5_1_02', Contact_Rep = 'Q5_1_03', Protest_Rally = 'Q5_1_05', Public_Meet = 'Q5_1_08', Value_Similarity = 'Q5_2C', 
        Religion = 'Q5_10', Topic_Important = 'Q6_1D', Ban_Muslim = 'Q6_5_5', Syrian_Refugee = 'Q6_5_3', Marital_Status ='Q8_6', Partner_Race = 'Q8_701', Employment = 'Q8_901', Income = 'Q8_15', Birth_Yr ='Q8_18', English_Read= 'Q8_22') %>%
  filter(Race == '(1) ASIAN AMERICAN') %>% 
  filter(Birth_Yr != "9999") %>%
  mutate(Age = 2016 - Birth_Yr) 

##clean numbers before columns
NAAS_clean$Ethnicity<-str_remove_all(NAAS_clean$Ethnicity, "[1234567890()]")
NAAS_clean$Ethnicity<- substring(NAAS_clean$Ethnicity, 2)
NAAS_clean$Education<-str_remove_all(NAAS_clean$Education, "[1234567890()]")
NAAS_clean$Education<- substring(NAAS_clean$Education, 2)
NAAS_clean$Party_Voting<-str_remove_all(NAAS_clean$Party_Voting, "[1234567890()]")
NAAS_clean$Party_Voting<- substring(NAAS_clean$Party_Voting, 2)
NAAS_clean$Ban_Muslim<-str_remove_all(NAAS_clean$Ban_Muslim, "[1234567890()]")
NAAS_clean$Ban_Muslim<- substring(NAAS_clean$Ban_Muslim, 2)
NAAS_clean$Citizenship<-str_remove_all(NAAS_clean$Citizenship, "[1234567890()]")
NAAS_clean$Citizenship<- substring(NAAS_clean$Citizenship, 2)
NAAS_clean$Religion<-str_remove_all(NAAS_clean$Religion, "[1234567890()]")
NAAS_clean$Religion<- substring(NAAS_clean$Religion, 2)
NAAS_clean$Race<-str_remove_all(NAAS_clean$Race, "[1234567890()]")
NAAS_clean$Race<- substring(NAAS_clean$Race, 2)
NAAS_clean$Gender<-str_remove_all(NAAS_clean$Gender, "[1234567890()]")
NAAS_clean$Gender<- substring(NAAS_clean$Gender, 2)
NAAS_clean$Highest_Educ<-str_remove_all(NAAS_clean$Highest_Educ, "[1234567890()]")
NAAS_clean$Highest_Educ<- substring(NAAS_clean$Highest_Educ, 2)
NAAS_clean$US_Born<-str_remove_all(NAAS_clean$US_Born, "[1234567890()]")
NAAS_clean$US_Born<- substring(NAAS_clean$US_Born, 2)
NAAS_clean$Syrian_Refugee<-str_remove_all(NAAS_clean$Syrian_Refugee, "[1234567890()]")
NAAS_clean$Syrian_Refugee<- substring(NAAS_clean$Syrian_Refugee, 2)
NAAS_clean$Birth_Country<-str_remove_all(NAAS_clean$Birth_Country, "[1234567890()]")
NAAS_clean$Birth_Country<- substring(NAAS_clean$Birth_Country, 2)
NAAS_clean$US_Born_Father<-str_remove_all(NAAS_clean$US_Born_Father, "[1234567890()]")
NAAS_clean$US_Born_Father<- substring(NAAS_clean$US_Born_Father, 2)
NAAS_clean$Career_Success<-str_remove_all(NAAS_clean$Career_Success, "[1234567890()]")
NAAS_clean$Career_Success<- substring(NAAS_clean$Career_Success, 2)
NAAS_clean$Religion_Importance<-str_remove_all(NAAS_clean$Religion_Importance, "[1234567890()]")
NAAS_clean$Religion_Importance<- substring(NAAS_clean$Religion_Importance, 2)
NAAS_clean$Help_Other<-str_remove_all(NAAS_clean$Help_Other, "[1234567890()]")
NAAS_clean$Help_Other<- substring(NAAS_clean$Help_Other, 2)
NAAS_clean$Race_Id<-str_remove_all(NAAS_clean$Race_Id, "[1234567890()]")
NAAS_clean$Race_Id<- substring(NAAS_clean$Race_Id, 2)
NAAS_clean$American_Id<-str_remove_all(NAAS_clean$American_Id, "[1234567890()]")
NAAS_clean$American_Id<- substring(NAAS_clean$American_Id, 2)
NAAS_clean$Leader_Qual<-str_remove_all(NAAS_clean$Leader_Qual, "[1234567890()]")
NAAS_clean$Leader_Qual<- substring(NAAS_clean$Leader_Qual, 2)
NAAS_clean$Info_Source<-str_remove_all(NAAS_clean$Info_Source, "[1234567890()]")
NAAS_clean$Info_Source<- substring(NAAS_clean$Info_Source, 2)
NAAS_clean$Registered_Vote<-str_remove_all(NAAS_clean$Registered_Vote, "[1234567890()]")
NAAS_clean$Registered_Vote<- substring(NAAS_clean$Registered_Vote, 2)
NAAS_clean$Not_Registered<-str_remove_all(NAAS_clean$Not_Registered, "[1234567890()]")
NAAS_clean$Not_Registered<- substring(NAAS_clean$Not_Registered, 2)
NAAS_clean$Voter_NotElig<-str_remove_all(NAAS_clean$Voter_NotElig, "[1234567890()]")
NAAS_clean$Voter_NotElig<- substring(NAAS_clean$Voter_NotElig, 2)
NAAS_clean$Chance_Vote<-str_remove_all(NAAS_clean$Chance_Vote, "[1234567890()]")
NAAS_clean$Chance_Vote<- substring(NAAS_clean$Chance_Vote, 2)
NAAS_clean$Candidate<-str_remove_all(NAAS_clean$Candidate, "[1234567890()]")
NAAS_clean$Candidate<- substring(NAAS_clean$Candidate, 2)
NAAS_clean$Candidate_Strength<-str_remove_all(NAAS_clean$Candidate_Strength, "[1234567890()]")
NAAS_clean$Candidate_Strength<- substring(NAAS_clean$Candidate_Strength, 2)
NAAS_clean$Candidate_Voted<-str_remove_all(NAAS_clean$Candidate_Voted, "[1234567890()]")
NAAS_clean$Candidate_Voted<- substring(NAAS_clean$Candidate_Voted, 2)
NAAS_clean$Repub_Impres<-str_remove_all(NAAS_clean$Repub_Impres, "[1234567890()]")
NAAS_clean$Repub_Impres<- substring(NAAS_clean$Repub_Impres, 2)
NAAS_clean$Dem_Impres<-str_remove_all(NAAS_clean$Dem_Impres, "[1234567890()]")
NAAS_clean$Dem_Impres<- substring(NAAS_clean$Dem_Impres, 2)
NAAS_clean$Trump_Impres<-str_remove_all(NAAS_clean$Trump_Impres, "[1234567890()]")
NAAS_clean$TrumpImpres<- substring(NAAS_clean$Trump_Impres, 2)
NAAS_clean$Clinton_Impres<-str_remove_all(NAAS_clean$Clinton_Impres, "[1234567890()]")
NAAS_clean$Clinton_Impres<- substring(NAAS_clean$Clinton_Impres, 2)
NAAS_clean$Politic_Disc<-str_remove_all(NAAS_clean$Politic_Disc, "[1234567890()]")
NAAS_clean$Politic_Disc<- substring(NAAS_clean$Politic_Disc, 2)
NAAS_clean$Politic_Donate<-str_remove_all(NAAS_clean$Politic_Donate, "[1234567890()]")
NAAS_clean$Politic_Donate<- substring(NAAS_clean$Politic_Donate, 2)
NAAS_clean$Contact_Rep<-str_remove_all(NAAS_clean$Contact_Rep, "[1234567890()]")
NAAS_clean$Contact_Rep<- substring(NAAS_clean$Contact_Rep, 2)
NAAS_clean$Protest_Rally<-str_remove_all(NAAS_clean$Protest_Rally, "[1234567890()]")
NAAS_clean$Protest_Rally<- substring(NAAS_clean$Protest_Rally, 2)
NAAS_clean$Public_Meet<-str_remove_all(NAAS_clean$Public_Meet, "[1234567890()]")
NAAS_clean$Public_Meet<- substring(NAAS_clean$Public_Meet, 2)
NAAS_clean$Value_Similarity<-str_remove_all(NAAS_clean$Value_Similarity, "[1234567890()]")
NAAS_clean$Value_Similarity<- substring(NAAS_clean$Value_Similarity, 2)
NAAS_clean$Topic_Important<-str_remove_all(NAAS_clean$Topic_Important, "[1234567890()]")
NAAS_clean$Topic_Important<- substring(NAAS_clean$Topic_Important, 2)
NAAS_clean$Marital_Status<-str_remove_all(NAAS_clean$Marital_Status, "[1234567890()]")
NAAS_clean$Marital_Status<- substring(NAAS_clean$Marital_Status, 2)
NAAS_clean$Income<- substring(NAAS_clean$Income, 5)
NAAS_clean$Partner_Race<-str_remove_all(NAAS_clean$Partner_Race, "[1234567890()]")
NAAS_clean$Partner_Race<- substring(NAAS_clean$Partner_Race, 2)
NAAS_clean$Employment<-str_remove_all(NAAS_clean$Employment, "[1234567890()]")
NAAS_clean$Employment<- substring(NAAS_clean$Employment, 2)
NAAS_clean$English_Read<-str_remove_all(NAAS_clean$English_Read, "[1234567890()]")
NAAS_clean$English_Read<- substring(NAAS_clean$English_Read, 2)

##clean ethnicity column
NAAS_clean$Ethnicity <- str_to_title(NAAS_clean$Ethnicity)
NAAS_clean$Ethnicity <- str_replace_all(NAAS_clean$Ethnicity, "Asnindian", "Asian Indian")
##clean education column in AALoQ
AALoQ_clean <- AALoQ_clean %>% mutate(Education = "")
for(i in seq_along(AALoQ_clean$Education)){
  if(is.na(AALoQ_clean$Education_Completed[[i]])){
    AALoQ_clean$Education[[i]] = NA}
  else if(AALoQ_clean$Education_Completed[[i]] < 12) 
  {AALoQ_clean$Education[[i]] = "Less than HS"}
  else if(AALoQ_clean$Education_Completed[[i]]== 12 )
  {AALoQ_clean$Education[[i]] = "HS Graduate"}
  else if(AALoQ_clean$Education_Completed[[i]] >= 13){
    AALoQ_clean$Education[[i]] = "College or Higher"}
}
##clean highest degree column in AALoQ
for(i in seq_along(AALoQ_clean$Education_Completed)){
  if(!is.na(AALoQ_clean$Education_Completed[[i]])){
    if(AALoQ_clean$Education_Completed[[i]] >= 9 & AALoQ_clean$Education_Completed[[i]] < 12 )
    {AALoQ_clean$Education_Completed[[i]] = "Some schooling, no high school degree / GED"}
    else if(AALoQ_clean$Education_Completed[[i]] ==12)
    {AALoQ_clean$Education_Completed[[i]] = "High school degree / GED"}
    else if(AALoQ_clean$Education_Completed[[i]] >= 13 & AALoQ_clean$Education_Completed[[i]] < 16)
    {AALoQ_clean$Education_Completed[[i]] = "Some college, but no degree"}
    else if(AALoQ_clean$Education_Completed[[i]] == 16)
    {AALoQ_clean$Education_Completed[[i]] = "College degree or Bachelor's degree"}
    else if(AALoQ_clean$Education_Completed[[i]] >= 17)
    {AALoQ_clean$Education_Completed[[i]] = "Graduate or Professional degree "}
    else{
      AALoQ_clean$Education_Completed[[i]] = "No schooling completed"
    }
  }
}
##income for AALoQ
AALoQ_clean <- AALoQ_clean %>% mutate(clean_Income = NA)
for(i in seq_along(AALoQ_clean$Income)){
  if(!is.na(AALoQ_clean$Income[[i]])){
    if(identical(AALoQ_clean$Income[[i]], "$0 - $9,999") | identical(AALoQ_clean$Income[[i]], "$10,000 - $19,999")){
      AALoQ_clean$clean_Income[[i]] = "$0 to $20,000"
    }else if(identical(AALoQ_clean$Income[[i]], "$20,000 - $29,999")|identical(AALoQ_clean$Income[[i]], "$30,000 - $39,999")|identical(AALoQ_clean$Income[[i]], "$40,000 - $49,999")){
      AALoQ_clean$clean_Income[[i]] = "$20,000 to $50,000"
    }else if(identical(AALoQ_clean$Income[[i]], "$50,000 - $59,999")|identical(AALoQ_clean$Income[[i]], "$60,000 - $69,999")){
      AALoQ_clean$clean_Income[[i]] = "$50,000 to $70,000"
    }else if(identical(AALoQ_clean$Income[[i]], "$70,000 and over")){
      AALoQ_clean$clean_Income[[i]] = "$70,000 and over"
    }
  }
}

##income for NAAS
NAAS_clean <- NAAS_clean %>% mutate(clean_Income = NA)
for(i in seq_along(NAAS_clean$Income)){
  if(!is.na(NAAS_clean$Income[[i]])){
    if(identical(NAAS_clean$Income[[i]], "Up to $20,000")){
      NAAS_clean$clean_Income[[i]] = "$0 to $20,000"
    }else if(identical(NAAS_clean$Income[[i]], "$20,000 to $50,000")){
      NAAS_clean$clean_Income[[i]] = "$20,000 to $50,000"
    }else if(identical(NAAS_clean$Income[[i]], "$50,000 to $75,000")){
      NAAS_clean$clean_Income[[i]] = "$50,000 to $70,000"
    }else{
      NAAS_clean$clean_Income[[i]] = "$70,000 and over"
    }
  }
}

##marital_status for NAAS
for(i in seq_along(NAAS_clean$Marital_Status)){
  if(!is.na(NAAS_clean$Marital_Status[[i]])){
    if(identical(NAAS_clean$Marital_Status[[i]], "Widowed") | identical(NAAS_clean$Marital_Status[[i]], "Divorced") | identical(NAAS_clean$Marital_Status[[i]], "Never married")){
      NAAS_clean$Marital_Status[[i]] = "Single"
    }else if(identical(NAAS_clean$Marital_Status[[i]], "Married / living as married")){
      NAAS_clean$Marital_Status[[i]] = "Married"
    }else{
      NAAS_clean$Marital_Status[[i]] = "Other" }
  }
}
##clean AALoQ born
for(i in seq_along(NAAS_clean$US_Born)){
  if(!is.na(NAAS_clean$US_Born[[i]])){
    if(identical(NAAS_clean$US_Born[[i]], "Another country")){
      NAAS_clean$US_Born[[i]] = "No"
    }else if(identical(NAAS_clean$US_Born[[i]], "United States")){
      NAAS_clean$US_Born[[i]] = "Yes"
    }else{
      NAAS_clean$US_Born[[i]] = "NA"
    }
  }
}

##cleaning for Employment status
for(i in seq_along(AALoQ_clean$Employment_Status)){
  if(!is.na(AALoQ_clean$Employment_Status[[i]])){
    if(identical(AALoQ_clean$Employment_Status[[i]], "Student")| identical(AALoQ_clean$Employment_Status[[i]], "StudentFull time homemaker") |identical(AALoQ_clean$Employment_Status[[i]], "Employed part timeStudent")|identical(AALoQ_clean$Employment_Status[[i]], "Employed full timeStudent")){
      AALoQ_clean$Employment_Status[[i]] = "Student"
    }else if(identical(AALoQ_clean$Employment_Status[[i]], "Employed full time")|identical(AALoQ_clean$Employment_Status[[i]], "Employed full timeEmployed part time")){
      AALoQ_clean$Employment_Status[[i]] = "Working full-time"
    }else if(identical(AALoQ_clean$Employment_Status[[i]], "Employed part time")){
      AALoQ_clean$Employment_Status[[i]] = "Working part-time"
    }else if(identical(AALoQ_clean$Employment_Status[[i]], "Employed full timeFull time homemaker")|identical(AALoQ_clean$Employment_Status[[i]], "Full time homemaker")|identical(AALoQ_clean$Employment_Status[[i]], "Employed part timeFull time homemaker ")){
      AALoQ_clean$Employment_Status[[i]] = "Homemaker"
    }else if(identical(AALoQ_clean$Employment_Status[[i]], "Retired")| identical(AALoQ_clean$Employment_Status[[i]], "Employed full timeRetired")|identical(AALoQ_clean$Employment_Status[[i]], "Employed part timeRetired")|identical(AALoQ_clean$Employment_Status[[i]], "Full time homemakerRetired")|identical(AALoQ_clean$Employment_Status[[i]], "StudentRetired")){
      AALoQ_clean$Employment_Status[[i]] = "Retired"
    }else{
      AALoQ_clean$Employment_Status[[i]] = "Unemployed"
    }
  }
}
for(i in seq_along(NAAS_clean$Employment)){
  if(identical(NAAS_clean$Employment[[i]], "Unemployed and still looking for work")|identical(NAAS_clean$Employment[[i]], "Unemployed and stopped looking for work")){
    NAAS_clean$Employment[[i]] = "Unemployed"
  }
}
##clean religion
for(i in seq_along(NAAS_clean$Religion)){
  if(!is.na(NAAS_clean$Religion[[i]])){
    if(identical(NAAS_clean$Religion[[i]], "DO NOT READ  No religion")| identical(NAAS_clean$Religion[[i]], "DO NOT READ  Spiritual, but not religious")){
      NAAS_clean$Religion[[i]]="None"
    }else if(identical(NAAS_clean$Religion[[i]],"Lutheran")|identical(NAAS_clean$Religion[[i]], "Protestant no denomination given")){
      NAAS_clean$Religion[[i]] = "Protestant"
  }else if(identical(NAAS_clean$Religion[[i]],"Buddhist" )){
    NAAS_clean$Religion[[i]] = "Buddhist"
  }else if(identical(NAAS_clean$Religion[[i]],"Catholic" )){
    NAAS_clean$Religion[[i]] = "Catholic"
  }else if(identical(NAAS_clean$Religion[[i]],"Hindu" )){
    NAAS_clean$Religion[[i]] = "Hindu"
  }else if(identical(NAAS_clean$Religion[[i]],"Muslim, Mohammedan, Islam")){
    NAAS_clean$Religion[[i]] = "Muslim"
  }else if(identical(NAAS_clean$Religion[[i]],"Christian")){
    NAAS_clean$Religion[[i]] = "Christian"
  }else{
    NAAS_clean$Religion[[i]] = "Other"
    }
  }
}
    
  
##changing variable name
NAAS_clean <- NAAS_clean %>% rename(Education_Completed = "Highest_Educ") %>% rename(Employment_Status = "Employment")
AALoQ_clean <- AALoQ_clean %>% mutate(Race = "ASIAN AMERICAN")

## join the two datasets
Final_dataset <- full_join(NAAS_clean, AALoQ_clean, by = c("Ethnicity","Race", "State", "Education", "Education_Completed", "Gender", "US_Born", "Religion", "Marital_Status", "Age", "clean_Income", "Employment_Status"))
