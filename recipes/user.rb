#
# Cookbook Name:: uwsgi
# Recipe:: uwsr
#
# Copyright 2013, Alexandr Lispython (alex@oout.ru)
#
# All rights reserved - Do Not Redistribute
#

group node["uwsgi"]["group"] do
  action :create
  system true
  not_if "grep #{node['uwsgi']['group']} /etc/group"
end

user node["uwsgi"]["user"] do
  comment "uwsgi service user"
  gid node["uwsgi"]["group"]
  system true
  shell "/bin/bash"
  action :create
  not_if "grep #{node['uwsgi']['user']} /etc/passwd"
end
