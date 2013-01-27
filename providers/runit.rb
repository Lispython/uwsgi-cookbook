def whyrun_supported?
  true
end

action :create do
  Chef::Log.info("Make uwsgi instance via Runit provider #{new_resource.name}")

  if @current_resource
    Chef::Log.info("#{@current_resource} already exist")
  end

  config = Chef::Mixin::DeepMerge.merge(node["uwsgh"]["default"].to_hash, new_resource.config)

end
