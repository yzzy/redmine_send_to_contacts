module RedmineSendToContacts
  module Hooks
    class ViewsIssuesHook < Redmine::Hook::ViewListener
      render_on :view_issues_context_menu_end, partial: 'issues/send_to_contacts_context_menu'
      render_on :view_layouts_base_html_head, partial: 'send/header_assets'
    end
  end
end
