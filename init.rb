require 'redmine'

Redmine::Plugin.register :redmine_decision_tree do
  name 'Redmine Decision Tree plugin'
  author 'Jens Kraemer, Georepublic'
  author_url 'https://hub.georepublic.net/gtt/redmine_decision_tree'
  description 'Adds decision-tree wizards to custom fields'
  version '0.1.0'

  requires_redmine version_or_higher: '3.4.0'

end

ActionDispatch::Callbacks.to_prepare do
  RedmineDecisionTree.setup
end

