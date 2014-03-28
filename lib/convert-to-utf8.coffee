fs    = require 'fs'
jconv = require 'jconv'

module.exports =

  activate: (state) ->
    atom.workspaceView.command "convert-to-utf8:open_shift_jis", => @open_shift_jis()
    atom.workspaceView.command "convert-to-utf8:save_shift_jis", => @save_shift_jis()

  deactivate: ->
    #@convertToUtf8View.destroy()

  serialize: ->
    #convertToUtf8ViewState: @convertToUtf8View.serialize()

  open_shift_jis: ->
    editor = atom.workspace.getActiveEditor()
    uri = editor.getUri()
    buffer = fs.readFileSync(uri)
    text = jconv.convert( buffer, 'SJIS', 'UTF8' )
    convertedText = text.toString('UTF8')
    atom.workspace.getActiveEditor().setText(convertedText)
    atom.workspace.saveActivePaneItem()

  save_shift_jis: ->
    editor = atom.workspace.getActiveEditor()
    uri = editor.getUri()
    buffer = fs.readFileSync(uri)
    text = jconv.convert( buffer, 'UTF8', 'SJIS' )
    convertedText = text.toString('BINARY');
    fs.writeFileSync( uri, text )
