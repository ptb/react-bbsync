((root, factory) ->
  if typeof define is 'function' and define.amd
    define ['react', 'backbone'], factory
  else if typeof exports is 'object'
    module.exports = factory(require('react'), require('backbone'))
  else
    root.ReactBackboneShim = factory(root.React, root.Backbone)
) this, (React, Backbone) ->

  propTypes:
    model: React.PropTypes.instanceOf(Backbone.Model).isRequired

  getInitialState: ->
    return @props.model.attributes

  updateState: (model) ->
    @setState model.attributes

  componentDidMount: ->
    @props.model.on 'add change remove', @updateState, @

  componentWillReceiveProps: (props) ->
    @updateState props.model

  componentWillUnmount: ->
    @props.model.off 'add change remove', @updateState, @
