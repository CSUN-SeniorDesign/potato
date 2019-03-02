## MEAN Stack
- MongoDB
- Express.JS
- Angular.JS
- Node.JS

## Required
- Curl
- Git
- Apache2
- Firewall
- Text editor

  ```
  sudo apt-get install -y curl git apache2 ufw
  sudo snap install atom --classic
  sudo ufw allow 22/tcp
  sudo ufw allow 80/tcp
  sudo ufw allow 443/tcp
  sudo ufw allow 3000/tcp
  sudo ufw allow 4200/tcp  
  ```

## For servers with a desktop environment
1. Disable screensaver/lock.
  ```
  gsettings set org.gnome.desktop.session idle-delay 0 && \
  gsettings set org.gnome.desktop.screensaver lock-enabled false
  ```

## Installing and setting up the MEAN Stack
1. Update the repo and packages installed.
  ```
  sudo apt-get update -y && sudo apt-get upgrade -y
  ```

2. Install Node.JS (and NPM)
  ```
  curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
  sudo apt-get install -y nodejs build-essential
  ```

3. Install MongoDB.
  ```
  sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 9DA31620334BD75D9DCB49F368818C72E52529D4

  echo "deb [ arch=amd64 ] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.0.list

  sudo apt-get update -y

  sudo apt-get install -y mongodb-org

  sudo systemctl start mongod

  sudo systemctl enable mongod
  ```

4. Install Angular.JS
  ```
  sudo npm install -g @angular/cli
  ```

5. Install Express.
  ```
  sudo npm install -g express
  sudo npm install -g express-generator@4.16.0
  sudo npm install -g express-session@1.15.6
  sudo npm install -g @okta/oidc-middleware
  sudo npm install -g @okta/okta-sdk-nodejs
  ```

## Starting the project
1. Using express, set up the project file strcture.
  ```
  cd ~/Desktop && express --view pug login-portal
  cd login-portal
  sudo npm install

  Optional: Run the following to test the app so far:
  sudo npm start
  ```

2. Sign up for a free Okta developer account: https://developer.okta.com/signup/.

  2a. Copy the org url: https://dev-423841.okta.com

  2b. Go to Application > Add Application > Web

  2c. Use the following settings:
    ```
    Name: login-portal
    Base URIs: http://localhost:3000
    Login redirect URIs: http://localhost:3000/users/callback
    ```

  2d. Copy the Client ID and Client Secret:
    ```
    Client ID: 0oabr9jsqpLUEqRIy356
    Client Secret: hCqri2hT_GUy1i-kYbueW9gTr8sm1n0w1M-RS49H
    ```

  2e. Go to API > Tokens > Create Token
    ```
    Name: login-portal
    Token Value: 00ZSLP0Jm4ytPKAA-c_ZDN6WDM_dd8evc3ABs04p8S
    ```

  2f. Go to Developer Console > Classic UI > Directory > Self-Service Registration > Enable Registration.

  2g. Go to Default redirect
    ```
    Custom URL: http://localhost:3000/dashboard
    ```

  2h. Go to Classic UI > Developer Console

## Session Management
1. Go into the login-portal directory and open Atom.
```
  cd ~/Desktop/login-portal && atom .
```

2. Open app.js and make sure these lines are in there:
```
  var createError = require('http-errors');
  var express = require('express');
  var path = require('path');
  var cookieParser = require('cookie-parser');
  var logger = require('morgan');
  var session = require("express-session");
  var cookieParser = require('cookie-parser');

  app.use(cookieParser());
```

3. Add the following under the app.use(cookieParser());

  ```
  app.use(session({
  secret: 'aweoihngaw4g2w34908h23wt4gawaweoik',
  resave: true,
  saveUninitialized: false
  }));
  ```

## Using Express.JS and Pug to create a view
1. In Atom open login-portal/views/layout.pug
2. Replace the contents of layout.pug with the following:
  ```
  block variables

  doctype html
  html(lang="en")
    head
      meta(charset="utf-8")
      meta(name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no")
      link(rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous")
      link(rel="stylesheet", href="/stylesheets/style.css")
      title okta-express-login-portal: #{title}
    body
      div.top-bar.d-flex.flex-column.flex-md-row.align-items-center.p-3.px-md-4.mb-3.bg-white.border-bottom.box-shadow
        h5.my-0.mr-md-auto.font-weight-normal
          a(href="/", title="Expresso") okta-express-login-portal
        nav.my-2.my-md-0.mr-md-3
          a.p-2.text-dark(href="/", title="Home") Home

          if user == undefined
            a.p-2.text-dark(href="/users/login") Log In / Register
          else
            a.p-2.text-dark(href="/dashboard") Dashboard
            a.p-2.text-dark(href="/users/logout") Logout
      .container
        block content

      footer.
        Built with #[a(href="https://expressjs.com/") Express.js], login powered by #[a(href="https://developer.okta.com/") Okta].
  ```

2. Replace the contents of index.pug with the following:
  ```
  extends layout

  block variables
  - var title = "Home"

  block content
  h2.text-center Express App

    .row
      .offset-sm-2.col-sm-8
        .jumbotron.text-center.
          Welcome to your new Express app! Please visit the
          #[a(href="https://github.com/rdegges/okta-express-login-portal", title="okkta-express-login-portal on GitHub") GitHub page] to learn more.
  ```

3. Create /views/dashboard.pug then put the following code inside it:
  ```
  extends layout

  block variables
  - var title = "Dashboard"

  block content
  h2.text-center Dashboard

  .row
    .offset-sm-2.col-sm-8
      .jumbotron.text-center.
        Welcome to your dashboard page, #{user.profile.firstName}.
  ```

