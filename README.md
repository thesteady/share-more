# [TweetGists](http://tweetgists.herokuapp.com/)

[![Build Status](https://travis-ci.org/blairand/blog-api.png?branch=master)](https://travis-ci.org/blairanderson/blog-engine) [![Code Climate](https://codeclimate.com/github/blairanderson/blog-engine.png)](https://codeclimate.com/github/blairanderson/blog-engine)

Recreating github Gists as closely as possible, starting with the API, then building out the frontend. 

[PivotalTracker](https://www.pivotaltracker.com/s/projects/835205) 

Things it Does:

#### Authenticated Users

- You get an API Key

- You can expire and refresh API Key.

- Create an article.  

- Edit and Delete your own articles. 


#### Non-Authenticated Users

- You can visit the home-page

- You can view articles that have been created


TODOs:

- Authenticated users can POST an article, the JSON response will include:
  - Article ID
  - Article URL
  - Article view count
     
- Change Login from username/password to Twitter

- Offer all functionality through JSON API. 

- Offer all functionality through a ruby gem.

## Getting Started


```bash
git clone https://github.com/blairand/json-blog.git
cd blogger_advanced
bundle
rake db:migrate
rails server
```
