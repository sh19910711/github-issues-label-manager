#!/bin/sh

pattern=
if [ $# -gt 0 ]; then
  pattern="-g $@"
fi

mocha --reporter tap --compilers coffee:coffee-script -r spec/spec_helper.coffee $pattern spec/src/**/*_spec.coffee

