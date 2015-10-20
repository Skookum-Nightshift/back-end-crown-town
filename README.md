## Development

### Set up .env

- rename `example.env` to `.env`

```
RACK_ENV=development
# RACK_ENV=none
RAILS_ENV=development
DOMAIN=.lvh.me
TLD_LENGTH=1
PORT=3000

# S3
S3_BUCKET=placeholder
S3_KEY_ID=placejolder
S3_SECRET=placeholder
S3_REGION=us-west-2

DEVISE_SECRET=placeholder

STRIPE_SECRET=placeholder
STRIPE_PUBLISHABLE=placeholder
```

### Set up Vagrant Dev Environment
* Download and install Vagrant (https://www.vagrantup.com/) and VirtualBox (https://www.virtualbox.org/wiki/Downloads)
* Run `vagrant plugin install vagrant-vbguest` in the terminal
* Run `vagrant up` in the terminal, in the project folder (First time will take a while...It has to download everything.)
* `vagrant ssh` once that is complete. That will log you into the virtual machine
* `cd /vagrant` will move you into the virtual project folder which is mirrored from your local machine
* `bundle`
* `rake db:migrate`
* `rails s -b 0.0.0.0` This starts the server and forwards the port to localhost:3000 on your local machine
* I can explain more next Monday, but this will give us a consistent dev environment, especially on Windows!


### Run
- make sure that `log/development.log` exists if not run `rails s`
- then run by calling `foreman start`

### Authenticated Ajax requests

A header has to be passed to authenticate a route

```
{
  'Authorization': `Bearer ${auth_token}`
}
```

The authorization token is passed back after a successful `post` to the `sign_in` route
