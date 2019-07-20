match "decision_tree/:field_id", as: "decision_tree", to: "decision_trees#show", via: %i(get post)
match "decision_tree/:field_id/search", as: "search_decision_tree", to: "decision_trees#search", via: :get
