// first api to get movie list
final String api1 =
    'http://api.themoviedb.org/3/movie/popular?api_key=802b2c4b88ea1183e50e6b285a27696e';
// second api to call movie details
final String creditsApi =
    'https://api.themoviedb.org/3/movie/MOVIEID/credits?api_key=802b2c4b88ea1183e50e6b285a27696e';
final String api2 =
    'http://api.themoviedb.org/3/movie/MOVIEID?api_key=802b2c4b88ea1183e50e6b285a27696e&language=en-US';
// api to get images
final String imageUrl = 'https://image.tmdb.org/t/p/w500/';

final String searchUrl =
    "https://api.themoviedb.org/3/search/movie?api_key=802b2c4b88ea1183e50e6b285a27696e&language=en-US&query=QUERY&page=1&include_adult=false";
