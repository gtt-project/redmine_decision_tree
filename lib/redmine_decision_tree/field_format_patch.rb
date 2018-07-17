module RedmineDecisionTree
  module FieldFormatPatch
    def self.apply
      RedmineDecisionTree::SUPPORTED_FIELD_FORMATS.each do |klass|
        klass.prepend self
      end
    end

    def edit_tag(view, tag_id, tag_name, custom_value, options={})
      super + decision_tree_tag(view, tag_id, custom_value)
    end

    private

    def decision_tree_tag(view, tag_id, custom_value)
      field = custom_value.custom_field
      obj = JSON.parse(field.decision_tree_json) rescue nil
      return if obj.blank?

      tree_json_var = "#{tag_id}_decision_tree"

      view.content_tag(:a, 'tree', href: "#",
                                   class: "decision-tree-trigger",
                                   data: { tree_json: tree_json_var }) +
      view.javascript_tag(<<-JS
        window.#{tree_json_var} = #{obj.to_json};
      JS
      )
    end

  end
end
