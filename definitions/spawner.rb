# -*- coding: utf-8 -*-
#
# Cookbook Name:: uwsgi cookbook
# Definition:: spawner
#
# :copyright: (c) 2013 by Alexandr Lispython (alex@obout.ru).
# :license: BSD, see LICENSE for more details.
# :github: http://github.com/Lispython/uwsgi-cookbook
#


define :uwsgi_spawner,
       :name => nil,
       :template => "spawner.erb",
       :pidfile => nil,
       :cookbook => nil,
       :config_file => nil,
       :path => nil,
       :released_file => nil do

  Chef::Log.info("Creating spawner at #{params[:path]} from #{params[:template]} for #{params[:name]} project")

  path = params[:path] || params[:name]

  # Making init.d script
  template path do
    owner params[:user]
    group params[:group]
    source params[:template]
    mode 0754
    action :create

    variables(
              :name => params[:name],
              :user => params[:user],
              :group => params[:group],
              :pidfile => params[:pidfile],
              :config_file => params[:config_file],
              :released_file => params[:released_file]
              )

    # Specify location for template
    if params[:cookbook]
      cookbook params[:cookbook]
    else
      cookbook "uwsgi"
    end
  end
end
