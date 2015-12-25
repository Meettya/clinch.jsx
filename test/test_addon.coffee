###
Test suite for addon
###
_     = require 'lodash'
fs    = require 'fs'
path  = require 'path'
vm    = require 'vm'

React          = require 'react'
ReactDOMServer = require 'react-dom/server'

CoffeeScript = require 'coffee-script'

lib_path = GLOBAL?.lib_path || ''

fixtures      = path.join __dirname, "fixtures"
fixturesOk    = path.join fixtures,  "component.jsx"
fixturesOk6   = path.join fixtures,  "component_es6.jsx"
fixturesOkCS  = path.join fixtures,  "component.coffee"
fixturesErr   = path.join fixtures,  "with_error.jsx"

results = 
  ok : '<div class="message"><p>Hello Bender!!!</p></div>'

# get addon
adon_file  = 'addon'
addon_path = path.join lib_path, adon_file
Compiller  = require addon_path

READ_OPTIONS = encoding : 'utf8'

describe 'Addon:', ->

  describe 'called without options', ->

    it 'should export "extension" and "processor"', ->
      expect(Compiller).to.have.all.keys ['extension', 'processor']

    it 'should export string as "extension"', ->
      expect(Compiller.extension).to.be.a 'string'

    it 'should export function as "processor"', ->
      expect(Compiller.processor).to.be.a 'function'

  describe 'called with options', ->

    it 'should export "extension" and "processor"', ->
      expect(Compiller harmony: yes).to.have.all.keys ['extension', 'processor']

    it 'should export string as "extension"', ->
      expect(Compiller(harmony: yes).extension).to.be.a 'string'

    it 'should export function as "processor"', ->
      expect(Compiller(harmony: yes).processor).to.be.a 'function'

  describe 'as addon', ->

    it 'should export correct file extension ".jsx"', ->
      expect(Compiller.extension).to.equal '.jsx'

    it 'should compile correct .jsx file as ES3 module', (done) ->
      fs.readFile fixturesOk, READ_OPTIONS, (err, data) ->
        expect(err).to.be.null
        expect(data).to.be.a 'string'
        Compiller.processor data, fixturesOk, (err, code) ->
          expect(err).to.be.null
          expect(code).to.be.a 'string'
          # test result
          vm.runInNewContext code, sandbox = { React, module:exports:null }
          react_comp = sandbox.module.exports
          MyComp     = React.createFactory react_comp
          reactHtml  = ReactDOMServer.renderToStaticMarkup MyComp name : 'Bender'
          #console.log reactHtml
          expect(reactHtml).to.equal results.ok

          done()

    it 'should compile correct .jsx file as ES6 module (with "es2015" option)', (done) ->
      fs.readFile fixturesOk6, READ_OPTIONS, (err, data) ->
        expect(err).to.be.null
        expect(data).to.be.a 'string'
        { processor } = Compiller es2015 : yes
        processor data, fixturesOk6, (err, code) ->
          expect(err).to.be.null
          expect(code).to.be.a 'string'
          # test result
          vm.runInNewContext code, sandbox = { React, module:exports:null }
          react_comp = sandbox.module.exports
          MyComp     = React.createFactory react_comp
          reactHtml  = ReactDOMServer.renderToStaticMarkup MyComp name : 'Bender'
          # console.log reactHtml
          expect(reactHtml).to.equal results.ok

          done()

    it 'should compile correct .coffee -> .js file as CS-pattern module', (done) ->
      fs.readFile fixturesOkCS, READ_OPTIONS, (err, data) ->
        expect(err).to.be.null
        expect(data).to.be.a 'string'
        compiled = CoffeeScript.compile data
        Compiller.processor compiled, fixturesOkCS, (err, code) ->
          expect(err).to.be.null
          expect(code).to.be.a 'string'
          # test result
          vm.runInNewContext code, sandbox = { React, module:exports:null }
          react_comp = sandbox.module.exports
          MyComp     = React.createFactory react_comp
          reactHtml  = ReactDOMServer.renderToStaticMarkup MyComp name : 'Bender'
          #console.log reactHtml
          expect(reactHtml).to.equal results.ok

          done()

    it 'should return error on incorrect .jsx file', (done) ->
      fs.readFile fixturesErr, READ_OPTIONS, (err, data) ->
        expect(err).to.be.null
        expect(data).to.be.a 'string'
        Compiller.processor data, fixturesErr, (err, code) ->
          # console.log err
          expect(err).to.be.an.instanceof Error

          done()
