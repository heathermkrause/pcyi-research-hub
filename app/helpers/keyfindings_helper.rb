module KeyfindingsHelper
  def display_keyfindings(keyfindings)
    if keyfindings.empty?
      "{none}"
    else
      keyfindings.collect{ |kf| kf.keyfinding_text }.to_sentence
    end
  end
end
