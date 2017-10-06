require 'mechanize'

module ApplicationHelper

  def gsan_form_for(model, options = {}, &block)
    if model.id.present?
      method = :patch
      action = :update
    else
      method = :post
      action = :create
    end

    options[:method] = method
    options[:url] = { action: action }

    form_for(model, options, &block)
  end

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

  def build_action_header(name="", models)
    edit_path = "edit_"
    destroy_path = ""

    models.each do |model|
      edit_path += "#{model.class.to_s.underscore}_"
      destroy_path += "#{model.class.to_s.underscore}_"
    end
    edit_path += "path"
    destroy_path += "path"

    render 'compartilhado/action_header', name: name, models: models, edit_path: edit_path, destroy_path: destroy_path
  end

  def table_label(label)
    content_tag :td, class: "table-label" do
      content_tag :strong, label
    end
  end

  def label_arquivo situacao
    if situacao == 'pendente'
      "<span class='label label-warning'>pendente</span>".html_safe
    elsif situacao == 'concluido'
      "<span class='label label-success'>concluido</span>".html_safe
    else
      "<span class='label label-danger'>falha</span>".html_safe
    end
  end

  def show_errors(object, field_name)
    if object.errors.present?
      if !object.errors.messages[field_name].blank?
        object.errors.messages[field_name].join(", ")
      end
    end
  end

  STRING_COMUM = "javascript:abrirPopup('gerarRelatorio2ViaContaAction.do?cobrarTaxaEmissaoConta=N&idConta='"
  def obter_ids_contas_gsan(matricula)
    ids = Rails.cache.read(:ids_gsan)
    return ids if not ids.nil?

    ids = []
    a = Mechanize.new
    a.get(ENV['GSAN_SEGUNDA_VIA_PATH']) do |page|

      my_page = page.form_with(:name => 'EmitirSegundaViaContaInternetActionForm') do |f|
        f.matricula = matricula
      end.submit

      my_page.links.each do |link|
        if link.href.start_with? STRING_COMUM
          ids << link.href.split("+").second.split(",").first
        end
      end
    end

    Rails.cache.write(:ids_gsan, ids)
    ids
  end

  def link_para_impressao(id_conta)
    "#{ENV['GSAN_IMPRIMIR_SEGUNDA_VIA_PATH']}#{id_conta}"
  end

  private
  def button_search
    button_tag :submit, class: "btn", disabled: true do
       content_tag :i, '', class: "fa fa-search"
    end
  end
end
