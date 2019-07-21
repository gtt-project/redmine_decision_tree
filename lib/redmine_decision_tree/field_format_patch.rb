module RedmineDecisionTree
  module FieldFormatPatch
    SUPPORTED_FIELD_FORMATS = [
        # this includes LinkFormat (which is a subclass of StringFormat)
        Redmine::FieldFormat::StringFormat,
        Redmine::FieldFormat::TextFormat,
    ].freeze


    def self.apply
      SUPPORTED_FIELD_FORMATS.each do |klass|
        klass.prepend self unless klass < self
      end
    end

    def edit_tag(view, tag_id, tag_name, custom_value, options={})
      super + decision_tree_tag(view, tag_id, custom_value)
    end

    private

    def decision_tree_tag(view, tag_id, custom_value)
      field = custom_value.custom_field
      if tree = field.decision_tree
        view.button_tag(I18n.t("label_decision_tree_button#{"_search" if tree.search?}"),
                        type: 'button',
                        data: { url: view.decision_tree_path(field.id, tag_id: tag_id) }, class: 'decision-tree');
      else
        ''
      end
    end

  end
end
