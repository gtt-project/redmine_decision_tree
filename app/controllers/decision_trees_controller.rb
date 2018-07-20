class DecisionTreesController < ApplicationController

  before_action :authorize

  def show
    @field = CustomField.find params[:field_id]
    tree = DecisionTree.new @field.decision_tree_json
    tree.set_progress params[:progress], params[:answer]

    if tree.finished?
      @value = tree.value
    else
      data = tree.current_data
      @question = data['question']
      @answers = data['answers']
      @progress = tree.progress
    end

    respond_to :js
  end

  private

  def authorize
    # TODO get projects where CF is active, check user's access to these (?)
  end

end
