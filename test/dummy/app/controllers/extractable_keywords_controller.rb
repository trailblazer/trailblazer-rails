class ExtractableKeywordsController < ApplicationController
  def extract_one
    run ExtractableKeywords::Operation::Extract do |_ctx, keyword_1:, **|
      render plain: "#{keyword_1}"
    end
  end
  
  def extract_all
    run ExtractableKeywords::Operation::Extract do |_ctx, keyword_1:, keyword_2:, **|
      render plain: "#{keyword_1} #{keyword_2}"
    end
  end
end
