# -*- coding: utf-8 -*-
#
# Cookbook Name:: uwsgi cookbook
# Definition:: spawner
#
# :copyright: (c) 2013 by Alexandr Lispython (alex@obout.ru).
# :license: BSD, see LICENSE for more details.
# :github: http://github.com/Lispython/uwsgi-cookbook
#


define :uwsgi_spawner, :name => nil, :template => "spawner.erb", :port => nil, :host => nil, :pidfile => nil, :cookbook => nil, :config_file => nil,:path => nil do

  Chef::Log.info("Creating uwsgi init.d at : #{params[:path]} from #{params[:template]}")

  path = params[:path]

  # Making init.d script
  template params[:path] do
    owner params[:user]
    group params[:group]
    source params[:template]
    mode 0754
    action :create

    variables :port => params[:port], :pidfile => params[:pidfile], :config_file => params[:config_file],

    # Specify location for template
    if params[:cookbook]
      cookbook params[:cookbook]
    else
      cookbook "uwsgi"
    end
  end
end
