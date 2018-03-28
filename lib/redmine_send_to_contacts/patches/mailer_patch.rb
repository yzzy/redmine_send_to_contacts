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
          mail to: contacts, cc: [], subject: "[#{issue.project.name} - #{issue.tracker.name} ##{issue.id}] (#{issue.status.name}) #{issue.subject}"
        end
      end

    end
  end
end

base = Mailer
patch = RedmineSendToContacts::Patches::MailerPatch
base.send(:include, patch) unless base.included_modules.include?(patch)
