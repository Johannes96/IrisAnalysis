cols <- colnames(iris)

class(c(cols))

gsub("\\.", " ", cols)

cols2 <- setNames(colnames(iris), gsub("\\.", " ", colnames(iris)))

# TODO
# add filter for Species in histogram

# clustering --------------------------------------------------------------

ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width, color = Species)) +
  geom_point()

# remove categorical columns and scale
iris_clust <- scale(iris %>% select(cols2[1:4]))

# perform k-means clustering

withinss <- list()

for (i in 1:10) {
  iris_km <- kmeans(iris_clust, centers = i, nstart = 25)
  print(iris_km[5])
  withinss[i] <- iris_km[5]
}

# TODO
# create dataframe with 2 columns (withinss and number of clusters)

# create lineplot with x=number of clusters and y=withinss

# add clusters to original iris dataset

# visualize with colors in scatterplot

# 


