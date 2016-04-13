module Cell
  class ViewModel
    def image_tag name
      ActionController::Base.helpers.image_tag name
    end
  end
end
