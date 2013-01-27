# -*- coding: utf-8 -*-
#
# Cookbook Name:: uwsgi cookbook
# Definition:: wsgi
#
# Making wsgi configuration file
#
# :copyright: (c) 2013 by Alexandr Lispython (alex@obout.ru).
# :license: BSD, see LICENSE for more details.
# :github: http://github.com/Lispython/uwsgi-cookbook
#

define :wsgi, :name => nil, :template => "wsgi.erb", :config => {}, :user => "appuser", :group => "appuser",
:cookbook => nil, :path => nil do

  Chef::Log.info("Making wsgi config for: #{params[:name]}")

  # Creating wsgi config
  template params[:path] do
    owner params[:user]
    group params[:group]
    source params[:template]
    mode 0755
    action :create
    variables params[:config].to_hash

    # Specify location for template
    if params[:cookbook]
      cookbook params[:cookbook]
    else
      cookbook "uwsgi"
    end
  end
end
