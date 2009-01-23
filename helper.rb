def translate_for(item, options = {})
	model_name = item.scan(/(\w+).\w+.\w+/).flatten[0]
	
	with_options :scope => "activerecord.models" do |w|
		options[:model] ||= w.t model_name, :count => 1, :default => model_name
		options[:models] ||= w.t(model_name, :count => 2, :default => model_name.pluralize).gsub(/\d+/, '').strip
	end
	
	default_item = item.gsub(model_name, 'default')
	base = "actionview.actions"
	t "#{base}.#{item}", options.reverse_merge(:default => t( "#{base}.#{default_item}", options))
end

def translate_save(object_name)
	object_instance = instance_variable_get("@#{object_name}")
	action = object_instance.new_record? ? "new" : "edit"
	translate_for("#{object_name.to_s}.#{action}.save_button_name")
end

## Yaml file belongs to 
# def translate_for(item, options = {})
# 	model_name = item.scan(/(\w+).\w+.\w+/).flatten[0]
# 	
# 	with_options :scope => "activerecord.models" do |w|
# 		options[:model] ||= w.t model_name, :count => 1, :default => model_name
# 		options[:models] ||= w.t(model_name, :count => 2, :default => model_name.pluralize).gsub(/\d+/, '').strip
# 	end
# 	
# 	default_item = item.gsub(model_name, 'default')
# 	base = "actionview.actions"
# 	t "#{base}.#{item}", options.reverse_merge(:default => t( "#{base}.#{default_item}", options))
# end
# 
# def translate_save(object_name)
# 	object_instance = instance_variable_get("@#{object_name}")
# 	action = object_instance.new_record? ? "new" : "edit"
# 	translate_for("#{object_name.to_s}.#{action}.save_button_name")
# end