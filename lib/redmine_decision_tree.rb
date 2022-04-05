# frozen_string_literal: true

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