4. Replace the contents of error.pug with the following:
  ```
  extends layout

  block content
    h1= message
    h2= error.status
    pre #{error.stack}
  ```

5. Create /views/unauthenticated.pug and put the following code inside it:
  ```
  extends layout

  block variables
    - var title = "Unauthenticated"

  block content
    h2.text-center You Must Log In to View This Page
    p.text-center.
      You must be signed in to view this page. Please #[a(href="/users/login", title="Login") login or register] to view this page.
  ```

## Routing
1. Remove the default routes that was created by the express command in Starting the project section.
```
rm routes/*
```

2. Create /routes/public.js and put the following code inside it:

  ```
    const express = require("express");

    const router = express.Router();

    // Home page
    router.get("/", (req, res) => {
      res.render("index");
    });

    module.exports = router;
  ```

3. Create /routes/dashboard.js and put the following code inside it:
  ```
  const express = require("express");

  const router = express.Router();

  // Display the dashboard page
  router.get("/", (req, res) => {
    res.render("dashboard");
  });

  module.exports = router;
  ```

4. Open app.js then replace the following:
  ```
  var indexRouter = require('./routes/index');
  var usersRouter = require('./routes/users');
  ```

  with

  ```
  const dashboardRouter = require("./routes/dashboard");         
  const publicRouter = require("./routes/public");
  ```

5. In app.js replace the following:
  ```
  app.use('/', indexRouter);
  app.use('/users', usersRouter);
  ```

  with

  ```
  app.use('/', publicRouter);
  app.use('/dashboard', dashboardRouter);
  ```

## User Authentication
1. Open app.js and import the following libraries:
```
  var okta = require("@okta/okta-sdk-nodejs");
  var ExpressOIDC = require("@okta/oidc-middleware").ExpressOIDC;
```

2. In app.js, under ```var app = express();``` put the following code:
```
  var oktaClient = new okta.Client({
    orgUrl: '{yourOktaOrgUrl}',
    token: '{yourOktaToken}'
  });
  const oidc = new ExpressOIDC({
    issuer: "{yourOktaOrgUrl}/oauth2/default",
    client_id: {yourClientId},
    client_secret: {yourClientSecret},
    appBaseUrl: 'http://localhost:3000',
    redirect_uri: 'http://localhost:3000/users/callback',
    scope: "openid profile",
    routes: {
      login: {
        path: "/users/login"
      },
      callback: {
        path: "/users/callback",
        defaultRedirect: "/dashboard"
      }
    }
  });
```

  and replace everything in the brackets {} with the credentials saved from Starting the project step 2. Like below:

  ```
  var oktaClient = new okta.Client({
    orgUrl: 'https://dev-423841.okta.com',
    token: '00ZSLP0Jm4ytPKAA-c_ZDN6WDM_dd8evc3ABs04p8S'
  });

  const oidc = new ExpressOIDC({
    issuer: 'https://dev-423841.okta.com/oauth2/default',
    client_id: '0oabr9jsqpLUEqRIy356',
    client_secret: 'hCqri2hT_GUy1i-kYbueW9gTr8sm1n0w1M-RS49H',
    appBaseUrl: "http://localhost:3000",
    redirect_uri: "http://localhost:3000/dashboard",
    nonce: '235',
    response_type: 'id_token',
    response_mode: 'form_post',
    state: 'auth',
    scope: "openid profile",
    routes: {
      login: {
        path: "/users/login"
      },
      callback: {
        path: "/users/callback",
        defaultRedirect: "/dashboard"
      }
    }
  });
  ```

3. In app.js, under the following:
  ```
  app.use(session({
    secret: 'aweoihngaw4g2w34908h23wt4gawaweoik',
    resave: true,
    saveUninitialized: false
  }));
  ```

  add

  ```
    app.use(oidc.router);
  ```

  then below that add

  ```
    app.use((req, res, next) => {
      if (!req.userinfo) {
        return next();
      }

      oktaClient.getUser(req.userinfo.sub)
        .then(user => {
          req.user = user;
          res.locals.user = user;
          next();
        }).catch(err => {
          next(err);
        });
    });
  ```

4. Below the code in step 3, put the following code:
```
  function loginRequired(req, res, next) {
    if (!req.user) {
      return res.status(401).render("unauthenticated");
    }

    next();
  }
```

5. Modify the line  ```app.use('/dashboard', dashboardRouter); ```

  with

  ```app.use('/dashboard', loginRequired, dashboardRouter);```

6. Create /routes/users.js and put the following code inside it:
```
  const express = require("express");

  const router = express.Router();

  // Log a user out
  router.get("/logout", (req, res) => {
    req.logout();
    res.redirect("/");
  });

  module.exports = router;
```

7. Add the following routes at the top of app.js
```
const dashboardRouter = require("./routes/dashboard");
const publicRouter = require("./routes/public");
const usersRouter = require("./routes/users");
```

8. Scroll down below ```function loginRequired```

  and put the following code:

  ```
  app.use('/', publicRouter);
  app.use('/dashboard', loginRequired, dashboardRouter);
  app.use('/users', usersRouter);
  ```

## Styling
1. Open /public/stylesheets/style.css and replace the contents with the following:
```
  .top-bar a {
    text-decoration: none;
    color: inherit;
  }

  footer {
    border-top: 1px solid rgba(0,0,0,.1);
    margin-top: 4em !important;
    padding-top: 1em;
    text-align: center;
    margin-top: 1em;
  }

  h2 {
    margin-bottom: 2em;
  }

  .container {
    padding-top: 2em;
  }
```
