module RedmineDecisionTree
  class ViewHooks < Redmine::Hook::ViewListener

    render_on :view_custom_fields_form_upper_box,
      partial: "redmine_decision_tree/hooks/custom_field_form_upper_box"

    render_on :view_issues_form_details_bottom,
      partial: "redmine_decision_tree/hooks/view_issues_form_details_bottom"

  end
end
