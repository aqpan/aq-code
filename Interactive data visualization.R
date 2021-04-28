library(tidyverse)
library(plotly)
covid <- readRDS("ca.counties.covid.rds")
# cleaning data
covid <- covid %>% mutate(casesPerCapita = round(100*cases/population, 2), 
                          deathsPerCapita = round(100*deaths/population, 2)) %>%
  group_by(name) %>% 
  mutate(cumCases=cumsum(cases), cumDeaths=cumsum(deaths)) %>% 
  ungroup()
  
g <- ggplot(data=covid, aes(x=date, y=cases, color=name)) + geom_line() +
  geom_point(aes(text=paste("Country:", name, "<br>",
                            "Date:", date, "<br>", 
                            "Cases:", cases, "<br>",  
                            "Deaths:", deaths, "<br>",
                            "Cases Per Capita:", casesPerCapita, "<br>",
                            "Deaths Per Capita:", deathsPerCapita, "<br>",
                            "Cumulative Cases:", cumCases, "<br>",
                            "Cumulative Deaths:", cumDeaths, "<br>"
                            
  )), size=0.2) +
  labs(title="Covid in California")
p <- ggplotly(g, tooltip="text", height=700)
p$sizingPolicy$browser$fill = FALSE
htmlwidgets::saveWidget(p, "covid.html", selfcontained = FALSE)


library(ggplot2)
library(ggmap)
library(maps)
library(mapdata)
covid$subregion <- tolower(covid$name)
dat <- covid[covid$date=="2020-12-10",]

states <- map_data("state")
ca_df <- subset(states, region == "california")
counties <- map_data("county")
ca_county <- subset(counties, region == "california")
ca_county <- inner_join(ca_county, dat, by="subregion")

ca_base <- ggplot(data = ca_df, mapping = aes(x = long, y = lat, group = group)) + 
  coord_fixed(1.3) + 
  geom_polygon(color = "black", fill = "gray")
ca_base + theme_nothing()
ditch_the_axes <- theme(
  axis.text = element_blank(),
  axis.line = element_blank(),
  axis.ticks = element_blank(),
  panel.border = element_blank(),
  panel.grid = element_blank(),
  axis.title = element_blank()
)

g <- ca_base + theme_nothing() + 
  geom_polygon(data = ca_county, aes(fill = cumCases), color = "white") +
  geom_polygon(color = "black", fill = NA) +theme_bw() +
  ditch_the_axes +
  scale_fill_gradientn(colours = rev(rainbow(7)),
                       breaks = c(2, 4, 10, 100, 1000, 10000),
                       trans = "log10")
p <- ggplotly(g)
p$sizingPolicy$browser$fill = FALSE
htmlwidgets::saveWidget(p, "covid_map.html", selfcontained = FALSE)
