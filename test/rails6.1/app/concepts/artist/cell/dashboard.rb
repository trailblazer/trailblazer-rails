module Artist::Cell
  class Dashboard < Trailblazer::Cell
    def theme
      options[:theme]
    end
  end
end
