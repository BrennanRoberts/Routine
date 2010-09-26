module ApplicationHelper
	def link_to_add_fields(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", :f => builder)
    end
    link_to_function(name, "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")")
  end
  
  def new_child_fields_template(form_builder, association, options = {})
	  options[:object] ||= form_builder.object.class.reflect_on_association(association).klass.new
	  options[:partial] ||= association.to_s.singularize
	  options[:form_builder_local] ||= :f
	
	  content_for :jstemplates do
	    content_tag(:table, :id => "#{association}_fields_template", :style => "display: none") do
	      form_builder.fields_for(association, options[:object], :child_index => "new_#{association}") do |f|        
	        render(:partial => options[:partial], :locals => { options[:form_builder_local] => f })        
	      end
	    end
	  end
	end
	
	def add_child_link(name, association)
	  link_to(name, "javascript:void(0)", :class => "add_child", :"data-association" => association)
	end
	
	def remove_child_link(name, f)
	  f.hidden_field(:_destroy) + link_to(name, "javascript:void(0)", :class => "remove_child")
	end
end
