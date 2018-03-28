module RedmineSendToContacts
  module Hooks
    class ViewsIssuesHook < Redmine::Hook::ViewListener
      render_on :view_issues_context_menu_end, partial: 'issues/send_to_contacts_context_menu'
    end
  end
end
