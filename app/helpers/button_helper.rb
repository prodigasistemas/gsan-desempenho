module ButtonHelper
  def build_button(title, model, path, method='get', disabled=false)
      link_to path,
      title: title,
      class: "#{setup_class(title)}",
         id: "#{title}-#{model.class.name.downcase}-#{model.id}", "data-method" => method, disabled: disabled do
      content_tag :i, "", class: "#{self.send(title.to_sym)}"
    end
  end

  def build_header_button(title, model, path, method="get", disabled=false)
      path = "#" if disabled
      link_to path,
      class: "#{setup_class(title)}",
         id: "btn-#{title}-#{model}", "data-method" => method,  disabled: disabled do
      content_tag(:i, "", class: "#{self.send(title.to_sym)}") + " #{title.capitalize}"
    end
  end

  private

  def setup_class(button)
    return 'btn btn-primary' unless ['cancel', 'remove'].include? button

    'btn btn-danger'
  end

  def editar
    "fa fa-pencil-square-o"
  end

  def novo
    "fa fa-plus"
  end

  def adicionar
    "fa fa-plus"
  end

  def remover
    "fa fa-close"
  end
end