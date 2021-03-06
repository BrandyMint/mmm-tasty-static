import React from 'react';
import sinon from 'sinon';
import { expect } from 'chai';
import Notify from '../../../../../app/scripts/mobile/react/components/alerts/notify';
import { renderIntoDocument } from 'react-addons-test-utils';

describe('[Component] Notify', () => {
  it('should render without errors', () => {
    const renderedComponent = renderIntoDocument(
      <Notify text="Hello!" onClose={sinon.spy()} />
    );
    expect(renderedComponent).to.be.an('object');
  });
});
