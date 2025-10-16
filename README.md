# Exercises for Parks Canada Intermediate R Workshop

Workshop website: <https://andyteucher.ca/pc-intermediate-r/>

## Advanced data manipulation with `dplyr` and `tidyr`

### Setup

1. Create a new project in Positron

- Either: 
	- Fork and clone the exercises repository:  
	 `https://github.com/ateucher/pc-data-manipulation/` OR
	- Run:
	 ```r
	 usethis::use_course("https://github.com/ateucher/pc-data-manipulation/archive/refs/heads/main.zip")
	 ```

2. Open the file: `01-get-data.R`

3. Download the data:

```{r}
#| echo: true
#| eval: false
install.packages("portalr")
library(portalr)

download_observations(".")
```

4. Explore the downloaded data in Positron

- The `.R` files in the root directory contain starter code for the exercises
- The `solutions/` directory contains the same files with solutions to the exercises. Don't peek unless you're really stuck!
