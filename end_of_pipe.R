library(dplyr)
library(ggplot2)

# .end() a.k.a. .pipe_dream()
# 
# A simple and fast function to add at the end of dplyr and ggplot workflows
# - The goal is to avoid retyping `%>%` and `+` 
# and not to display extra lines changed in git diff
# - Start with a `.` to keep it hidden
.end <- function(...) {
    if (length(match.call()) == 1) NULL
    else identity(...)
}


# dplyr example
mtcars %>%
    tibble::rownames_to_column('car_name') %>%
    select(car_name, mpg, cyl) %>%
    group_by(cyl) %>%                # 3 cyl groups: 4, 6, 8
    filter(mpg > mean(mpg)) %>%      # above average of each group
    top_n(1, mpg) %>%                # top 1 from each group, by mpg
    .end()



# ggplot example
mtcars %>%
    mutate(cyl = factor(cyl)) %>%
    ggplot(aes(x = wt, y = mpg, color = cyl)) + 
    geom_point(size = 2) +
    scale_colour_brewer(palette = 'Dark2') +
    .end()

mtcars %>%
    mutate(cyl = factor(cyl)) %>%
    ggplot(aes(cyl, wt)) +
    geom_boxplot() + 
    .end()
