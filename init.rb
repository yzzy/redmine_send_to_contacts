ActionDispatch::Callbacks.to_prepare do
  require 'redmine_send_to_contacts'
end

Redmine::Plugin.register :redmine_send_to_contacts do
  name 'Redmine Send To Contacts plugin'
  author 'Alexander Abramov'
  description 'This is a Redmine plugin for sending emails to contacts'
  version '0.0.1'
  url 'https://github.com/yzzy/redmine_send_to_contacts'
  author_url 'https://github.com/yzzy'
end
