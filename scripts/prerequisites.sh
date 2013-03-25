#!/bin/sh -e

# Copyright (c) 2008-2013 Hewlett-Packard Development Company, L.P.
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

# This has only been tested on Ubuntu-12.04 amd64.

check_sanity=true
usage="$0 [--help|-h|-H] [--version|-v|-V]"
version="1.0.0"

for i ; do
    case "$i" in
        --help|-h|-H) echo ${usage}; exit 0 ;;
        --version|-v|-V) echo ${version}; exit 0 ;;
        *)
            echo Unrecognized option: $i 1>&2
            echo ${usage}
            exit 1
            ;;
    esac
done

sane=true

distributor_id=`/usr/bin/lsb_release -s -i`
release=`/usr/bin/lsb_release -s -r`
codename=`/usr/bin/lsb_release -s -c`
arch=`/usr/bin/dpkg --print-architecture`

distributor_id_sane="^((Ubuntu))$"
release_sane="^((12.04)|(12.10))$"
codename_sane="^((precise)|(quantal))$"
arch_sane="^((i386)|(amd64))$"

case "${check_sanity}" in
    true)
        if [ ! -x /usr/bin/lsb_release ] ; then
            echo 'WARNING: /usr/bin/lsb_release not available, cannot test sanity of this system.' 1>&2
            sane=false
        else
            if ! echo "${distributor_id}" | egrep -q "${distributor_id_sane}"; then
                echo "WARNING: Distributor ID reported by lsb_release '${distributor_id}' not in '${distributor_id_sane}'" 1>&2
                sane=false
            fi

            if ! echo "${release}" | egrep -q "${release_sane}"; then
                echo "WARNING: Release reported by lsb_release '${release}' not in '${release_sane}'" 1>&2
                sane=false
            fi

            if ! echo "${codename}" | egrep -q "${codename_sane}"; then
                echo "WARNING: Codename reported by lsb_release '${codename}' not in '${codename_sane}'" 1>&2
                sane=false
            fi
        fi

        if ! echo "${arch}" | egrep -q "${arch_sane}"; then
            echo "WARNING: Architecture reported by dpkg --print-architecture '${arch}' not in '${arch_sane}'" 1>&2
            sane=false
        fi

        case "${sane}" in
            true) ;;
            false)
                echo 'WARNING: This system configuration is untested. Let us know if it works.' 1>&2
                ;;
        esac
        ;;

    false) ;;
esac

apt-get update

# These are essential on ubuntu
essential="\
    bzip2 \
    gzip \
    tar \
    wget \
"

# And we need these when on 64-bit Ubuntu ...
amd64_specific="\
    g++-multilib \
    gcc-multilib \
    libc6-dev-i386 \
    zlib1g:i386 \
"

[ "${arch}" = amd64 ] && essential="${essential} ${amd64_specific}"

apt-get install --yes \
    ${essential} \
    bison \
    build-essential \
    chrpath \
    diffstat \
    gawk \
    git \
    language-pack-en \
    python3 \
    subversion \
    texi2html \
    texinfo \

