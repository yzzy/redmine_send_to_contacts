module RedmineSendToContacts
  module Patches
    module MailerPatch
      def self.included(base)
        base.send :include, InstanceMethods
      end

      module InstanceMethods
        def issue_to_contacts(issue, contacts)
          @issue = issue
          @issue_url = url_for(:controller => 'issues', :action => 'show', :id => issue)
          @users = contacts
          mail to: contacts, cc: [], subject: "Test sending issue to contacts"
        end
      end

    end
  end
end

base = Mailer
patch = RedmineSendToContacts::Patches::MailerPatch
base.send(:include, patch) unless base.included_modules.include?(patch)
