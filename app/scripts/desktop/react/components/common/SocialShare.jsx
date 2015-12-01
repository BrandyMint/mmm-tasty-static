/*global i18n */
import React, { Component, PropTypes } from 'react';
import Tooltip from './Tooltip';

const defaultImg = 'http://taaasty.com/favicons/mstile-310x310.png';

class SocialShare extends Component {
  state = {
    title: '',
  }
  componentWillMount() {
    this.titleEl = document.createElement('div');
    this.setState({ title: this.parseTitle(this.props.title) });
  }
  componentWillUpdate(nextProps) {
    this.setState({ title: this.parseTitle(nextProps.title) });
  }
  parseTitle(title) {
    if (!title) {
      return i18n.t('tasty');
    }
    const el = this.titleEl;

    el.innerHtml = title;
    return el.innerText || el.text || el.textContent;
  }
  render() {
    const { img, url } = this.props;
    const { title } = this.state;
    const eImg = window.encodeURIComponent(img);
    const eTitle = window.encodeURIComponent(title);
    const eUrl = window.encodeURIComponent(url);

    return (
      <div className="social-share">
        <a
          href={`https://www.facebook.com/sharer/sharer.php?u=${eUrl}`}
          target="_blank"
        >
          <Tooltip
              placement="left"
              title={i18n.t('buttons.share.fb')}
          >
            <button className="social-share-facebook-button">
              fb
            </button>
          </Tooltip>
        </a>
        <a
          href={`http://vkontakte.ru/share.php?url=${eUrl}&title=${eTitle}&image=${eImg}`}
          target="_blank"
        >
          <Tooltip
              placement="left"
              title={i18n.t('buttons.share.vk')}
          >
            <button className="social-share-vkontakte-button">
              vk
            </button>
          </Tooltip>
        </a>
        <a
          href={`http://twitter.com/share?url=${eUrl}&text=${eTitle}`}
          target="_blank"
        >
          <Tooltip
              placement="left"
              title={i18n.t('buttons.share.twitter')}
          >
            <button className="social-share-twitter-button">
              t
            </button>
          </Tooltip>
        </a>
      </div>
    );
  }
}

SocialShare.propTypes = {
  img: PropTypes.string.isRequired,
  title: PropTypes.string.isRequired,
  url: PropTypes.string.isRequired,
};

SocialShare.defaultProps = {
  img: defaultImg,
};

export default SocialShare;
