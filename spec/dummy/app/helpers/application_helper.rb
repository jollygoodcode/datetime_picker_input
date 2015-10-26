module ApplicationHelper
  def input_html_options
    JSON.parse(ENV.fetch('INPUT_HTML_OPTIONS') { "{}" }).deep_symbolize_keys!
  end
end
