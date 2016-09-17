# Swift Trend Bot

This is a Slack bot that will tell you the Trending Repositries of Github.  
This is written with [Vapor](https://github.com/vapor/vapor).

# Usage

## Talk to bot

You can get information of the trending repositories on Github 
by input in the following format to the channel of Slack.

```
trending {language}
ex) trending swift
```

By input `trending swift`, you will get information of the trending repositories written by `swift`.

![](Resources/usage1.png)


# Set up

## 1. Install Vapor

If you have not yet installed Vapor, according to the documentation, be sure to install the Vapor.

https://vapor.github.io/documentation/

## 2. Download Source

Download source from this repository.

## 3. Configure Slack Bot

Make your Bot User Accont from the following URL.  

https://my.slack.com/services/new/bot  

![](Resources/create-slack-bot.png)


"API Token" that can be acquired after creating the account will be used in a later step as an environment variable called `BOT_TOKEN`.

![](Resources/create-slack-bot2.png)

## 4. Generate Github Access Token

In order to loosen the rate limit of Github API, you use the Access Token.  

You can generate below URL.  

https://github.com/settings/tokens


## 5. Create App on Heroku

Create new App on Heroku.  

https://dashboard.heroku.com/new

## 6. Configure the settings of Heroku

### Deploy settings
Configure Heroku Git and connect to Github.  

### Config Variables
Set Config Variables under your project directory.  
(
In advance , you must be logged in to Heroku. `heroku login`)

- `BOT_TOKEN`: Generated at `3. Configure Slack Bot` section
- `GITHUB_TOKEN`: Generated at `4. Generate Github Access Token` section

```sh
$ heroku config:set BOT_TOKEN=xoxb-00000000000-XXXXXXXXXXXXXXXXXXXXXXXXX
$ heroku config:set GITHUB_TOKEN=XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
```

![](Resources/create-heroku-app.png)

### Set Buildpack

```sh
$ heroku buildpacks:set https://github.com/kylef/heroku-buildpack-swift
```

## 7. Deploy to Heroku

### push to Heroku

```sh
$ git push heroku master
```

### scale up dyno

```sh
$ heroku ps:scale worker=1
```