# [TweetGists](http://tweetgists.herokuapp.com/)

[![Build Status](https://travis-ci.org/blairand/blog-api.png?branch=master)](https://travis-ci.org/blairanderson/blog-engine) [![Code Climate](https://codeclimate.com/github/blairand/blog-api.png)](https://codeclimate.com/github/blairanderson/blog-engine)

Recreating github Gists as closely as possible, starting with the API, then building out the frontend. 

[PivotalTracker](https://www.pivotaltracker.com/s/projects/835205) 


TODOs:

- Create user accounts and return an API KEY. 

- Authenticated users can POST an article, the JSON response will include:
  - Article ID
  - Article URL
  - Article view count
  - Article comments

- Authenticated users can Edit and Delete articles. 
- Guest users can get articles. 
   
## Getting Started


```bash
git clone https://github.com/blairand/json-blog.git
cd blogger_advanced
bundle
rake db:migrate
rails server
```
