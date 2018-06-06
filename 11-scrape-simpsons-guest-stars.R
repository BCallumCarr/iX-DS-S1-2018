# =====================================================================================================================
# = Simpsons Guest Stars                                                                                              =
# =                                                                                                                   =
# = - Scrape a table.                                                                                                =
# = - Remove elements from DOM.                                                                                       =
# =                                                                                                                   =
# = Author: Andrew B. Collier <andrew@exegetic.biz> | @datawookie                                                     =
# =====================================================================================================================

# CONFIGURATION -------------------------------------------------------------------------------------------------------

URL = "https://en.wikipedia.org/wiki/List_of_The_Simpsons_guest_stars"

# LIBRARIES -----------------------------------------------------------------------------------------------------------

library(rvest)
library(httr)

# ---------------------------------------------------------------------------------------------------------------------

UA <- "Evelyn Wang | esw8ws@virginia.edu"
#
page <- GET(URL, user_agent("UA")) %>% read_html()

guest_stars <- page %>% html_nodes("table.wikitable") %>% .[[1]] %>% html_table()

#
# There's a problem though: there's an additional (hidden) tag in the table which is causing name duplication.

# Let's find a hack to delete those nodes.
#
html_nodes(page, "th > span.sortkey")

sortkey <- page %>% html_nodes("th > span.sortkey")
#


xml_remove(sortkey)

head(guest_stars)

# Try again.
#

View(guest_stars)
#
# Much better!

# EXERCISES -----------------------------------------------------------------------------------------------------------

# 1. Remove the episode number and production code columns.

library(dplyr)
?select()
guest_stars_seg = select(guest_stars, Season, 'Guest star', 'Role(s)', 'Episode title')

# 2. Clean up the Guest Star Episode Title columns.

guest_stars_seg = as_tibble(guest_stars_seg)
?substr()
?mutate_at()
clean_up = substr(guest_stars_seg$`Episode title`, '[', ']')

guest_stars_seg = gsub("[]", "", guest_stars_seg)
# 3. Convert the Role(s) column into a list column (split multiple roles).

View(guest_stars_seg)
# 4. Which guest star has appeared the most times?



# 5. Scrape the table of guest animators.