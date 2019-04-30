require_relative '../../../test/test_helper'

DECISION_TREE = <<-JSON
{
    "question": "How old are you?",
    "answers": [{
        "option": "I'm older than 18 years.",
        "intermediate_value": "result1",
        "target": "field",
        "question": "Where do you live?",
        "answers": [{
            "option": "I'm living in Germany.",
            "question": "How do you want to vote?",
            "answers": [{
                "option": "In my registered electoral office.",
                "value": "registered location"
            },{
                "option": "In a different election office.",
                "value": "different location"
            },{
                "option": "Via postal voting",
                "value": "postal vote"
            },{
                "option": "I don't want to vote",
                "value": "no vote"
            }]
        },{
            "option": "I'm living in a foreign country.",
            "question": "How do you want to vote?",
            "answers": [{
                "option": "In my nearest embassy or consulate.",
                "value": "diplomatic representation"
            },{
                "option": "Via postal voting",
                "value": "postal vote"
            },{
                "option": "I don't want to vote",
                "value": "no vote"
            }]
        }]
    },{
        "option": "I'm younger than 18 years",
        "value": "forbidden"
    }]
}

JSON

