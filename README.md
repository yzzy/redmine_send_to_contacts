# Redmine Send To Contacts

Allows sending emails with issue's details to contacts connected to this issue.

## Requirements

This plugin works only with [Redmine CRM](http://www.redmine.org/plugins/redmine_contacts) plugin or similar if

- ```Issue``` model has ```contacts``` method which returns contacts connected to this issue and
- these `Contact` objects has ```email``` method which returns string of comma-separated email addresses

## Installing

1. Clone this repository to `redmine/plugins/redmine_send_to_contacts` directory.
```
cd redmine/plugins
git clone https://github.com/yzzy/redmine_send_to_contacts.git
```
2. Clone `redmine_ajax_helper` repository
```
git clone https://github.com/yzzy/redmine_ajax_helper.git
```

3. Restart your Redmine web server.

## Removal

Just delete cloned directory and restart Redmine web server.

## License
This project is licensed under the terms of the MIT license.
