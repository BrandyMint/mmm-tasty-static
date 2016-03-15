/*global i18n */
import React, { PropTypes } from 'react';
import classNames from 'classnames';
import EditorTypeSwitcherItem from './TypeSwitcherItem';
import {
  EDITOR_ENTRY_TYPE_TEXT,
  EDITOR_ENTRY_TYPE_ANONYMOUS,
  EDITOR_ENTRY_TYPE_IMAGE,
  EDITOR_ENTRY_TYPE_INSTAGRAM,
  EDITOR_ENTRY_TYPE_MUSIC,
  EDITOR_ENTRY_TYPE_VIDEO,
  EDITOR_ENTRY_TYPE_QUOTE,
  EDITOR_ENTRY_TYPES,
} from '../../../constants/EditorConstants';

const typeMap = {
  [EDITOR_ENTRY_TYPE_TEXT]: {
    title: () => i18n.t('editor_text_type'),
    icon: 'icon--text-circle',
  },
  [EDITOR_ENTRY_TYPE_ANONYMOUS]: {
    title: () => i18n.t('editor_anonymous_type'),
    icon: 'icon--text-circle',
  },
  [EDITOR_ENTRY_TYPE_IMAGE]: {
    title: () => i18n.t('editor_image_type'),
    icon: 'icon--image-circle',
  },
  [EDITOR_ENTRY_TYPE_INSTAGRAM]: {
    title: () => i18n.t('editor_instagram_type'),
    icon: 'icon--instagram-circle',
  },
  [EDITOR_ENTRY_TYPE_MUSIC]: {
    title: () => i18n.t('editor_music_type'),
    icon: 'icon--music-circle',
  },
  [EDITOR_ENTRY_TYPE_VIDEO]: {
    title: () => i18n.t('editor_video_type'),
    icon: 'icon--video-circle',
  },
  [EDITOR_ENTRY_TYPE_QUOTE]: {
    title: () => i18n.t('editor_quote_type'),
    icon: 'icon--quote-circle',
  },
};

function EditorTypeSwitcher({ canChangeType, entryType, loading, location }) {
  const switcherClasses = classNames('nav-types', {
    'state--loading': loading,
  });

  return (
    <nav className={switcherClasses}>
      {canChangeType
       ? EDITOR_ENTRY_TYPES.map((type) =>
         <EditorTypeSwitcherItem
           active={entryType === type}
           icon={typeMap[type].icon}
           key={type}
           location={location}                  
           title={typeMap[type].title()}
           type={type}
         />)
       : <EditorTypeSwitcherItem
           active
           icon={typeMap[entryType].icon}
           location={location}
           title={typeMap[entryType].title()}
         />
      }
    </nav>
  );
}

EditorTypeSwitcher.propTypes = {
  canChangeType: PropTypes.bool.isRequired,
  entryType: PropTypes.string.isRequired,
  loading: PropTypes.bool.isRequired,
  location: PropTypes.object.isRequired,
};

export default EditorTypeSwitcher;
