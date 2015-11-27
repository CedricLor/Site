DOM = React.DOM

##########
# Image component
Image = React.createClass
  displayName: "Image"

  render: ->
    DOM.img
      src: @props.imageSource
      className: "#{@props.imageClass} img-thumbnail"
      alt: @props.imageAlt
      onClick: @props.handleClick

##########
# LightBox component
LightBox = React.createClass
  displayName: "LightBox"
  getInitialState: ->
    clicked: false
    imageAlt: @props.imageAltInitial

  getDefaultProps: ->
    lightBoxClass: {
      true: "lightbox",
      false: ""
    }
    imgSizeClass: {
      true: "img-enlarged",
      false: "img-belittled"
    }
    imageAltAddition: {
      true: "Enlarged ",
      false: ""
    }

  handleClickOnImg: (event) ->
    clicked = if @state.clicked == false then true else false
    @setState clicked: clicked

  handleClickOnDiv: (event) ->
    clicked = if @state.clicked == true then @handleClickOnImg()

  render: ->
    DOM.div
      onClick: @handleClickOnDiv
      className: "#{@props.imgBoxClass} #{@props.lightBoxClass[@state.clicked]}"
      React.createElement Image,
        handleClick: @handleClickOnImg
        imageSource: @props.imageSource
        imageClass: "#{@props.imageClass} #{@props.imgSizeClass[@state.clicked]}"
        imageAlt: "#{@state.imageAlt} #{@props.imageAltAddition[@state.clicked]}"
      DOM.p null, "#{@state.imageAlt}"


create_light_box_with = (dom_element) ->
  # json_parsed_content = JSON.parse( source.dataset.imagesource )
  imageSource = dom_element.dataset.imageSource
  # imageSource = if decodeURIComponent(imageSource).match(/src=\"(.*)\"/) then decodeURIComponent(imageSource).match(/src=\"(.*)\"/)[1]
  imageClass = dom_element.dataset.imageClass
  imageAltInitial = dom_element.dataset.imageAlt.replace(/^\s+|\s+$/g,'')
  # Get rid of the extra wrapping span added by the Engine on editable_text
  imageAltInitial = if imageAltInitial.match(/\>(.*)\</) then imageAltInitial.match(/\>(.*)\</)[1].replace(/^\s+|\s+$/g,'') else imageAltInitial.replace(/^\s+|\s+$/g,'')
  imgBoxClass = dom_element.dataset.imageBoxClass
  ReactDOM.render(
    React.createElement LightBox,
      imageSource: imageSource
      imageClass: imageClass
      imageAltInitial: imageAltInitial
      imgBoxClass: imgBoxClass
    dom_element
  )

$ ->
  dom_elements = document.getElementsByClassName("react-lightbox")
  create_light_box_with dom_element for dom_element in dom_elements
