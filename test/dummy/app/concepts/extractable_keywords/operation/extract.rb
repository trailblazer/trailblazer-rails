module ExtractableKeywords
  module Operation
    class Extract < Trailblazer::Operation
      step :add_keywords
      
      def add_keywords(context, **)
        context[:keyword_1] = 'That'
        context[:keyword_2] = 'worked'
      end
    end
  end
end
