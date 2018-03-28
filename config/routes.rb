# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html
match 'send/email_to_contacts', to: 'send#email_to_contacts', via: [:get, :post]
