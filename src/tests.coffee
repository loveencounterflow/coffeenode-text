


############################################################################################################
TEXT                      = require './main'
# TYPES                     = require 'coffeenode-types'
TRM                       = require 'coffeenode-trm'
log                       = TRM.log.bind TRM
#...........................................................................................................
assert                    = require 'assert'



#-----------------------------------------------------------------------------------------------------------
@main = ->
  do @test_lines_splitting


#-----------------------------------------------------------------------------------------------------------
@test_lines_splitting = ->
  assert.deepEqual ( TEXT.lines_of 'helo world'             ), [ 'helo world' ]
  assert.deepEqual ( TEXT.lines_of 'helo world\n'           ), [ 'helo world', '' ]
  assert.deepEqual ( TEXT.lines_of 'helo world\nhowdy'      ), [ 'helo world', 'howdy' ]
  assert.deepEqual ( TEXT.lines_of 'helo world\rhowdy'      ), [ 'helo world', 'howdy' ]
  assert.deepEqual ( TEXT.lines_of 'helo world\r\nhowdy'    ), [ 'helo world', 'howdy' ]
  assert.deepEqual ( TEXT.lines_of 'helo world\n\rhowdy'    ), [ 'helo world', '', 'howdy' ]
  assert.deepEqual ( TEXT.lines_of '\nhelo world\n\rhowdy'  ), [ '', 'helo world', '', 'howdy' ]
  assert.deepEqual ( TEXT.lines_of 'a\u0085b\u2028c\u2029d' ), [ 'a', 'b', 'c', 'd' ]


throw new Error "work in progress"
############################################################################################################
templates = [
  "helo name"
  "helo ${name}"
  "helo \\${name}"
  "helo ${{name}}"
  "helo ${name:quoted}"
  "helo $name:quoted"
  "helo $name!"
  "helo +name!"
  "helo +(name:quoted)!"
  "helo !+name!"
  "helo !+(name:quoted)!"
  ]

data =
  'name':   'Jim'
formats =
  'quoted': ( text ) -> return '"' + text + '"'

for template in templates
  log ( TRM.green 'A' ), ( TRM.grey template ), ( TRM.gold @fill_in template, data, formats )

custom_fill_in = @fill_in.create null, '+', '(', ')', '~', '!'
for template in templates
  log ( TRM.red 'B' ), ( TRM.grey template ), ( TRM.gold custom_fill_in template, data, formats )






############################################################################################################
do @main
