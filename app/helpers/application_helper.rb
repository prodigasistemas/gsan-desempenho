module ApplicationHelper

  def build_breadcrumb(paths)
    breadcrumbs = [{ title: "Inicio", link: root_path }]
    breadcrumbs += paths

    render "compartilhado/breadcrumb", breadcrumbs: breadcrumbs
  end

  def input_search(model)
    content_tag :div, class: "search-form" do
      smart_listing_controls_for model do
        content_tag :div, class: "filter input-append form-group" do
          concat text_field_tag :filter, '', class: "search input-search", placeholder: "Pesquisar", autocomplete: "off"
          concat button_search
        end
      end
    end
  end

  private
  def button_search
    button_tag :submit, class: "btn", disabled: true do
       content_tag :i, '', class: "fa fa-search"
    end
  end
end
