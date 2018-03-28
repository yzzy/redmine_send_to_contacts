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
        Mailer.send(:issue_to_contacts, @issue, contacts.pluck(:email)).deliver
        render nothing: true, status: :ok
      end
    end
  end
end
