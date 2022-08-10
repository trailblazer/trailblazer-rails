module Artist::Cell
  class New < Trailblazer::Cell
    def filtered_options
      options.except(:context)
    end
  end
end
