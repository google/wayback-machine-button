// Copyright 2019 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License"); you may not
// use this file except in compliance with the License. You may obtain a copy of
// the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
// WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
// License for the specific language governing permissions and limitations under
// the License.

const DEFAULT_OPTIONS = {
  clickBehavior: 'search',
};

document.addEventListener('DOMContentLoaded', function() {
  chrome.storage.sync.get(DEFAULT_OPTIONS, function(items) {
    for (let button of document.forms.clickBehavior) {
      if (button.value == items.clickBehavior) {
        button.checked = true;
        break;
      }
    }
  });
});

function saveOptions() {
  let clickBehavior = DEFAULT_OPTIONS.clickBehavior;
  for (let button of document.forms.clickBehavior) {
    if (button.checked) {
      clickBehavior = button.value;
      break;
    }
  }
  chrome.storage.sync.set({
    clickBehavior: clickBehavior,
  });
}

for (let button of document.forms.clickBehavior) {
  button.addEventListener('change', function(event) {
    saveOptions();
  });
}
