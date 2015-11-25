DOM = React.DOM

##########
# Image component
Image = React.createClass
  displayName: "Image"

  render: ->
    DOM.img
      src: @props.imageSource
      className: @props.imageClass
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

$ ->
  source = document.getElementById("react-source-for-lightbox")
  container = document.getElementById("react-target-for-lightbox")
  # json_parsed_content = JSON.parse( source.dataset.imagesource )
  imageSource = source.dataset.imageSource
  imageClass = source.dataset.imageClass
  imageAltInitial = source.dataset.imageAlt.replace(/^\s+|\s+$/g,'')
  # Get rid of the extra wrapping span added by the Engine on editable_text
  imageAltInitial = if imageAltInitial.match(/\>(.*)\</) then imageAltInitial.match(/\>(.*)\</)[1].replace(/^\s+|\s+$/g,'') else imageAltInitial.replace(/^\s+|\s+$/g,'')
  imgBoxClass = source.dataset.imageBoxClass
  ReactDOM.render(
    React.createElement LightBox,
      imageSource: imageSource
      imageClass: imageClass
      imageAltInitial: imageAltInitial
      imgBoxClass: imgBoxClass
    container
  )

# This is what the container should look like before render
# <div
#   id="react-source-for-lightbox"
#   data-image-source="json_data_set">
# </div>
# <div
#   id="react-target-for-lightbox">
# </div>
