require_relative '../test_helper'

class DecisionTreeTest < ActiveSupport::TestCase
  setup do
    @tree = DecisionTree.new DECISION_TREE
  end

  test "should validate json contents" do
    assert t = DecisionTree.new([1,2,3].to_json)
    refute t.valid?

    assert @tree.valid?
  end

  test "should raise on invalid json" do
    assert_raise {
      DecisionTree.new 'foobar'
    }
  end

  test "should have first question" do
    @tree.set_progress nil, nil
    assert_equal '', @tree.progress
    assert data = @tree.current_data
    assert_match(/how old are you/i, data['question'])
    assert answers = data['answers']
    assert_equal 2, answers.size
  end

  test "should have intermediate values" do
    @tree.set_progress '', '0'
    refute @tree.finished?
    assert_equal "result1", @tree.intermediate_values["field"]

    @tree = DecisionTree.new DECISION_TREE
    @tree.set_progress '0', '1'
    refute @tree.finished?
    assert_equal "result1", @tree.intermediate_values["field"]
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

  test "should search" do
    answers = [
      ["this is an answer", "0,1", "2"],
      ["another one", "0,1", "1"],
    ]
    @tree.stubs(:collect_answers).returns(answers)
    assert_equal answers, @tree.search(nil)
    assert_equal answers, @tree.search('')
    assert_equal answers, @tree.search('an')
    assert_equal [answers[0]], @tree.search('is')
  end

  test "should collect answers" do
    assert_equal [
      ["In my registered electoral office.", "0,0", "0"],
      ["In a different election office.", "0,0", "1"],
      ["Via postal voting", "0,0", "2"],
      ["I don't want to vote", "0,0", "3"],

      ["In my nearest embassy or consulate.", "0,1", "0"],
      ["Via postal voting", "0,1", "1"],
      ["I don't want to vote", "0,1", "2"],

      ["I'm younger than 18 years", "", "1"]
    ], @tree.collect_answers
  end

  test "should go back" do
    assert_equal 1, @tree.back('0,1')

    refute @tree.finished?
    assert_equal '0', @tree.progress
    assert data = @tree.current_data
    assert_match(/where do you live/i, data['question'])
    assert answers = data['answers']
    assert_equal 2, answers.size
  end

  test "should recognize finished state" do
    @tree.set_progress '0,1', '1'
    assert @tree.finished?
    assert_equal 'postal vote', @tree.value
    assert_equal "result1", @tree.intermediate_values["field"]
  end
end
