# -*- coding: utf-8 -*-
#
# Cookbook Name:: uwsgi cookbook
#
# :copyright: (c) 2013 by Alexandr Lispython (alex@obout.ru).
# :license: BSD, see LICENSE for more details.
# :github: http://github.com/Lispython/uwsgi-cookbook
#

# Global params

default["uwsgi"]["install"]["req"] = %w(python-dev libxml2 libxml2-dev)
default["uwsgi"]["install"]["method"] = "source"

default["uwsgi"]["install"]["location"] = "http://projects.unbit.it/downloads/"
default["uwsgi"]["install"]['prefix'] = "uwsgi-"
default["uwsgi"]["install"]["download_dir"] = "/tmp"

default["uwsgi"]["version"] = "1.4.4"
default["uwsgi"]["user"] = "www-data"
default["uwsgi"]["group"] = "www-data"
default["uwsgi"]["provider"] = "uwsgi_base" # Launcher


# Config parameters
# MAIN
default["uwsgi"]["config"] = {
  "processes" => 4,
  "user" => node["uwsgi"]["user"],
  "group" => node["uwsgi"]["group"],
  "no-orphas" => true,
  "log-master" => true,
  "master" => true,
  "reload-on-as" => 128,
  "memory-report" => true,
  "log-slow" => 30,
  "log-5xx" => false,
  "log-4xx" => false,
  "harakiri" => 60,
  "reload-mercy" => 8,
  "python_version" => "python2.6"
}

default["uwsgi"]["logs_dir"] = "/var/log/uwsgi"
default["uwsgi"]["pids_dir"] = "/tmp"
