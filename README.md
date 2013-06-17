puppet-sematext
==================

Description
-----------

A Puppet report handler for sending metrics to Sematext.

Requirements
------------

* `sematext-metrics`
* `puppet` (version 2.6.5 and later)

Installation & Usage
--------------------

1. Create a Sematext Apps account: https://apps.sematext.com/

2. Retrieve your Token

3.  Install the `sematext-metrics` gem on your Puppet master

        $ sudo gem install sematext-metrics

4.  Install puppet-sematext as a module in your Puppet master's module
    path.

5.  Update the `token` variable in the `sematext.yaml` file with
    your sematext token.

6.  Copy `sematext.yaml` to `/etc/puppet`.

7.  Enable pluginsync and reports on your master and clients in `puppet.conf`

        [master]
        report = true
        reports = sematext
        pluginsync = true
        [agent]
        report = true
        pluginsync = true

8.  Run the Puppet client and sync the report as a plugin

Author
------

James Turnbull <james@lovedthanlost.net>

License
-------

    Author:: James Turnbull (<james@lovedthanlost.net>)
    Copyright:: Copyright (c) 2013 James Turnbull
    License:: Apache License, Version 2.0

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
