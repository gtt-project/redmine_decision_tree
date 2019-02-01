require_relative '../test_helper'

class DecisionTreesTest < Redmine::IntegrationTest
  fixtures :users, :email_addresses, :user_preferences,
    :roles, :projects, :members, :member_roles, :issues

  def setup
    super
    User.current = nil
    @project = Project.find 'ecookbook'
    EnabledModule.delete_all
    EnabledModule.create! project: @project, name: 'issue_tracking'
    @issue = @project.issues.first
    @cf = IssueCustomField.create! projects: [@project], name: 'wizard', decision_tree_json: DECISION_TREE, field_format: 'string', visible: false, role_ids: [ 1 ]
  end

  def test_no_access_for_anonymous
    get "/decision_tree/#{@cf.id}", xhr: true
    assert_response 401
  end

  def test_tree
    log_user 'jsmith', 'jsmith'

    get "/decision_tree/#{@cf.id}", xhr: true
    assert_response :success
    assert_match(/how old are you/i, @response.body)

    get "/decision_tree/#{@cf.id}", xhr: true, params: { progress: '', answer: '0'}
    assert_response :success
    assert_match(/where do you live/i, @response.body)

  end

end


