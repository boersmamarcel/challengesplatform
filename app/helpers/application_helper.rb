module ApplicationHelper
  @@markdown_renderer = Redcarpet::Markdown.new(Redcarpet::Render::HTML, :autolink => true)
  def markdown(text)
    @@markdown_renderer.render(text).html_safe
  end
end
