# MisybaG baselayout

MisybaG baselayout is, as its name may make it guessed, the base layout for the project MisybaG.

# Language/langue

Because French is my native language, finding all documents and messages in French is not an option. Other translations are welcome.

Anyway, because English is the language of programming, the code, including variable names and comments, are in English.

:fr: Une version française de ce document se trouve [ici](doc/fr/README.md).

# Licence

Copyright © 2016 Stéphane Veyret stephane_DOT_veyret_AT_neptura_DOT_org

MisybaG baselayout is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

MisybaG baselayout is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with MisybaG baselayout.  If not, see <http://www.gnu.org/licenses/>.

Some files are inspired from Gentoo sys-apps/baselayout and are protected under GPLv2 or in public domain.

# File types

Base file system have 3 file types:
* Computer independent files which should not, normally, be modified. Those files generally use other files containing system dependent configuration. These files may be updated for corrections or improvements.
* Base files, required for system functioning, but with a different life on each computer. Those files contains system dependent data and should therefore not be updated. They are delivered with “template” extension. Either this extension can be removed when installing a new system, or files with this extension can be ignored for an update.
* Pure configuration files, not required for system functioning. These files should be installed in the system from another source and must therefore not be in MisybaG baselayout.

# Services startup

Gentoo support two initialization modes: OpenRC and systemd. When the systemd _use flag_ is not set, packages consider they are installed in an OpenRC system. This is the choice done with MisybaG, but because we want to keep the system very minimalist and so no initialization system is really installed, a script called /sbin/openrc-run, which purpose is to allow starting of initialization scripts as if OpenRC was present, is installed. This script does not anyway match all the specification of the real software installed with OpenRC. For example, it does not manage service dependencies, neither it is able to give the state of a service.

The file named /lib/gentoo/service-functions is provided to give some helpful functions to scripts invoked during initialization. It should be sourced by these scripts.

The file named /etc/init.d/rcS is the first one called at system startup. It is the one starting services.

As with OpenRC, the directory /etc/runlevel contains links to the service startup OpenRC scripts, usually living in /etc/init.d. Those links are usually preceded with an order number and reside in the sub-directory boot for services which should be started when system is booting. A sub-directory called after, itself containing directories named as some services, is also present to allow services to be started after other services are fully started. It can be used as a workaround for the lack of service dependency.

Network management required files are provided. They are written to automatically connect to a DHCP network on port eth0. This behavior is managed by the /etc/init.d/network script, associated to the /etc/conf.d/network configuration file. It uses ifplugd (to detect network connection) and udhcpc (to manage DHCP leases) busybox services.

# Login

When login into the system, the script /etc/profile is executed. In contrary to a classical Gentoo system, this script will directly read and source all files which are in /etc/env.d directory, exporting all defined variable. It is therefore useless to execute env-update. Before terminating, /etc/profile sources all files of the directory /etc/profile.d which are terminated with .sh extension, as on a Gentoo classical system.

The file named 50editor, which defines vi as default editor, is pre-installed in env.d.
