def whyrun_supported?
  true
end

action :install do
  Chef::Log.info("Install uWSGI from package #{new_resource.name}")

  Chef::Log.info("Current installed uWSGI #{version()} and candidate version #{new_resource.version}")


  unless version() == @new_resource.version
    package "libssl0.9.8" do
      action :upgrade
    end

    package "uwsgi" do
      version node["uwsgi"]["version"]
      action :install
    end
  end
end

action :uninstall do
  Chef::Log.info("Uninstall uWSGI")

  package "uwsgi" do
    action :remove
    version node["uwsgi"]["version"]
  end
end



def load_current_resource
  @current_resource = Chef::Resource::RedisInstall.new(@new_resource.name)
  @current_resource.version(version())
  @current_resource
end

def uwsgi_exists?
  exists = Chef::ShellOut.new("which uwsgi")
  exists.run_command
  exists.exitstatus == 0 ? true : false
end

def version
  if uwsgi_exists?
    uwsgi_version = Chef::ShellOut.new("uwsgi --version")
    uwsgi_version.run_command
    version = uwsgi_version.stdout[/uWSGI (\d*.\d*.\d*)/,1] || uwsgi_version.stdout[/(\d*.\d*.\d*)/,1]
    Chef::Log.info("The uWSGI server version is: #{version}")
    return version.gsub("\n",'')
  end
  nil
end
