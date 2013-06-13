module ApplicationHelper
  @@markdown_renderer = Redcarpet::Markdown.new(Redcarpet::Render::HTML.new(), :autolink => true)
  def sanitized_markdown(text)
     sanitizer(@@markdown_renderer.render(text))
  end

  def sanitizer(text)
    sanitize(text, :tags => %w(h1 h2 h3 h4 h5 h6 p strong b i em div span a hr), :attributes => %w(href src) ).html_safe
  end

  # Used to figure out current page for nav
  def controller?(*controller)
    controller.include?(params[:controller])
  end

  def action?(*action)
    action.include?(params[:action])
  end
end
