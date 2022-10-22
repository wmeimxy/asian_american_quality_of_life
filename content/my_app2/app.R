library(tidyverse)
library(ggplot2)
library(plotly)
library(shiny)

AALoQ_clean <- read_csv("AALoQ_clean - AALoQ_clean.csv", guess_max = 1001)

temp <- AALoQ_clean %>% filter(!is.na(Income) & !is.na(Quality_of_Life))

income <- temp %>% pull(Income) %>% unique() %>% sort()

temp2 <- AALoQ_clean %>% filter(!is.na(Education_Completed) & !is.na(Quality_of_Life))

Edu_comp <- temp2 %>% pull(Education_Completed) %>% unique() %>% sort()

NAAS_clean <- read_csv("NAAS_clean - NAAS_clean.csv", guess_max = 1001)

library(tidyverse)
library(sf)
library(tmap)

us_states <- st_read("cb_2019_us_state_20m.shp", quiet=TRUE)

us_states <- us_states %>% st_transform(2163)

not_contiguous <-
  c("Guam", "Commonwealth of the Northern Mariana Islands",
    "American Samoa", "Puerto Rico", "Alaska", "Hawaii",
    "United States Virgin Islands")

us_cont <- us_states %>% filter(!(NAME %in% not_contiguous))

us_cont <- us_cont %>% select(STATEFP, STUSPS, NAME, geometry)

#tm_shape(us_cont) + tm_borders(lwd = 2)

temp4 <- NAAS_clean %>% group_by(State) %>% group_by(State) %>% summarise(State,total = n()) %>% unique()

temp6 <- NAAS_clean %>% group_by(State) %>% count(Dem_Impres) %>% filter(Dem_Impres == "Very favorable") %>% summarise(State,unf = sum(n)) %>% unique() 

temp7 <- inner_join(temp4, temp6) %>% summarise(State, result = unf/total)

#temp4 <- as_tibble(temp4)

joined <- left_join(us_cont, temp7, by = c("STUSPS" = "State"))

temp8 <- NAAS_clean %>% group_by(State) %>% group_by(State) %>% summarise(State,total = n()) %>% unique()

temp9 <- NAAS_clean %>% group_by(State) %>% count(Repub_Impres) %>% filter(Repub_Impres == "Very favorable") %>% summarise(State,unf = sum(n)) %>% unique() 

temp10 <- inner_join(temp8, temp9) %>% summarise(State, result = unf/total)

#temp4 <- as_tibble(temp4)

joined2 <- left_join(us_cont, temp10, by = c("STUSPS" = "State"))


ui <- fluidPage(
  titlePanel("Income vs Quality of Life"),
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId = "income", label = "Income", choices = income, multiple = TRUE, selected = "$0 - $9,999")
    ),
    mainPanel(plotlyOutput("distPlot"))
  ),
  titlePanel("Educational Level vs Quality of Life"),
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId = "Edu_comp", label = "edu", choices = Edu_comp, multiple = TRUE, selected = "No schooling completed")
    ),
    mainPanel(plotlyOutput("distPlot2"))
  ),
  titlePanel("Very favorable Democratic impression in US by states"),
  tmapOutput("my_tmap"),
  titlePanel("Very favorable Republican impression in US by states"),
  tmapOutput("my_tmap2")
)

server <- function(input, output) {
  output$distPlot <- renderPlotly({
    p <- temp %>% filter(Income == input$income) %>% ggplot(aes(x=Quality_of_Life, fill=Ethnicity)) + geom_bar()
    ggplotly(p)
  })
  
  output$distPlot2 <- renderPlotly({
    q <- temp2 %>% filter(Education_Completed == input$Edu_comp) %>% ggplot(aes(x=Quality_of_Life, fill=Ethnicity)) + geom_bar(width = 0.9)
    ggplotly(q)
  })
  
  output$my_tmap = renderTmap({
    tm_shape(joined) + tm_fill(col = "result", title = "prop very favorable", n=10) + tm_borders(col = "black", lwd = 2)
  })
  
  output$my_tmap2 = renderTmap({
    tm_shape(joined2) + tm_fill(col = "result", title = "prop very favorable", n=10) + tm_borders(col = "black", lwd = 2)
  })
}

shinyApp(ui = ui, server = server)
