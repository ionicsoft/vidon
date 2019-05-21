[98% C0 Coverage] [86.8% C1 Coverage]

![vidon](https://raw.githubusercontent.com/ionicsoft/vidon/master/app/assets/images/logo-small.png)

# ionicSoft Vidon Project

This is a web application project developed by students for the AGILE Software Development course at California State Polytechnic University in Pomona. Our project is a subscription based video-on-demand service where customers can subscribe to individual show and rent movies, instead of the more common alternative of subscribing to an entire catalog of content.

Additional features include:
 - Customer profiles with ratings, watch history, and comments
 - Friends and friend requests
 - Save and resume video position for all videos
 - Content suggestions
 - Search with common filters like genre or actor
 
Our project also included some of the producer's side of interacting with the site. A content produer can create and upload new shows, episodes, and movies. They are then provided some basic analytics and management features for the content they own.

For our specific implementation, we used Bootstrap 4 and VideoJS on the front-end, Rails for the middleware, and AWS S3 and MySQL as back-end services.

During the project we followed the Agile Scrum framework for planning, designing, development, and testing.

## Screenshots

*NOTE: OUR PROJECT ONLY HOSTS PUBLIC DOMAIN CONTENT. THE POSTER IMAGES USED BELONG TO THEIR RESPECTIVE OWNERS AND ARE USED FOR DEMONSTRATIVE PURPOSES ONLY

### Video page
![Video page](https://i.imgur.com/XIaVVZW.png)

### Customer homepage
![Customer homepage](https://i.imgur.com/Qt2mDbI.jpg)

### Guest homepage
![Guest homepage](https://i.imgur.com/enAkacf.png)

### Content browsing
![Content browsing](https://i.imgur.com/ujoC0Nr.jpg)

### Suscriptions Management
![Suscriptions Management](https://i.imgur.com/R1frshL.png)


## Getting started

To get started with the app, clone the repo and then install the needed gems:

```
$ bundle install --without production
```

Next, create the development database:

```
$ rails db:migrate
```

Finally, run the test suite to verify that everything is working correctly:

```
$ rails test
```

If the test suite passes, you'll be ready to run the app in a local server:

```
$ rails server
```

If you are using c9, run with ip and port arguments:

```
$ rails server -b $IP -p $PORT
```
