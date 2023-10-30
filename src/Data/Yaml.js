"use strict";

import {load, dump} from "js-yaml";

export function parseFromYamlImpl(left, right, string) {
  try {
    return right(load(string));
  } catch (e) {
    return left(e.toString());
  }
};

export function printToYaml(json) {
  return dump(json, { noRefs: true, lineWidth: -1, noCompatMode: true, sortKeys: true });
};
