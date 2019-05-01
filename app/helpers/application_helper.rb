module ApplicationHelper
  # Formats the html title tag to show the page title with the application name
  def page_title(title = '')
    base = "Vidon"
    if title.empty?
      return base
    else
      return title + " | " + base
    end
  end
end
