# Copyright 2017 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License"); you may not
# use this file except in compliance with the License. You may obtain a copy of
# the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
# License for the specific language governing permissions and limitations under
# the License.

NAME = wayback_machine_button

FILES = background.js manifest.json options.html options.js $(ICONS)
ICONS = icon128.png icon16.png icon48.png

.PHONY: all
all: $(NAME).zip icon_bordered.png

$(NAME).zip: $(FILES)
	mkdir $(NAME)
	cp -al $(FILES) $(NAME)
	zip -9r $(NAME) $(NAME)
	$(RM) -r $(NAME)

.PHONY: unpacked
unpacked: $(FILES)

EXPORT.svg = \
  inkscape --export-png=$@.uncrushed --export-area-page --export-width=$(ICON_WIDTH) $< >/dev/null; \
  pngcrush -c 4 -q $@.uncrushed $@; \
  $(RM) $@.uncrushed
icon%.png: ICON_WIDTH = $*
icon%.png: third_party/icon.svg
	$(EXPORT.svg)

icon_bordered.png: ICON_WIDTH = 128
icon_bordered.png: third_party/icon_bordered.svg
	$(EXPORT.svg)

.PHONY: clean
clean:
	$(RM) -r $(NAME).zip $(NAME) $(ICONS) icon_bordered.png
