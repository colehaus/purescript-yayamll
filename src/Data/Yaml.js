"use strict";

var yaml = require('js-yaml');

exports.parseFromYamlImpl = function(left, right, string) {
  try {
    return right(yaml.safeLoad(string));
  } catch (e) {
    return left(e.toString());
  }
};

exports.printToYaml = function(json) {
  return yaml.safeDump(json, { noRefs: true, lineWidth: -1, noCompatMode: true, sortKeys: true });
};
