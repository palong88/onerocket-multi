module ApplicationHelper

  def active_class(link_path)
    "active" if request.fullpath == link_path
  end

  def active_navigation(item, param)
  "class='active'" if params[team] == t.name
  end

  def active_class_col(param, params)
    param == params ? "active collection-item" : "collection-item" 
  end


  # def active_class_collection(params)
  # if params[:category] == params
  #   "class='active collection-item'"
  # else
  #   "class='collection-item'"
  # end


end
