fs    = require 'fs'
iconv = require 'iconv-lite'

module.exports =

  activate: (state) ->
    atom.workspaceView.command "convert-to-utf8:shift_jis", =>  @open 'shift_jis'
    atom.workspaceView.command "convert-to-utf8:euc-jp", =>     @open 'euc-jp'
    atom.workspaceView.command "convert-to-utf8:cp932", =>      @open 'cp932'
    atom.workspaceView.command "convert-to-utf8:gbk", =>        @open 'gbk'
    atom.workspaceView.command "convert-to-utf8:big5", =>       @open 'big5'
    atom.workspaceView.command "convert-to-utf8:big5-hkscs", => @open 'big5-hkscs'
    atom.workspaceView.command "convert-to-utf8:euc-kr", =>     @open 'euc-kr'
    atom.workspaceView.command "convert-to-utf8:utf-8", =>      @open 'utf-8'

  deactivate: ->
    #@convertToUtf8View.destroy()

  serialize: ->
    #convertToUtf8ViewState: @convertToUtf8View.serialize()

  open: (encoding) ->
    editor = atom.workspace.getActiveEditor()
    uri = editor.getUri()
    buffer = fs.readFileSync(uri)
    convertedText = iconv.decode buffer, encoding
    editor.setText convertedText
    # atom.workspace.saveActivePaneItem()

  save: (encoding) ->
    editor = atom.workspace.getActiveEditor()
    uri = editor.getUri()
    buffer = fs.readFileSync(uri)
    data = buffer.toString 'UTF8'
    buf = iconv.encode data, encoding
    fs.writeFileSync( uri, buf )
