require File.expand_path('../lib/redmine_decision_tree/view_hooks', __FILE__)
require File.expand_path('../lib/redmine_decision_tree/field_format_patch', __FILE__) # intentionally breaking auto-reloading of the patch to avoid chaining of the added link on reloads

Redmine::Plugin.register :redmine_decision_tree do
  name 'Redmine Decision Tree plugin'
  author 'Jens Krämer, Georepublic'
  author_url 'https://github.com/georepublic'
  url 'https://github.com/gtt-project/redmine_decision_tree'
  description 'Adds decision-tree wizards to custom fields'
  version '1.3.0'

  requires_redmine version_or_higher: '3.4.0'

end

if Rails.version > '6.0' && Rails.autoloaders.zeitwerk_enabled?
  RedmineDecisionTree.setup
else
  require 'redmine_decision_tree'
  ActiveSupport::Reloader.to_prepare do
    RedmineDecisionTree.setup
  end
end
