import React, { Component, PropTypes } from 'react';
import EditorMediaBoxActions from '../../MediaBox/Actions';
import ImageAttachmentsCollage from '../../../../../../shared/react/components/common/imageAttachmentsCollage';

class EditorTypeImageLoaded extends Component {
  shouldComponentUpdate(nextProps) {
    //  Не обновляем компонент, если количество аттачментов или путь до картинки
    //  остались прежними. Тем самым избавляемся от перерисовки blob => remote image url
    return (
      this.props.imageAttachments.count() !== nextProps.imageAttachments.count() ||
      this.props.imageUrl !== nextProps.imageUrl
    );
  }
  renderImage() {
    const { imageAttachments, imageUrl } = this.props;

    if (imageAttachments.count() > 0) {
      return <ImageAttachmentsCollage imageAttachments={imageAttachments.toJS()} />;
    } else if (imageUrl) {
      return <img src={imageUrl} />;
    } else {
      return null;
    }
  }
  render() {
    const {
      imageAttachments,
      imageUrl,
      onDelete,
     } = this.props;
     const showDeleteButton = (
       typeof onDelete === 'function' && (
         imageUrl || imageAttachments.count()
       )
     );

    return (
      <div className="media-box__display">
        {this.renderImage()}
        {showDeleteButton && (
          <EditorMediaBoxActions onDelete={onDelete} />
        )}
      </div>
    );
  }
}

EditorTypeImageLoaded.propTypes = {
  imageAttachments: PropTypes.object.isRequired,
  imageUrl: PropTypes.string,
  onDelete: PropTypes.func.isRequired,
};

export default EditorTypeImageLoaded;
