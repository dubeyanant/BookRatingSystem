Books <- read.csv(paste(as.character(getwd()),"/info.csv", sep=""))
# Four columns in the Books data set
# Name, Page Count, Book Rating, Number of Ratings

# Find the Book Value by an algo discussed here: https://stackoverflow.com/a/50476254/14224859

# We first determine the value of Default Rating by finding the sample median
# R <- median(Books$Rating)
R <- 2.4
W <- 400 # Now we find Worth of the Default Rating

Books$BV <- (((W*R)+(Books$NOR*Books$Rating))/(W+Books$NOR))*2 # Finding Book Value
Books$BV <- trunc(Books$BV*10^2)/10^2 # Truncating to two decimal points
Books <- Books[order(Books$BV, decreasing = TRUE),] # Sorting on the basis of BV

#install.packages("ggplot2")
#install.packages("gghighlight")
#install.packages("ggrepel")
library("ggrepel") 
library("ggplot2")
library("gghighlight")

# Plotting the graph of Book Value vs Page Count
ggplot(data = Books, mapping = aes(x = Page, y = BV,)) +
  geom_point(color = "red") + 
  geom_text_repel(aes(x = Page, y = BV, label = Name), nudge_y = 0.04) + 
  labs(x = "Page Count", y = "Book Value") + 
  gghighlight(BV > 7.7, Page < 250, label_key = type)
