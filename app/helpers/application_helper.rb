module ApplicationHelper
  def link_to_add_fields(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", :f => builder)
    end
    link_to_function(name, "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")")
  end
  
  def add_child_link(name, association)
    link_to(name, "javascript:void(0)", :class => "add_child", :"data-association" => association)
  end
  
  def remove_child_link(name, f)
    f.hidden_field(:_destroy) + link_to(name, "javascript:void(0)", :class => "remove_child")
  end
  
  def get_muscle_group_bubbles(mgs)
    html = ""
    mgs.each do |mg|
      html << muscle_group_tag(mg)
    end
    html.html_safe
  end
  
  def muscle_group_tag(mg)
    content_tag(:span, content_tag(:span, mg.name, :class=> "muscle-bubble-inner"), :class =>"muscle-bubble muscle-group-border #{mg.name.downcase}")
  end
end
