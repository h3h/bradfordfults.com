module ApplicationHelper
  # Prevents widows in titles by replacing the last space with a non-breaking space
  def widont(text)
    return text if text.blank?

    words = h(text).split(" ")
    return text if words.length <= 1

    last_word = words.pop
    "#{words.join(' ')}&nbsp;#{last_word}".html_safe
  end
end
