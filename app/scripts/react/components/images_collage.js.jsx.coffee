###* @jsx React.DOM ###

FIRST_ROW_RATIO = 2.5
NEXT_ROWS_RATIO = 4

window.ImagesCollage = React.createClass
  #mixins: [React.addons.PureRenderMixin]
  propTypes:
    images:     React.PropTypes.array.isRequired
    waitForAll: React.PropTypes.bool
    activitiesHandler: React.PropTypes.object

  getDefaultProps: ->
    waitForAll: true

  getInitialState: ->
    width:      null
    images:     []
    initialId:  0

  componentWillReceiveProps: (nextProps) ->
    @loadImages nextProps.images

  componentDidMount: ->
    @setState width: $(@getDOMNode()).width()
    @loadImages @props.images

  #loadImagesByUrl: ->
    #imageElements = @props.imageUrls.map (src) =>
      #image = new Image src: src
      #image.src = src
      #ImagesLoaded(image).on 'done', (instance) =>
        #@state.images.push image
        #@setState images: @state.images

  loadImages: (imagesToLoad) ->
    currentInitialId = @state.initialId + 1

    @setState images: [], initialId: currentInitialId

    imagesToLoad.map (image) =>
      ImagesLoaded(image).on 'done', (instance) =>
        return unless @isMounted()
        if currentInitialId == @state.initialId
          @state.images.push image
          @setState images: @state.images
        else
          console.debug? 'later image loaded', currentInitialId, @state.initialId

  render: ->
    if @shouldRenderCollage()
      #return `<ImagesCollage_Images images={this.state.images} width={this.state.width}/>`
      return `<ImagesCollage_Legacy images={this.state.images} width={this.state.width}/>`
    else
      return `<div className='collage-empty-loading' />`

  shouldRenderCollage: ->
    return false unless @state.width > 0
    if @props.waitForAll
      return @state.images.length == @props.images.length
    else
      return @state.images.length > 0


window.ImagesCollage_Legacy = React.createClass
  #mixins: [React.addons.PureRenderMixin]
  propTypes:
    images: React.PropTypes.array.isRequired

  shouldComponentUpdate: (nextProps, nextState) ->
    return true unless nextProps.images.length==@props.images.length
    currentUrls = @props.images.map (i) -> i.src
    nextUrls = nextProps.images.map (i) -> i.src
    return currentUrls != nextUrls

  componentDidMount: ->
    @$node = $ @getDOMNode()

    @$node.collage
      item: ".collage__item"     # блок с картинкой
      img: ".collage__item-img"  # селектор на картинку внутри item

      lastClass: "is--last"      # последний в строке
      prefix: "collage--"        # выставляются классы big, когда идёт сначала большая картинка - collage--big

      margin: 0                  # отступы между картинками
      preload: true              # сами грузятся картинки или уже загружены на странице

  componentDidUpdate: ->
    @$node.collage('update') if @isMounted()

  render: ->
    key = 0
    elements = @props.images.map (image) ->
      key +=1
      `<a className="collage__item js-collage-item js-fancybox" key={key} href={image.src} data-fancybox-group={key} target="_blank">
        <img className="collage__item-img js-collage-item-img" src={image.src}/>
      </a>`

    `<div className="collage">{elements}</div>`


