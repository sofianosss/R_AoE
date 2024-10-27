library(jsonlite)

Sys.setlocale("LC_ALL", "en_US.UTF-8")
data <- fromJSON("C:/Users/Valia/Downloads/games_rm_1v1_s8json/games_rm_1v1_s8.json", flatten = TRUE)

library(purrr)
result <- map_dfr(data$teams, ~ as.data.frame(.) )
rm(data)
gc() #Garbage collection aka remove unused stuff
beepr::beep()

library(dplyr)
df <- result %>% 
  select(civilization,civilization.1) %>% 
  mutate(english_present = ifelse(grepl("english", civilization) | grepl("english", civilization.1), "Yes", "No")) %>% 
  mutate(english_both = ifelse(grepl("english", civilization) & grepl("english", civilization.1), "Yes", "No"))

yes_count <- sum(df$english_present == "Yes")
no_count <- sum(df$english_present == "No")
yesBoth_count <- sum(df$english_both == "Yes")

game_percentage_with_english_players = yes_count/(yes_count+no_count)*100
game_percentage_with_english_players_both = yesBoth_count/(yes_count)*100
