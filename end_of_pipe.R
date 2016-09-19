library(dplyr)
library(ggplot2)

.end <- function(...) {
    if (length(match.call()) == 1)
        NULL
    else
        identity(...)
}


# dplyr
mtcars %>%
    tibble::rownames_to_column('car_name') %>%
    select(car_name, mpg, cyl) %>%
    group_by(cyl) %>%                # 3 cyl groups: 4, 6, 8
    filter(mpg > mean(mpg)) %>%      # above average of each group
    top_n(1, mpg) %>%                # top 1 from each group, by mpg
    .end()



# ggplot
mtcars %>%
    mutate(cyl = factor(cyl)) %>%        # pipe your data into ggplot
    ggplot(aes(x = wt, y = mpg, color = cyl)) + 
    geom_point(size = 2) +
    scale_colour_brewer(palette = 'Dark2') +
    .end()

mtcars %>%
    mutate(cyl = factor(cyl)) %>%        # pipe your data into ggplot
    ggplot(aes(cyl, wt)) +
    geom_boxplot() + 
    .end()
