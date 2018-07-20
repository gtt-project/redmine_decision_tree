# frozen_string_literal: true

require "redmine_decision_tree/view_hooks"
require "redmine_decision_tree/field_format_patch" # intentionally breaking auto-reloading of the patch to avoid chaining of the added link on reloads

module RedmineDecisionTree


  SUPPORTED_FIELD_FORMAT_NAMES = RedmineDecisionTree::FieldFormatPatch::SUPPORTED_FIELD_FORMATS.map(&:format_name).freeze

  def self.supports_format?(format)
    SUPPORTED_FIELD_FORMAT_NAMES.include? format
  end

  def self.setup
    RedmineDecisionTree::CustomFieldPatch.apply
    RedmineDecisionTree::FieldFormatPatch.apply
  end

end
