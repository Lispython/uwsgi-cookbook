def whyrun_supported?
  true
end

action :create do
  Chef::Log.info("Make uwsgi instance via Base provider #{new_resource.name}")

  if @current_resource
    Chef::Log.info("#{@current_resource} already exist")
  end

  config = Chef::Mixin::DeepMerge.merge(node["uwsgi"]["config"].to_hash, new_resource.config)

  uwsgi_conf new_resource.name do
    template "uwsgi.conf.erb"
    config config
    #path new_resource.path
    wsgi new_resource.wsgi
    user new_resource.user
    group new_resource.group
    cookbook new_resource.cookbook
  end

  uwsgi_spawner "#{new_resource.name}" do
    port new_resource.port
    host new_resource.host
    path new_resource.spawner_path
    pidfile new_resource.pidfile
    released_file new_resource.released
    user new_resource.user
    group new_resource.group
  end
end
