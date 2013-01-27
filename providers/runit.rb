def whyrun_supported?
  true
end

action :create do
  Chef::Log.info("Make uwsgi instance via Monit provider #{new_resource.name}")

  uwsgi_new_resource = new_resource
  config = Chef::Mixin::DeepMerge.merge(node["uwsgi"]["config"].to_hash, uwsgi_new_resource.config)

  Chef::Log.info("-->>>#{@new_resource}")

  uwsgi_template = uwsgi_new_resource.uwsgi_template
  spawner_template = uwsgi_new_resource.spawner_template
  wsgi_template = uwsgi_new_resource.wsgi_template

  config["current"] = uwsgi_new_resource.home,
  config["project_root"] = uwsgi_new_resource.home
  config["home"] = uwsgi_new_resource.home
  config["env"] = uwsgi_new_resource.venv
  config["user"] = uwsgi_new_resource.user
  config["group"] = uwsgi_new_resource.group
  config["logfile"] = uwsgi_new_resource.logfile || "#{node["uwsgi"]["logs_dir"]}/#{uwsgi_new_resource.name}.log"
  config["pidfile"] = uwsgi_new_resource.pidfile


  wsgi "#{node["multiqa"]["uwsgi"]["wsgi"]}" do
    template wsgi_template
    user uwsgi_new_resource.user
    group uwsgi_new_resource.group
    path uwsgi_new_resource.wsgi
    config({"config" => config})
    cookbook uwsgi_new_resource.cookbook
  end

  uwsgi_conf uwsgi_new_resource.name do
    template uwsgi_template
    config config
    path uwsgi_new_resource.config_file
    home uwsgi_new_resource.home
    env uwsgi_new_resource.venv
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

  monit_conf "#{uwsgi_new_resource.name}" do
    template "uwsgi-monit.erb"
    config(:name => uwsgi_new_resource.name,
           :start_command => "#{uwsgi_new_resource.spawner_file} start",
           :stop_command => "#{uwsgi_new_resource.spawner_file} stop",
           :options => config,
           :pidfile => uwsgi_new_resource.pidfile)
    cookbook uwsgi_new_resource.cookbook || "uwsgi"
  end

  runit_service uwsgi_new_resource.name do
    template_name "uwsgi"
    action :nothing
    options(:user => uwsgi_new_resource.user,
            :group => uwsgi_new_resource.group,
            :virtualenv => uwsgi_new_resource.venv,
            :logfile => uwsgi_new_resource.logfile,
            :option => config,
            :released_file => uwsgi_new_resource.released_file,
            :config_file => uwsgi_new_resource.config_file)
    cookbook uwsgi_new_resource.cookbook || "uwsgi"
  end
end


def load_current_resource
  @current_resource = Chef::Resource::Redis.new(@new_resource.name)
  return @current_resource
end
