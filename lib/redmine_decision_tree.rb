# frozen_string_literal: true

require "redmine_decision_tree/view_hooks"

module RedmineDecisionTree

  SUPPORTED_FIELD_FORMATS = [
      Redmine::FieldFormat::StringFormat,
      Redmine::FieldFormat::TextFormat,
  ].freeze

  SUPPORTED_FIELD_FORMAT_NAMES = SUPPORTED_FIELD_FORMATS.map(&:format_name).freeze

  def self.supports_format?(format)
    SUPPORTED_FIELD_FORMAT_NAMES.include? format
  end

  def self.setup
    RedmineDecisionTree::CustomFieldPatch.apply
    RedmineDecisionTree::FieldFormatPatch.apply
  end

end
