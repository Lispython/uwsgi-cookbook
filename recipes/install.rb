# -*- coding: utf-8 -*-
#
# Cookbook Name:: uwsgi cookbook
# Recipe:: install
#
# :copyright: (c) 2013 by Alexandr Lispython (alex@obout.ru).
# :license: BSD, see LICENSE for more details.
# :github: http://github.com/Lispython/uwsgi-cookbook
#

include_recipe "uwsgi::default"

node["uwsgi"]["install"]["req"].each do |pkg|
  package pkg
end

if node["uwsgi"]["install"]["method"] == "source"
  include_recipe "python"
  uwsgi_install "uwsgi" do
    version node["uwsgi"]["version"]
    provider Chef::Provider::UwsgiSource
  end

else
  uwsgi_install "uwsgi" do
    version node["uwsgi"]["version"]
    provider Chef::Provider::UwsgiPackage
  end
end
