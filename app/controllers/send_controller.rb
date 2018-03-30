class SendController < ApplicationController
  unloadable

  def email_to_contacts
    if params[:object_type] == 'issue' && params[:object_id] && @issue = Issue.find_by(id: params[:object_id])
      @contacts = @issue.contacts
      @project = @issue.project
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
