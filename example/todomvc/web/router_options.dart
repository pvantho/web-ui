// Copyright (c) 2013, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library router_options;

import 'dart:html';
import 'package:polymer/polymer.dart';

/**
 * Given a set of child links to this page, this will add the "selected" CSS
 * class to the link that matches window.location.hash.
 *
 * For example, if the current window.location.hash is "#/completed" and we
 * have a tag like `<a href="#/completed">` it will get the class
 * `class="selected"`, and other links will have that CSS class removed.
 */
class RouterOptions extends CustomElement {

  var _sub;

  void inserted() {
    super.inserted();

    var anchors = this.queryAll('a');

    _updateHash(records) {
      var hash = window.location.hash;
      if (hash == '') hash = '#/';
      for (var a in anchors) {
        if (a.hash == hash) {
          a.classes.add('selected');
        } else {
          a.classes.remove('selected');
        }
      }
    }

    _updateHash(null);
    _sub = windowLocation.changes.listen(_updateHash);
  }

  void removed() {
    _sub.cancel();
    super.removed();
  }
}
