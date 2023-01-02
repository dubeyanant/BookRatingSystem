Books <- read.csv(paste(as.character(getwd()),"/info.csv", sep=""))
# Four columns in the Books data set
# Name, Page Count, Book Rating, Number of Ratings

# Find the Book Value by an algo discussed here: https://stackoverflow.com/a/50476254/14224859

# We first determine the value of Default Rating by finding the sample median
R <- median(Books$Rating)
# Now we find Worth of the Default Rating
W <- R/10

# Formula for finding the Book Value: BV = (W*R + NOR*Rating) / (W+NOR)
Books$BV <- ((W*R)+(Books$NOR*Books$Rating))/(W+Books$NOR)*2
Books$BV <- trunc(Books$BV*10^2)/10^2

# Plotting the graph of Book Value vs Page Count
#install.packages("ggplot2")
#library("ggplot2")
ggplot(data = Books,
       mapping = aes(x = Page,
                     y = BV)) + geom_point() + 
  geom_label(aes(label=Name), nudge_y = 0.05, size = 3) + 
  labs(x = "Page Count", y = "Book Value")