class <%= class_name %>::New < Trailblazer::Operation
  step Model(<%= class_name %>, :new)
  step Contract::Build(constant: <%= class_name %>::Contract::Create)
end
