## This project follows the help(dat.bcg), help(forest.rma) and help(metafor)

# Install the package "metafor"

installed.packages("metafor")
library(metafor)

# Load dat.bcg as dat

dat <- dat.bcg
dat

# Open the data frame to have a clear view of the variables.

### calculate log risk ratios and corresponding sampling variances
dat <- escalc(measure = "RR",
ai = tpos, bi = tneg, ci = cpos, di = cneg, data = dat)

dat
### random-effects model
res <- rma(yi, vi, data = dat)
res
### average risk ratio with 95% CI
predict(res, transf = exp)

# Forest plot with annotations of author yar and separated by ", ".
forest(res, addpred = TRUE, slab = paste(author, year, sep = ", "))

# Adding header - can be a logical argument or a string.
forest(res, addpred = TRUE, slab = paste(author, year, sep = ", "),
header = "Author(s) and Year")

# Adding colour to the diamond

forest(res, addpred = TRUE, slab = paste(author, year, sep = ", "),
header = "Author(s) and Year", col = "gray")

### forest plot with extra annotations

forest(res, slab = paste(author, year, sep = ", "),
atransf = exp, at = log(c(.05, .25, 1, 4)), xlim = c(-16, 6),
       ilab = cbind(tpos, tneg, cpos, cneg), ilab.xpos = c(-9.5, -8, -6, -4.5),
       cex = .75, header = "Author(s) and Year", col = "gray",
       addpred = TRUE)
op <- par(cex = .75, font = 2)
text(c(-9.5, -8, -6, -4.5), res$k + 2, c("TB+", "TB-", "TB+", "TB-"))
text(c(-8.75, -5.25),     res$k + 3, c("Vaccinated", "Control"))
par(op)