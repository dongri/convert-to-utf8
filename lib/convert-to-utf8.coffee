fs    = require 'fs'
iconv = require 'iconv-lite'

module.exports =

  activate: (state) ->
    atom.commands.add 'atom-workspace', "convert-to-utf8:shift_jis", =>  @open 'shift_jis'
    atom.commands.add 'atom-workspace', "convert-to-utf8:euc-jp", =>     @open 'euc-jp'
    atom.commands.add 'atom-workspace', "convert-to-utf8:cp932", =>      @open 'cp932'
    atom.commands.add 'atom-workspace', "convert-to-utf8:gbk", =>        @open 'gbk'
    atom.commands.add 'atom-workspace', "convert-to-utf8:big5", =>       @open 'big5'
    atom.commands.add 'atom-workspace', "convert-to-utf8:big5-hkscs", => @open 'big5-hkscs'
    atom.commands.add 'atom-workspace', "convert-to-utf8:euc-kr", =>     @open 'euc-kr'
    atom.commands.add 'atom-workspace', "convert-to-utf8:utf-8", =>      @open 'utf-8'

  deactivate: ->
    #@convertToUtf8View.destroy()

  serialize: ->
    #convertToUtf8ViewState: @convertToUtf8View.serialize()

  open: (encoding) ->
    workspace = atom.workspace
    editor = workspace.getActiveTextEditor()
    path = editor.getPath()
    buffer = fs.readFileSync(path)
    convertedText = iconv.decode buffer, encoding
    editor.setText convertedText
    # atom.workspace.saveActivePaneItem()

  save: (encoding) ->
    workspace = atom.workspace
    editor = workspace.getActiveTextEditor()
    path = editor.getPath()
    buffer = fs.readFileSync(path)
    data = buffer.toString 'UTF8'
    buf = iconv.encode data, encoding
    fs.writeFileSync( uri, buf )
