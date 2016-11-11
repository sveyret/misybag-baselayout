###############################################################################
# Copyright © 2016 Stéphane Veyret stephane_DOT_veyret_AT_neptura_DOT_org
#
# This file is part of MisybaG baselayout.
#
# MisybaG baselayout is free software: you can redistribute it and/or modify it
# under the terms of the GNU General Public License as published by the Free
# Software Foundation, either version 3 of the License, or (at your option) any
# later version.
#
# MisybaG baselayout is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
# FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
# details.
#
# You should have received a copy of the GNU General Public License along with
# MisybaG baselayout.  If not, see <http://www.gnu.org/licenses/>.
###############################################################################

all:

install:
	cp -dPR --preserve=mode -- layout/* "${DESTDIR}"
	for dir in $$(find "${DESTDIR}" -type d); do \
		[[ -r "$${dir}/.keep" ]] && rm -f "$${dir}/.keep"; \
		if [[ -r "$${dir}/.git-chmod" ]]; then \
			pushd "$${dir}"; \
			while read chcmd; do \
				chmod $${chcmd}; \
			done <.git-chmod; \
			rm -f .git-chmod; \
			popd; \
		fi; \
	done

keep:
	for dir in $$(find . -type d); do \
		[[ "$$(ls -A $${dir})" ]] || touch "$${dir}/.keep"; \
	done

.PHONY: all install keep

