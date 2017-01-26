class <%= class_name %>::Create < Trailblazer::Operation
  step Model(<%= class_name %>, :new)
  step Contract::Build(constant: <%= class_name %>::Contract::Create)
  step Contract::Validate(key: :<%= plural_name.singularize %>)
  step Contract::Persist()
end
