module ApplicationHelper
  @@markdown_renderer = Redcarpet::Markdown.new(Redcarpet::Render::HTML, :autolink => true)
  def markdown(text)
    @@markdown_renderer.render(text).html_safe
  end

  # Used to figure out current page for nav
  def controller?(*controller)
    controller.include?(params[:controller])
  end

  def action?(*action)
    action.include?(params[:action])
  end
end
