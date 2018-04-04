module RedmineSendToContacts
  module Patches
    module IssuesControllerPatch
      def self.included(base)
        base.send :include, InstanceMethods
        base.skip_before_action :authorize, :send_email_to_contacts
      end

      module InstanceMethods
        def send_email_to_contacts
          find_issue
          @contacts = @issue.contacts
          case request.method_symbol
          when :get
            respond_to do |format|
              format.js { render layout: false }
            end
          when :post
            contact_ids = params[:contact_ids] || []
            contacts = Contact.where(id: contact_ids.flatten).all
            unless contacts.empty?
              raise_delivery_errors = ActionMailer::Base.raise_delivery_errors
              ActionMailer::Base.raise_delivery_errors = true
              begin
                Mailer.send(:issue_to_contacts, @issue, contacts.pluck(:email)).deliver
                flash[:notice] = l(:notice_email_sent, ERB::Util.h(contacts.map(&:name).join(", ")))
              rescue Exception => e
                flash[:error] = l(:notice_email_error, ERB::Util.h(Redmine::CodesetUtil.replace_invalid_utf8(e.message.dup)))
              end
              ActionMailer::Base.raise_delivery_errors = raise_delivery_errors
            else
              flash[:warning] = "No contacts selected"
            end
            respond_to do |format|
              format.js { render layout: false }
            end
          end
        end
      end

    end
  end
end

base = IssuesController
patch = RedmineSendToContacts::Patches::IssuesControllerPatch
base.send(:include, patch) unless base.included_modules.include?(patch)
