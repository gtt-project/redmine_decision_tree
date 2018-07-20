require_relative '../test_helper'

class DecisionTreeTest < ActiveSupport::TestCase
  setup do
    @tree = DecisionTree.new DECISION_TREE
  end

  test "should have first question" do
    @tree.set_progress nil, nil
    assert_equal '', @tree.progress
    assert data = @tree.current_data
    assert_match(/how old are you/i, data['question'])
    assert answers = data['answers']
    assert_equal 2, answers.size
  end

  test "should have followup question" do
    @tree.set_progress '', '0'
    assert_equal '0', @tree.progress
    assert data = @tree.current_data
    assert_match(/where do you live/i, data['question'])
    assert answers = data['answers']
    assert_equal 2, answers.size

    @tree = DecisionTree.new DECISION_TREE
    @tree.set_progress '0', '1'
    assert_equal '0,1', @tree.progress
    assert data = @tree.current_data
    assert_match(/how do you want to vote/i, data['question'])
    assert answers = data['answers']
    assert_equal 3, answers.size
  end

  test "should recognize finished state" do
    @tree = DecisionTree.new DECISION_TREE
    @tree.set_progress '0,1', '1'
    assert @tree.finished?
    assert_equal 'postal vote', @tree.value
  end
end
