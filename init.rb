require 'redmine'

Redmine::Plugin.register :redmine_decision_tree do
  name 'Redmine Decision Tree plugin'
  author 'Jens Krämer, Georepublic'
  author_url 'https://github.com/georepublic'
  url 'https://github.com/gtt-project/redmine_decision_tree'
  description 'Adds decision-tree wizards to custom fields'
  version '1.3.0'

  requires_redmine version_or_higher: '3.4.0'

end

ActiveSupport::Reloader.to_prepare do
  RedmineDecisionTree.setup
end
