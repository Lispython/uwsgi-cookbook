def whyrun_supported?
  true
end

action :install do
  Chef::Log.info("Install uwsgi from source #{new_resource.name}")

  if @current_resource
    Chef::Log.info("#{@current_resource} already exist")
  end

  config = Chef::Mixin::DeepMerge.merge(node["uwsgi"]["default"].to_hash, new_resource.config)

end
