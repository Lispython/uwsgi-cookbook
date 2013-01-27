def whyrun_supported?
  true
end

action :create do
  Chef::Log.info("Make uwsgi instance via Base provider #{new_resource.name}")

  uwsgi_new_resource = new_resource
  config = Chef::Mixin::DeepMerge.merge(node["uwsgi"]["config"].to_hash, uwsgi_new_resource.config)

  Chef::Log.info("-->>>#{@new_resource}")

  uwsgi_template = uwsgi_new_resource.uwsgi_template
  spawner_template = uwsgi_new_resource.spawner_template

  uwsgi_conf uwsgi_new_resource.name do
    template uwsgi_template
    config config
    path uwsgi_new_resource.config_file
    home uwsgi_new_resource.home
    wsgi uwsgi_new_resource.wsgi
    pidfile uwsgi_new_resource.pidfile

    user uwsgi_new_resource.user
    group uwsgi_new_resource.group

    cookbook uwsgi_new_resource.cookbook
  end

  uwsgi_spawner uwsgi_new_resource.name do
    template spawner_template
    config_file uwsgi_new_resource.config_file
    path uwsgi_new_resource.spawner_file
    pidfile uwsgi_new_resource.pidfile
    released_file uwsgi_new_resource.released_file

    user uwsgi_new_resource.user
    group uwsgi_new_resource.group

    cookbook uwsgi_new_resource.cookbook
  end
end


def load_current_resource
  @current_resource = Chef::Resource::Redis.new(@new_resource.name)
  return @current_resource
end
