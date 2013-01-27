# -*- coding: utf-8 -*-
#
# Cookbook Name:: uwsgi cookbook
# Recipe:: default

# Create uwsgi application configuration
#
# :copyright: (c) 2013 by Alexandr Lispython (alex@obout.ru).
# :license: BSD, see LICENSE for more details.
# :github: http://github.com/Lispython/uwsgi-cookbook
#

actions :create

attribute :name, :kind_of => String, :name_attribute => true

attribute :user, :kind_of => String, :default => "appuser"
attribute :group, :kind_of => String, :default => "appuser"
attribute :config, :kind_of => Hash, :default => {}
attribute :cookbook, :kind_of => String
attribute :spawner_path, :kind_of => String # Path to spawner file
attribute :released_file, :kind_of => String
attribute :wsgi, :kind_of => String
attribute :path, :kind_of => String
attribute :pidfile, :kind_of => String

def initialize(*args)
  super
  @action = :create
  @sub_resources = []
  @provider = Chef::Provider::UwsgiBase
end
