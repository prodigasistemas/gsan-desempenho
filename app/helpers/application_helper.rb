module ApplicationHelper

  def build_breadcrumb(paths)
    breadcrumbs = [{ title: "Inicio", link: root_path }]
    breadcrumbs += paths

    render "compartilhado/breadcrumb", breadcrumbs: breadcrumbs
  end

end
