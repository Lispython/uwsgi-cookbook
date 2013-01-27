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

define :uwsgi_conf, :name => nil, :template => "uwsgi.conf.erb", :config => {}, :user => "appuser", :group => "appuser", :cookbook => nil do

  Chef::Log.info("Making uwsgi config for: #{params[:name]}")
end
