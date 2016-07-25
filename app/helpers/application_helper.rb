module ApplicationHelper

  def active_class(link_path)
    "active" if request.fullpath == link_path
  end

  def active_navigation(item, param)
  "class='active'" if params[team] == t.name
end

end
