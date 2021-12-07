module Song::Contract
  class Create < Reform::Form
    property :id
    property :title
  end
end
