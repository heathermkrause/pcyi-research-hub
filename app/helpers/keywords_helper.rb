module KeywordsHelper
  def display_keywords(keywords)
    if keywords.empty?
      "{none}"
    else
      keywords.collect{|kw| kw.keyword_text.lstrip.rstrip}.to_sentence(last_word_connector: ", ")
    end
  end
end
