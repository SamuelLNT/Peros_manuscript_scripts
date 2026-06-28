setwd("$PATH")
setwd("$PATH")

#for v2.2, different theta
setwd("$PATH")

#prefix for the file names
prefix = "03theta"

library(ggplot2)
library(dplyr)
#library(purrr)

summary_files <- list.files(path = ".", pattern = "\\.summary$", full.names = TRUE)
summary_files <-basename(summary_files)
print(summary_files)

# Create an empty list to collect data
all_data <- list()
summary_stat <- data.frame()

  # Loop through all files
for (x in summary_files) {
  name <- strsplit(x, "_")[[1]][1]
   df <- read.table(x,header = TRUE,sep = "")
  # Check necessary columns are present
  required_cols <- c("year", "Ne_median", "Ne_2.5.", "Ne_97.5.","Ne_12.5.","Ne_87.5.")
  if (!all(required_cols %in% names( df))) {
    warning(paste("Skipping file due to missing columns:", name))
    next
  }
  i <- df %>%
    summarise(
      max_year = max(year, na.rm = TRUE), 
      min_Ne_median = min(Ne_median, na.rm = TRUE),
      max_Ne_median = max(Ne_median, na.rm = TRUE)
    )
  i <- mutate(i,group=name)
  summary_stat <- rbind(summary_stat,i)
  #Original code
 df <- df %>%
   mutate(
     group = name,
     time = year / 1000,   # keep this if you still want to scale years into KYA
     Ne_median = Ne_median,
     Ne_12.5 = `Ne_12.5.`,
     Ne_87.5 = `Ne_87.5.`,
     Ne_97.5 = `Ne_97.5.`,
     Ne_2.5 = `Ne_2.5.`
   ) %>%
   select(time, Ne_median, Ne_12.5, Ne_87.5, Ne_97.5, Ne_2.5, group)
 all_data[[x]] <- df

#Add a group identifier based on file name in the scale of 10k for Ne
# df <- df %>%
#   mutate(group = name,
#     time = year/1000,
#     Ne_median = Ne_median /10000,
#     Ne_12.5 = `Ne_12.5.`/10000,
#     Ne_87.5 = `Ne_87.5.`/10000,
#     Ne_97.5 = `Ne_97.5.`/10000,
#     Ne_2.5 = `Ne_2.5.`/10000
#   ) %>%
#   select(time, Ne_median, Ne_12.5, Ne_87.5, Ne_97.5, Ne_2.5, group)
# all_data[[x]] <- df

  
  # Applying log for the Ne
 #  df <-  df %>%
 #   mutate(group = name,
 #     time = year/1000,
 #     Ne_median = log10(Ne_median),
 #     Ne_12.5 = log10(`Ne_12.5.`),
 #     Ne_87.5 = log10(`Ne_87.5.`),
 #     Ne_97.5 = log10(`Ne_97.5.`),
 #     Ne_2.5 =  log10(`Ne_2.5.`)
 #   ) %>%
 #   select(time, Ne_median, Ne_12.5, Ne_87.5, Ne_97.5, Ne_2.5, group)
 # all_data[[x]] <-  df
}

str(all_data)

# Combine all into one dataframe
combined_df <- bind_rows(all_data)
#combined_df <- filter(combined_df, !group %in% c("out", "bois"))

head(combined_df)

# Plot
plot <- ggplot(combined_df, aes(x = time, color = group, fill = group)) +
  geom_ribbon(aes(ymin = Ne_12.5, ymax = Ne_87.5), alpha = 0.2, color = NA) +  # 20% transparency
  geom_line(aes(y = Ne_median), size = 1) +  # Median line, solid
  #scale_x_reverse() +
  scale_y_log10( guide = guide_axis_logticks()) +# Comment this out if Ne is not on log scale
  #scale_y_log10(limits = c(1, NA), guide = guide_axis_logticks()) +  
  #scale_y_continuous(trans = "log10", breaks = pretty(combined_df$Ne_87.5, n = 10))+ #this can increase the Y axis increment?
  #ylim(0,2.0e+06)+
  #xlim(0,50)+
  theme_bw() +
  labs(
    x = "Thousand years ago",
    y = "Effective population size\n(Ne)",
  ) +
  #theme_classic()+
  theme(
    legend.title = element_blank(),
    text = element_text(size = 11)
    #axis.title.y = element_text(size = 10, margin = margin(r = 12))
  )

print(plot)

ggsave(plot,path = "./", filename = paste(prefix,"stairway_allgroup_summary.pdf", sep="_"),dpi=300)


#####
#inspecting the plot
#####

summary_stat
write.csv(summary_stat,file=paste(prefix,"SummaryStatistic_NeYear.csv",sep="_"))

