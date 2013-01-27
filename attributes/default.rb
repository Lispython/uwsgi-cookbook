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
default["uwsgi"]["install"]["method"] = "package"

default["uwsgi"]["install"]["location"] = "http://projects.unbit.it/downloads/"
default["uwsgi"]["install"]['prefix'] = "uwsgi-"
default["uwsgi"]["install"]["download_dir"] = "/tmp"

default["uwsgi"]["version"] = "1.4.4"
default["uwsgi"]["user"] = "appuser"
default["uwsgi"]["group"] = "appuser"
default["uwsgi"]["provider"] = "uwsgi_base" # Launcher


# Config parameters
# MAIN
default["uwsgi"]["config"] = {}
