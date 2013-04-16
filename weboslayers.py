# Copyright (c) 2008-2013  Hewlett-Packard Development Company, L.P.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# This implementation introduces next generation build environment for
# Open webOS. The change introduces a mechanism to add additional layers to the
# base ones: oe-core, meta-oe, and meta-webos, and to specify the commits to be
# used for each. mcf now expects the layers to be defined in this file
# (weboslayers.py in the same directory as mcf) as a list of Python data tuples:
#
# webos_layers = [
# ('layer-name', priority, 'URL', 'submission', 'working-dir'),
# ...
# ]
#
# where:
#
# layer-name  = Unique identifier; it represents the layer directory containing
#               conf/layer.conf.
#
# priority    = Integer layer priority as defined by OpenEmbedded. It also
#               specifies the order in which layers are searched for files.
#               Larger values have higher priority. A value of -1 indicates
#               that the entry is not a layer; for example, bitbake.
#
# URL         = The Git repository address for the layer from which to clone.
#               A value of '' skips the cloning.
#
# submission  = The information use by Git to checkout and identify the precise
#               content. Submission values could be "branch=<name>" and
#               "commit=<id>" or "tag=<tag>". Omitted branch information means
#               only that "work_branch" will be used as the name of the local
#               branch (and note that specifying "branch=master" surprisingly
#               results in an error). Omitted commit or tag means origin/HEAD
#               will be checked out (which might NOT be origin/master, although
#               it usually is).
#
# working-dir = Alternative directory for the layer.
#
# mcf also supports machine-specific layers: if this file defines a
# webos_layers_<machine> list, it will be processed after the webos_layers
# list.
#
# The name of the distribution is also defined in this file.
#

Distribution = "webos"

# github.com/openembedded repositories are read-only mirrors of the authoritative
# repositories on git.openembedded.org
webos_layers = [
('bitbake',               -1, 'git://github.com/openembedded/bitbake.git',        'branch=1.16,commit=571d88c', ''),
('meta',                   5, 'git://github.com/openembedded/oe-core.git',        'branch=danny,commit=d961e42', ''),
('meta-oe',                6, 'git://github.com/openembedded/meta-oe.git',        'branch=danny,commit=ba80b77', ''),
('meta-networking',        6, 'git://github.com/openembedded/meta-oe.git',        '', ''),

('meta-webos-backports',   9, 'git://github.com/openwebos/meta-webos-backports.git', '', ''),
('meta-webos',            10, 'git://github.com/openwebos/meta-webos.git',        '', ''),
]
