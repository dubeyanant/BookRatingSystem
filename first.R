Books <- read.csv(paste(as.character(getwd()),"/info.csv", sep=""))
# Four columns in the Books data set
# Name, Page Count, Book Rating, Number of Ratings

# Find the Book Value by an algo discussed here: https://stackoverflow.com/a/50476254/14224859

# We first determine the value of Default Rating by finding the sample median
#R <- median(Books$Rating)
R <- 2.4
# Now we find Worth of the Default Rating
W <- 500

# Formula for finding the Book Value: BV = (W*R + NOR*Rating) / (W+NOR)
Books$BV <- (((W*R)+(Books$NOR*Books$Rating))/(W+Books$NOR))*2
#Books$BV <- trunc(Books$BV*10^2)/10^2

Books <- Books[order(Books$BV, decreasing = TRUE), ]

# Plotting the graph of Book Value vs Page Count
#install.packages("ggplot2")
#install.packages("gghighlight")
library("ggplot2")
library("gghighlight")
ggplot(data = Books, mapping = aes(x = Page, y = BV,)) +
  geom_point(color = "red") + 
  geom_label(aes(label=Name), nudge_y = 0.08, size = 3) + 
  labs(x = "Page Count", y = "Book Value") + 
  gghighlight(BV > 7.5, Page < 250, label_key = type)
