/*global i18n */
import React from 'react';
import PremiumPlan from './PremiumPlan';
import PopupArea from '../Popup/Area';
import Popup from '../Popup';

function SelectPremiumPlanPopup({ onClose }) {
  return (
    <PopupArea onClose={onClose}>
      <Popup
        className="popup--premium popup--dark"
        clue="selectPremiumPlanPopup"
        onClose={onClose}
        title=""
      >
        <div>
          <div
            className="popup-premium__title"
            dangerouslySetInnerHTML={{ __html: i18n.t('premium_popup.title') }}
          />
          <div className="popup-premium__description">
            {i18n.t('premium_popup.support_description')}
          </div>
          <div className="popup-premium__plans-container">
            <PremiumPlan
              i18nPlanKey="month"
              months={1}
            />
            <PremiumPlan
              i18nPlanKey="year"
              months={12}
              recommended
            />
          </div>
        </div>
      </Popup>
    </PopupArea>
  );
}

SelectPremiumPlanPopup.displayName = 'GetPremiumPopup';

SelectPremiumPlanPopup.propTypes = {
  onClose: PropTypes.func.isRequired,
};

export default SelectPremiumPlanPopup;
