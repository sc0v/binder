import { Controller } from '@hotwired/stimulus';
import { DateTime } from 'luxon';
window.DateTime = DateTime;
import {TabulatorFull as Tabulator } from 'tabulator-tables';

export default class extends Controller {
  connect() {
    const e = document.createElement('div');
    const config = JSON.parse(this.element.dataset.config);
    const table = new Tabulator(e, config);
    this.element.replaceChildren(e);
  }
}
