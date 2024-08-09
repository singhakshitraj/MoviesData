# Movie Database
This is a movie database application created with Flutter framework. It uses the TMDB API for authenticaton and which has one of the largest collection of Movies And TV Series. It uses dart language which provides incredible support for asynchronous tasks. The following are the key features of this application - 
## Key Features
The Key Feature Of The Application are-
### Introduction Screen
The Introduction Screen consists of the application's logo.

![1](https://github.com/singhakshitraj/MoviesData/blob/master/lib/new-images/splash.png?raw=true)

### Authenticaton
The Authenticaton process entirely takes place through redirecting to TMDB API.
Each Login process generates a Session-ID which is used to verify the identity and validity of the user trying to access the database. 

![2](https://github.com/singhakshitraj/MoviesData/blob/master/lib/new-images/auth.png?raw=true)

### Home Page
The Home page of the application consists of a list of trending movies and tv series. The application also maintains a list of watchlist and favourited movies and TV Series added by the user. There is also an about section which consists of information about some of the external packages used for creation of the application.

![5](https://github.com/singhakshitraj/MoviesData/blob/master/lib/new-images/home.png?raw=true)

### Details Page
The details page consists of a cover image of the movie and a bar consisting of rating of the item and options of adding it to the favorites or bookmarks. Below it is a bar showing the multiple genres it belongs to. Then comes the gallery section which shows the images associated with given movie or series. Then is the section containing the similar and recommended items. Page Specific Items-
* TV Series Page - Last Episode Aired

![8](https://github.com/singhakshitraj/MoviesData/blob/master/lib/new-images/tv-detail.png?raw=true)

* Movies Page - Reviews Section

![11](https://github.com/singhakshitraj/MoviesData/blob/master/lib/new-images/movie-detail.png?raw=true)

### Search Bar
The Search Bar takes in a query and finds the relavent results from the API and answers it to the user. It finds results of both the movies and tvSeries that match the query.

![14](https://github.com/singhakshitraj/MoviesData/blob/master/lib/new-images/search.png?raw=true)

### Lists
The Application maintains two lists - Watchlist and Liked Movies .These lists are completely synced with the TMDB server. An item can be added to the list from the details page of the desired item.

![17](https://github.com/singhakshitraj/MoviesData/blob/master/lib/new-images/lists.png?raw=true)

### About Page
The About Page consists of information about the dependencies used in creation of the application.