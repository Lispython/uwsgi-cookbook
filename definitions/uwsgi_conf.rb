# -*- coding: utf-8 -*-
#
# Cookbook Name:: uwsgi cookbook
# Definition:: uwsgi_conf
#
# Create uwsgi configuration file
#
# :copyright: (c) 2013 by Alexandr Lispython (alex@obout.ru).
# :license: BSD, see LICENSE for more details.
# :github: http://github.com/Lispython/uwsgi-cookbook
#

define :uwsgi_conf,
       :name => nil,
       :template => "uwsgi.conf.erb",
       :config => {},
       :user => "appuser",
       :group => "appuser",
       :cookbook => nil,
       :path => nil, # File path to locate generated uwsgi
       :home => nil,
       :env => nil,
       :wsgi => nil,
       :logfile => nil,
       :pidfile => nil do

  Chef::Log.info("Making uwsgi config for: #{params[:name]}")

  config = Chef::Mixin::DeepMerge.merge(node["uwsgi"]["config"].to_hash, params[:config])

  config["wsgi"] = params[:wsgi]
  config["pidfile"] = params[:pidfile]
  config["logfile"] = params[:logfile] || "#{node["uwsgi"]["logs_dir"]}/#{params[:name]}.log"
  config["user"] = params[:user]
  config["group"] = params[:group]
  config["home"] = params[:home]
  config["env"] = params[:env]

  template params[:path] do
    owner params[:user]
    group params[:group]
    source params[:template]
    mode 0754
    action :create
    variables(:options => config)

    # Specify location for template
    if params[:cookbook]
      cookbook params[:cookbook]
    else
      cookbook "uwsgi"
    end
  end
end
