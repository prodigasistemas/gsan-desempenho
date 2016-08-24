module MenuHelper

#   def list_tag(menu)
#     html = content_tag(:div){
#       class: "row",
#       content_tag(:div){
#         class: "col-md-4 m-b-lg",

#         menu.each do |item|
#           list_tag item.submenu if item.descricao == "Gsan"
#           list_tag item.submenu unless item.submenu.blank?

#         end
#       }
#     }.html_safe


#     menu.each do |item|
#       list_tag item.submenu if item.descricao == "Gsan"
#       list_tag item.submenu unless item.submenu.blank?


#     end

#     html = content_tag(:ul) {
#       ul_contents = ""
#       ul_contents << content_tag(:li, hash[:parent])
#       hash[:children].each do |child|
#         ul_contents << hash_list_tag(child)
#       end

#       ul_contents.html_safe
#     }.html_safe
#   end


#   <div class="row">
#   <div class="col-md-4 m-b-lg">
#     <div class="panel panel-default">
#       <!-- Default panel contents -->
#       <div class="panel-heading">Panel heading</div>

#       <!-- List group -->
#       <ul class="list-group">
#         <li class="list-group-item">Cras justo odio</li>
#         <li class="list-group-item">Dapibus ac facilisis in</li>

#         <li class="list-group-item">
#           <div class="panel-group">
#             <div class="panel panel-default">






#   private
#   def list_build(menu)
#       menu.each do |item|
#       list_build item.submenu if item.descricao == "Gsan"
#       list_build item.submenu unless item.submenu.blank?


#     end
#   end
end